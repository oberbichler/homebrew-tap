class DinoCopy < Formula
  desc "Fast one-way directory mirror (e.g. for syncing two external USB HDDs): copies new/changed files, skips unchanged, deletes extras, preserves mtime and permissions."
  homepage "https://github.com/oberbichler/dino-copy"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.1.0/dino-copy-aarch64-apple-darwin.tar.xz"
      sha256 "796a5e79e1cee9f929380391b78943d65106469112b7942d83e5152b70ec6f5b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.1.0/dino-copy-x86_64-apple-darwin.tar.xz"
      sha256 "e3a8038a893e8d973034036091af0e1af8cc84e8fd5665c9669a109abbb92a75"
    end
  end
  license "ISC"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "dino-copy"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dino-copy"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
