class DinoCopy < Formula
  desc "Fast one-way directory mirror for local disks"
  homepage "https://github.com/oberbichler/dino-copy"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.3.0/dino-copy-aarch64-apple-darwin.tar.xz"
      sha256 "3fe9bb70071dc581ee855320f741224fadb84404a59845c8f1105a7cf6d8b04f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.3.0/dino-copy-x86_64-apple-darwin.tar.xz"
      sha256 "2f742cad7f6577095c4928e24921efc44d7d21fedd962ba4e8ffea409bc2e3e6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.3.0/dino-copy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7b73a8238a40e471c6a0b410273176f5e05b92f424725e853fe63c7b9ad0fdb9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.3.0/dino-copy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a11dffd0f727b4d0e4b5fbed630f9049ae0b2e9d9716de8d5c6af8ea5bf8b268"
    end
  end
  license "ISC"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dino-copy"
    end
    if OS.linux? && Hardware::CPU.intel?
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
