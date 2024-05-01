# based on https://github.com/Homebrew/homebrew-cask/blob/master/Casks/l/logi-options-plus.rb
cask "logi-options-plus-minimal" do
  version "1.70.551909"
  sha256 :no_check

  # see https://prosupport.logi.com/hc/en-us/articles/10991109278871-Logitech-Options-Offline-Installer
  url "https://download01.logi.com/web/ftp/pub/techsupport/optionsplus/logioptionsplus_installer_offline.zip",
      verified: "download01.logi.com/web/ftp/pub/techsupport/optionsplus/"
  name "Logitech Options+ (Minimal)"
  desc "Software for Logitech devices, bloatware disabled"
  homepage "https://www.logitech.com/en-us/software/logi-options-plus.html"

  livecheck do
    url "https://support.logi.com/hc/en-gb/articles/1500005516462"
    regex(/version\D*?(\d+(?:\.\d+)+)/i)
  end

  auto_updates true
  conflicts_with cask: "logi-options-plus"
  depends_on macos: ">= :catalina"

  # see https://prosupport.logi.com/hc/en-us/articles/6046882446359
  installer script: {
    executable: "logioptionsplus_installer_offline.app/Contents/MacOS/logioptionsplus_installer",
    args:       [
      "--quiet",
      "--update",          "Yes",
      "--dfu",             "Yes",
      "--backlight",       "Yes",
      "--analytics",       "No",
      "--flow",            "No",
      "--sso",             "No",
      "--logivoice",       "No",
      "--aipromptbuilder", "No"
    ],
    sudo:       true,
  }

  uninstall launchctl: [
              "com.logi.cp-dev-mgr",
              "com.logi.optionsplus",
              "com.logi.optionsplus.updater",
            ],
            quit:      [
              "com.logi.cp-dev-mgr",
              "com.logi.optionsplus",
              "com.logi.optionsplus.driverhost",
              "com.logi.optionsplus.updater",
              "com.logitech.FirmwareUpdateTool",
              "com.logitech.logiaipromptbuilder",
            ],
            delete:    [
              "/Applications/logioptionsplus.app",
              "/Applications/Utilities/Logi Options+ Driver Installer.bundle",
              "/Library/Application Support/Logitech.localized/LogiOptionsPlus",
            ],
            rmdir:     "/Library/Application Support/Logitech.localized"

  zap trash: [
    "/Users/Shared/logi",
    "/Users/Shared/LogiOptionsPlus",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.logi.optionsplus*.sfl*",
    "~/Library/Application Support/LogiOptionsPlus",
    "~/Library/Preferences/com.logi.cp-dev-mgr.plist",
    "~/Library/Preferences/com.logi.optionsplus.driverhost.plist",
    "~/Library/Preferences/com.logi.optionsplus.plist",
    "~/Library/Saved Application State/com.logi.optionsplus.savedState",
  ]

  caveats do
    reboot
  end
end
