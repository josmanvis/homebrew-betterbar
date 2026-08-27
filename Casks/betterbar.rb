cask "betterbar" do
  version "0.10.0"
  sha256 "260bf3f71baf52b4899b1db6adb2d0577b87bddd705fdfa392b75725b703bc9e"

  url "https://github.com/josmanvis/betterbar/releases/download/v#{version}/BetterBar_#{version}_universal.dmg"
  name "BetterBar"
  desc "Customizable brutalist dock alternative and status bar for macOS"
  homepage "https://github.com/josmanvis/betterbar"

  depends_on macos: :monterey

  app "BetterBar.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-d", "com.apple.quarantine", "#{appdir}/BetterBar.app"],
                   sudo: false
  rescue StandardError
    nil
  end

  caveats <<~EOS
    BetterBar requires Accessibility and Screen Recording permissions to interact with windows
    and render previews. You can grant these in System Settings > Privacy & Security.
  EOS

  zap trash: [
    "~/.betterbar",
    "~/Library/Application Support/com.betterbar.app",
    "~/Library/Caches/com.betterbar.app",
    "~/Library/Preferences/com.betterbar.app.plist",
    "~/Library/Saved Application State/com.betterbar.app.savedState",
    "~/Library/WebKit/com.betterbar.app",
  ]
end
