class DinoCopy < Formula
  desc "Fast one-way directory mirror for local disks"
  homepage "https://github.com/oberbichler/dino-copy"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.2.0/dino-copy-aarch64-apple-darwin.tar.xz"
      sha256 "433d976e48d881186cadeaaf114ffab994cd2779ca7ec5ea03a4b9c4f8fcf705"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.2.0/dino-copy-x86_64-apple-darwin.tar.xz"
      sha256 "eb91923e336e5f760d7cf37d1a934e4119149eaa7f3e2fa719803b55ebd16699"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.2.0/dino-copy-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ca223c73216695529faf6b2753cf35bd9994c603296a942656713364a4108224"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oberbichler/dino-copy/releases/download/v0.2.0/dino-copy-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3e62152978df4452d02fbc57335430146837bdd34e9d2d947b4db85dd1a9f5c3"
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
