#!/bin/bash

# Set variables
build_tools=r21.1.2
android=5.0.1
commandlinetools=9645777
windbot=0.3.9
ndk=21.4.7075529
font="ttf-bitstream-vera-1.10"
fonturl="http://ftp.gnome.org/pub/GNOME/sources/ttf-bitstream-vera/1.10/${font}.tar.bz2"

### Verify required Summoned Monsters files
if [ ! -d ../cardgenerator/output ];
then
	echo "You must generate the necessary game files using the cardgenerator!"
	exit 1
fi

### Download necessary software
git clone https://github.com/fallenstardust/YGOMobile-cn-ko-en
cd YGOMobile-cn-ko-en
git checkout 5e9cee0a03d0b8311541fd58b9254be6bf6ea3a8
cd ..
chmod +x YGOMobile-cn-ko-en/gradlew
wget https://github.com/mercury233/libWindbot/releases/download/${windbot}/libWindbot.aar -O YGOMobile-cn-ko-en/mobile/libs/libWindbot.aar
wget https://dl.google.com/android/repository/build-tools_$build_tools-linux.zip
unzip build-tools_$build_tools-linux.zip
wget https://dl.google.com/android/repository/commandlinetools-linux-${commandlinetools}_latest.zip
unzip commandlinetools-linux-${commandlinetools}_latest.zip

### Copy data

# Cleaning
rm -rf YGOMobile-cn-ko-en/mobile/assets/en/data/single
rm YGOMobile-cn-ko-en/mobile/assets/data/windbot/windbot/Decks/*
rm YGOMobile-cn-ko-en/mobile/assets/data/deck/*

# Font
mkdir -p YGOMobile-cn-ko-en/mobile/assets/data/fonts
wget "$fonturl"
tar -xf "$font.tar.bz2"
cp $font/Vera.ttf YGOMobile-cn-ko-en/mobile/assets/data/fonts/ygo.ttf
rm -rf $font*

# Pics
cp -r ../cardgenerator/output/pics .
rm -rf pics/thumbnail
zip -r -9 YGOMobile-cn-ko-en/mobile/assets/data/pics.zip pics
rm -rf pics

# Scripts
git clone https://github.com/Fluorohydride/ygopro-scripts.git script
rm script/c[0-9]*
rm -rf script/.git
cp ../cardgenerator/output/script/* script
zip -r -9 YGOMobile-cn-ko-en/mobile/assets/data/script.zip script
rm -rf script

# Banlist
cp ../cardgenerator/output/lflist.conf YGOMobile-cn-ko-en/mobile/assets/data/conf/

# Card database
cp ../cardgenerator/output/cards.cdb YGOMobile-cn-ko-en/mobile/assets/data
cp ../cardgenerator/output/cards.cdb YGOMobile-cn-ko-en/mobile/assets/en/data
cp ../cardgenerator/output/cards.cdb YGOMobile-cn-ko-en/mobile/assets/kor/data

# Copy decks
cp ../Windbot-AIGen/decks/* YGOMobile-cn-ko-en/mobile/assets/data/windbot/windbot/Decks/
cp ../Windbot-AIGen/decks/* YGOMobile-cn-ko-en/mobile/assets/data/deck/
## Probably we need to build our libwindbot AI lib :-(

### Build
cd YGOMobile-cn-ko-en
echo sdk.dir=/home/fervi/Intinte/Summoned-Monsters/build/android-${android} > local.properties
echo ndk.dir=/home/fervi/Intinte/Summoned-Monsters/build/android-${android}/ndk/${ndk}/ >> local.properties
yes | ../cmdline-tools/bin/sdkmanager --sdk_root=../android-${android} "platforms;android-31"
yes | ../cmdline-tools/bin/sdkmanager --sdk_root=../android-${android} --install "ndk;${ndk}"
cd libcore
/home/fervi/Intinte/Summoned-Monsters/build/android-${android}/ndk/${ndk}/ndk-build -j8
cd ..
./gradlew assembleDebug
yes | ../cmdline-tools/bin/sdkmanager --sdk_root=../android-${android} "platforms;android-31"
./gradlew assembleDebug
./gradlew assembleDebug
mv mobile/build/outputs/apk/cn/debug/*.apk ../

### Cleaning
cd ..
rm -rf YGOMobile-cn-ko-en
rm -rf android-${android}
rm -rf cmdline-tools
rm build-tools_${build_tools}-linux.zip commandlinetools-linux-${commandlinetools}_latest.zip