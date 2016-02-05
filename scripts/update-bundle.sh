#!/bin/sh

/usr/libexec/PlistBuddy -c "Set :CFBundleVersion ${TRAVIS_BUILD_NUMBER}" "${INFO_PLIST}"