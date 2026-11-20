cask "pdfnotator" do
  version "0.7.1"
  sha256 "fdf0217a551885e82b328374a222c9f2bdd67bfd5cba3dd1e40c2521671318a9"

  url "https://github.com/oberbichler/pdfnotator/releases/download/v#{version}/PDFnotator_#{version}_universal.dmg"
  name "PDFnotator"
  desc "PDF viewer for pair-designing Typst documents with AI agents"
  homepage "https://github.com/oberbichler/pdfnotator"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "PDFnotator.app"

  # PDFnotator is signed ad hoc, not notarized: without this Gatekeeper refuses the first start.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/PDFnotator.app"]
  end

  uninstall quit: "de.qaware.pdfnotator"

  zap trash: [
    "~/Library/Application Support/de.qaware.pdfnotator",
    "~/Library/Caches/de.qaware.pdfnotator",
    "~/Library/Saved Application State/de.qaware.pdfnotator.savedState",
    "~/Library/WebKit/de.qaware.pdfnotator",
  ]
end
