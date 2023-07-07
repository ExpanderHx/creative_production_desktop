#!/bin/sh
test -f Application-Installer.dmg && rm Application-Installer.dmg
create-dmg \
  --volname "Application Installer" \
  --window-pos 200 120 \
  --window-size 800 400 \
  --icon-size 100 \
  --icon "creative_production_desktop.app" 200 190 \
  --hide-extension "creative_production_desktop.app" \
  --app-drop-link 600 185 \
  "Application-Installer.dmg" \
  "creative_production_desktop.app"

#"Application-Installer.dmg"是.dmg文件名称。
#"source_folder/"是"flutter build macos --release"结果路径，如：/工程目录/build/macos/Build/Products/Release/xxx.app