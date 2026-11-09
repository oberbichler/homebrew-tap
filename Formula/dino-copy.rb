class DinoCopy < Formula
  desc "Fast one-way directory mirror for local disks"
  homepage "https://github.com/oberbichler/dino-copy"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.2.1/dino-copy-aarch64-apple-darwin.tar.xz"
      sha256 "a7ed886d29cf4879e77f0296b7d483169a3ae76c8e412007c97b6bf571aae4ae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.2.1/dino-copy-x86_64-apple-darwin.tar.xz"
      sha256 "bd9718d88e3499b572418b873ef0afd5aaac33a0bbda3998db7f7056be6c91c1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.2.1/dino-copy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "270bf30a9159a16f3bd8a764a9d6a09180b6554e324709d8c6c9721840650de5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.2.1/dino-copy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7f215874e17fb827b2d091cf3f5b0435707a820335e9aa7ab8f4e73f5aa12cef"
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
