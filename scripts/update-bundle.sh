#!/bin/sh

INFO_PLIST=MovingHelper/Info.plist
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${TRAVIS_BUILD_NUMBER}" "${INFO_PLIST}"