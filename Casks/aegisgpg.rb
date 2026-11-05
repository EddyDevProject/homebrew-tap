cask "aegisgpg" do
  arch arm: "aarch64", intel: "x64"

  version "0.4.0"
  sha256 arm:   "566af75d6e4bd6a8ad728cadba15f7398cdd2c1013167e9be1344e533cdbaf7d",
         intel: "872d30f58e5b0903ffe7bc2587bcb76c54114c4ec57b8720cffbf8efc3f7565b"

  url "https://github.com/EddyDevProject/AegisGPG/releases/download/v#{version}/AegisGPG_#{version}_#{arch}.dmg"
  name "AegisGPG"
  desc "Desktop app to manage OpenPGP keys, encrypt, sign and verify"
  homepage "https://aegisgpg.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "AegisGPG.app"

  # The app is only ad-hoc signed (not notarized): drop the quarantine flag so
  # Gatekeeper does not block it.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/AegisGPG.app"]
  end

  zap trash: [
    "~/Library/Application Support/app.aegisgpg.desktop",
    "~/Library/Caches/app.aegisgpg.desktop",
    "~/Library/Preferences/app.aegisgpg.desktop.plist",
    "~/Library/Saved Application State/app.aegisgpg.desktop.savedState",
    "~/Library/WebKit/app.aegisgpg.desktop",
  ]
end
