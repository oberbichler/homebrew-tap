cask "zeyt" do
  version "1.3.0"
  sha256 "310c117ab7ca79c45b9fb10be96934ccd7c9a353e4225fcb497c06552f5b9465"

  url "https://github.com/oberbichler/zeyt/releases/download/v#{version}/zeyt-#{version}.zip"
  name "zeyt"
  desc "Menu bar time tracking that asks what you are working on"
  homepage "https://github.com/oberbichler/zeyt"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "zeyt.app"

  # zeyt is signed ad hoc, not notarized: without this Gatekeeper refuses the first start.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/zeyt.app"]
  end

  uninstall quit: "xyz.oberbichler.zeyt"

  zap trash: [
    "~/Library/Application Support/zeyt",
    "~/Library/Preferences/xyz.oberbichler.zeyt.plist",
  ]
end
