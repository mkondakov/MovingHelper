#!/bin/sh

xcodebuild -project MovingHelper.xcodeproj -scheme "MovingHelper" -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6,OS=9.2' -derivedDataPath './output' test