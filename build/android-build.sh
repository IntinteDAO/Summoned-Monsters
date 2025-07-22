#!/bin/bash

# STOP THE SCRIPT IMMEDIATELY IF AN ERROR OCCURS
set -e

# ==============================================================================
# SECTION 1: VARIABLE CONFIGURATION
# ==============================================================================
# NDK version (r21d) is required by the project documentation
NDK_VERSION="21.3.6528147"
COMMANDLINE_TOOLS_VERSION="9645777"
ANDROID_SDK_PLATFORM="35"
ANDROID_BUILD_TOOLS="34.0.0"

# Path to the SDK - we use an absolute path to avoid issues.
SDK_DIR="/home/fervi/Intinte/Summoned-Monsters/build/android-sdk"

# Path to Java
export JAVA_HOME=/usr/lib/jvm/java-1.17.0-openjdk-amd64

# ==============================================================================
# SECTION 2: AGGRESSIVE CLEANUP (THE MOST IMPORTANT STEP!)
# ==============================================================================
echo "### STEP 1: Thoroughly cleaning the environment..."
# Removing project directories
rm -rf YGOMobile-cn-ko-en
rm -rf script
rm -rf pics
rm -f *.zip *.tar.bz2

# Removing the entire old SDK to avoid installation issues
rm -rf "${SDK_DIR}"
# Removing downloaded tools
rm -rf cmdline-tools

# Stopping the Gradle daemon and clearing its global cache
echo "### Clearing Gradle cache..."
if [ -f "YGOMobile-cn-ko-en/gradlew" ]; then
    (cd YGOMobile-cn-ko-en && ./gradlew --stop) || true
fi
rm -rf ~/.gradle/caches/
rm -rf ~/.gradle/daemon/

echo "### Cleanup finished. Starting from scratch."
echo "-----------------------------------------------------"

# ==============================================================================
# SECTION 3: ENVIRONMENT AND DEPENDENCY PREPARATION
# ==============================================================================
echo "### STEP 2: Preparing environment and dependencies..."

# Verifying files from cardgenerator
if [ ! -d ../cardgenerator/output ]; then
    echo "ERROR: You must first generate game files using cardgenerator!"
    exit 1
fi

# Downloading source code and tools
git clone https://github.com/fallenstardust/YGOMobile-cn-ko-en
chmod +x YGOMobile-cn-ko-en/gradlew
wget "https://dl.google.com/android/repository/commandlinetools-linux-${COMMANDLINE_TOOLS_VERSION}_latest.zip"
unzip -q "commandlinetools-linux-${COMMANDLINE_TOOLS_VERSION}_latest.zip"

# Creating the SDK directory and installing required components
mkdir -p "${SDK_DIR}"
echo "### Installing Android SDK components... (this may take a while)"
yes | ./cmdline-tools/bin/sdkmanager --sdk_root="${SDK_DIR}" "platforms;android-${ANDROID_SDK_PLATFORM}" "build-tools;${ANDROID_BUILD_TOOLS}"
echo "### Installing NDK version ${NDK_VERSION}..."
yes | ./cmdline-tools/bin/sdkmanager --sdk_root="${SDK_DIR}" --install "ndk;${NDK_VERSION}"

# ==============================================================================
# SECTION 4: PREPARING GAME DATA
# ==============================================================================
echo "-----------------------------------------------------"
echo "### STEP 3: Preparing game data (cards, pictures, scripts)..."

# ===================================================================
# <<< ZMIANA TUTAJ: Dynamiczne pobieranie najnowszej wersji libWindbot >>>
# ===================================================================
echo "### Fetching the latest Windbot release URL from GitHub API..."
# Używamy API GitHub, aby znaleźć URL do najnowszej wersji pliku .aar
WINDBOT_DOWNLOAD_URL=$(curl -s "https://api.github.com/repos/mercury233/libWindbot/releases/latest" | jq -r '.assets[] | select(.name=="libWindbot.aar") | .browser_download_url')

# Sprawdzenie, czy URL został znaleziony
if [ -z "$WINDBOT_DOWNLOAD_URL" ] || [ "$WINDBOT_DOWNLOAD_URL" == "null" ]; then
    echo "ERROR: Could not find the download URL for the latest libWindbot.aar."
    echo "Please check your internet connection or the GitHub repository."
    exit 1
fi

