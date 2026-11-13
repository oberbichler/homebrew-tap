class DinoCopy < Formula
  desc "Fast one-way directory mirror for local disks"
  homepage "https://github.com/oberbichler/dino-copy"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.3.1/dino-copy-aarch64-apple-darwin.tar.xz"
      sha256 "4dc4bced5603e8d77ba5c5f47e6d33848268ec5611c15e06effbfb216ccaebbb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.3.1/dino-copy-x86_64-apple-darwin.tar.xz"
      sha256 "56a85811afa116a4f1c4d9bfe34f472dc48be60b4d77bc2890abf98727c188d2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.3.1/dino-copy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e782155a0ac8d4df5c85d1f67097caab0cc922003e528989e53af80e456a7cd2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.3.1/dino-copy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "504691a4e8b1d29f9ccdfc676a0651615b64dec2b11f466dff7e4faf937b09c9"
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
