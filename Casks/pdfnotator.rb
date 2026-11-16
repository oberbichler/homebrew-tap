cask "pdfnotator" do
  version "0.4.0"
  sha256 "b85681a57b1d427fd459106ec57e28506789310c5569bb1a7d46c7ea6a797e61"

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
