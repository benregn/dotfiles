#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "~/Applications/Google Chrome.app"
dockutil --no-restart --add "~/Applications/Chrome\ Apps.localized/app_list.app"
dockutil --no-restart --add "~/Applications/Firefox.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/System Preferences.app"
dockutil --no-restart --add "/Applications/Utilities/Console.app"

killall Dock
