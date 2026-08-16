class DinoCopy < Formula
  desc "Fast one-way directory mirror for local disks"
  homepage "https://github.com/oberbichler/dino-copy"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.1.3/dino-copy-aarch64-apple-darwin.tar.xz"
      sha256 "29e54e879808d1728f841a7dc6db6b0f38321495b9d792eb5538ee32dd4b8781"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.1.3/dino-copy-x86_64-apple-darwin.tar.xz"
      sha256 "25dedab9d876adf3727e1a5c6a2fcf4e705a98c650d48348b293009009f0d83e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.1.3/dino-copy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7e586545303b6fedfb34327cba6290f5f13a0772c0dd7a32757e42d8c9a5294c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.1.3/dino-copy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7e40d8cc73df8e3ad59cd75d3b7819e36ed57ec132e2c01a6c96b51ad058d664"
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
