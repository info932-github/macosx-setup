#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osxprep.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Step 1: Update the OS and Install Xcode Tools
echo "------------------------------"
echo "Updating OSX.  If this requires a restart, run the script again."
# Install all available updates
sudo softwareupdate -iva
# Install only recommended available updates
#sudo softwareupdate -irv

echo "------------------------------"
echo "Installing Xcode Command Line Tools."
# Install Xcode command line tools
xcode-select --install

#install Xcode from thumb drive
#!/bin/bash
DOWNLOAD_BASE_URL=http://somplace/

## Figure out OSX version (source: https://www.opscode.com/chef/install.sh)
function detect_platform_version() {
# Matching the tab-space with sed is error-prone
platform_version=$(sw_vers | awk '/^ProductVersion:/ { print $2 }')

major_version=$(echo $platform_version | cut -d. -f1,2)

# x86_64 Apple hardware often runs 32-bit kernels (see OHAI-63)
x86_64=$(sysctl -n hw.optional.x86_64)
if [ $x86_64 -eq 1 ]; then
machine="x86_64"
fi
}

detect_platform_version
echo $platform_version
# Determine which XCode version to use based on platform version
case $platform_version in
"10.11.2") XCODE_DMG='XCode_7.2.dmg' ;;
"10.10") XCODE_DMG='XCode-6.1.1-6A2008a.dmg' ;;
"10.9")  XCODE_DMG='XCode-5.0.2-5A3005.dmg'  ;;
*)       XCODE_DMG='XCode-5.0.1-5A2053.dmg'  ;;
esac

# Bootstrap XCode from dmg
if [ ! -d "/Applications/Xcode.app" ]; then
echo "INFO: XCode.app not found. Installing XCode..."
if [ ! -e "$XCODE_DMG" ]; then
#assuming that xcode is on a volume
rsync -—progress /Volumes/SharedFolders/Home/Downloads/${XCODE_DMG} ./${XCODE_DMG}
#curl -L -O "${DOWNLOAD_BASE_URL}/${XCODE_DMG}"
fi

hdiutil attach "$XCODE_DMG"
export __CFPREFERENCES_AVOID_DAEMON=1
cp -R /Volumes/Xcode/Xcode.app /Applications
hdiutil detach '/Volumes/XCode'
fi