echo "### Downloading latest Windbot from: $WINDBOT_DOWNLOAD_URL"
wget "$WINDBOT_DOWNLOAD_URL" -O YGOMobile-cn-ko-en/mobile/libs/libWindbot.aar
# ===================================================================

# Preparing the font
wget "http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/1.10/ttf-bitstream-vera-1.10.tar.bz2"
tar -xf "ttf-bitstream-vera-1.10.tar.bz2"
mkdir -p YGOMobile-cn-ko-en/mobile/assets/data/fonts
cp ttf-bitstream-vera-1.10/Vera.ttf YGOMobile-cn-ko-en/mobile/assets/data/fonts/ygo.ttf

# Preparing pictures
cp -r ../cardgenerator/output/pics .
rm -rf pics/thumbnail
zip -r -9 YGOMobile-cn-ko-en/mobile/assets/data/pics.zip pics

# Preparing scripts
git clone https://github.com/Fluorohydride/ygopro-scripts.git script
rm -f script/c[0-9]*
rm -rf script/.git
cp ../cardgenerator/output/script/* script
zip -r -9 YGOMobile-cn-ko-en/mobile/assets/data/script.zip script

# Copying the database and banlist
cp ../cardgenerator/output/lflist.conf YGOMobile-cn-ko-en/mobile/assets/data/conf/
cp ../cardgenerator/output/cards.cdb YGOMobile-cn-ko-en/mobile/assets/data
cp ../cardgenerator/output/cards.cdb YGOMobile-cn-ko-en/mobile/assets/en/data
cp ../cardgenerator/output/cards.cdb YGOMobile-cn-ko-en/mobile/assets/kor/data
cp ../Windbot-AIGen/decks/* YGOMobile-cn-ko-en/mobile/assets/data/windbot/windbot/Decks/
cp ../Windbot-AIGen/decks/* YGOMobile-cn-ko-en/mobile/assets/data/deck/

# Writing the server list
echo "### Creating serverlist.xml files..."
cat << 'EOF' > YGOMobile-cn-ko-en/mobile/assets/serverlist.xml
<?xml version="1.0" encoding="utf-8"?>
<servers>
    <version>2</version>

    <server>
        <player-name>Summoner</player-name>
        <name>Summoned Monsters Official Server</name>
        <desc>Bot available</desc>
        <ip>192.166.217.156</ip>
        <port>40280</port>
        <keep>true</keep>
    </server>
</servers>
EOF

# Copying serverlist.xml to all language versions
cp YGOMobile-cn-ko-en/mobile/assets/serverlist.xml YGOMobile-cn-ko-en/mobile/assets/pt/serverlist.xml
cp YGOMobile-cn-ko-en/mobile/assets/serverlist.xml YGOMobile-cn-ko-en/mobile/assets/kor/serverlist.xml
cp YGOMobile-cn-ko-en/mobile/assets/serverlist.xml YGOMobile-cn-ko-en/mobile/assets/es/serverlist.xml
cp YGOMobile-cn-ko-en/mobile/assets/serverlist.xml YGOMobile-cn-ko-en/mobile/assets/en/serverlist.xml
echo "### The serverlist.xml files have been created and copied."

# ==============================================================================
# SECTION 5: BUILDING THE APPLICATION
# ==============================================================================
echo "-----------------------------------------------------"
echo "### STEP 4: Building the application..."

# Changing to the project directory
cd YGOMobile-cn-ko-en

# Creating local.properties file with correct paths
echo "sdk.dir=${SDK_DIR}" > local.properties
echo "ndk.dir=${SDK_DIR}/ndk/${NDK_VERSION}" >> local.properties
echo "### local.properties file has been created:"
cat local.properties

# 1. Compiling native code (.so) as per instructions
echo "### Compiling native code (libYGOMobile.so)..."
cd libcore
"${SDK_DIR}/ndk/${NDK_VERSION}/ndk-build" -j8
cd ..
echo "### Native code compilation finished."

# 2. Compiling the APK using Gradle
echo "### Compiling the APK file..."
./gradlew assembleDebug --no-daemon --rerun-tasks --stacktrace

# ==============================================================================
# SECTION 6: FINALIZATION
# ==============================================================================
echo "-----------------------------------------------------"
echo "### SUCCESS! Build finished."

# Moving the final APK file
mv mobile/build/outputs/apk/cn/debug/*.Apk ../
echo "### The final APK has been moved to: $(pwd)/../"