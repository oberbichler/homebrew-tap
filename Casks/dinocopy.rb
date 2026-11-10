cask "dinocopy" do
  version "0.3.0"
  sha256 "f5d7f1966bb6fc226fb2b0cbb638bd744db2ec42d6fde654a1012463b23fa939"

  url "https://github.com/oberbichler/dino-copy/releases/download/v#{version}/DinoCopy.dmg"
  name "DinoCopy"
  desc "Mirror one disk onto another"
  homepage "https://github.com/oberbichler/dino-copy"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "DinoCopy.app"

  # DinoCopy is signed ad hoc, not notarized: without this Gatekeeper refuses the first start.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/DinoCopy.app"]
  end

  uninstall quit: "com.oberbichler.dino-copy"

  zap trash: [
    "~/Library/Caches/com.oberbichler.dino-copy",
    "~/Library/Saved Application State/com.oberbichler.dino-copy.savedState",
    "~/Library/WebKit/com.oberbichler.dino-copy",
  ]
end
