#!/bin/bash

# --- Configuration ---
# Name of the target directory to check for
TARGET_DIR="YGOPro_Linux"

# Path to the source file we want to copy
SOURCE_FILE="Locales/English/strings.conf"
# --------------------

# Inform the user that the script is starting
echo "Starting the configuration update script..."

# Check if the target directory exists
if [ -d "$TARGET_DIR" ]; then
    echo "Target directory found: $TARGET_DIR."

    # Check if the source file exists before trying to copy it
    if [ -f "$SOURCE_FILE" ]; then
        echo "Copying file $SOURCE_FILE to $TARGET_DIR..."
        
        # Copy the file with the -f (force) option, which overwrites the destination file without prompting
        cp -f "$SOURCE_FILE" "$TARGET_DIR"
        
        echo "Operation successful. The file has been copied and overwritten."
    else
        echo "Error: Source file '$SOURCE_FILE' not found! No action was taken."
    fi
else
    # Message if the target directory does not exist
    echo "Directory '$TARGET_DIR' not found. Operation aborted."
fi