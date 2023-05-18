class Tractor < Formula
  desc "Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.4.0"
  sha256 "9f9ab63dceab4001f7efcc4904ebcaa39d78cad05ab2b5dbbe787f1445745be1"
  head "https://github.com/tractor/tractor.git"

  bottle do
    root_url "https://www.tractor-mri.org.uk"
    rebuild 1
    sha256 cellar: :any, monterey: "720bedbf5f6eb8cfd6879b1169da00bf64f7bf798b1403dd05d35125b9986890"
    sha256 cellar: :any, arm64_monterey: "62e3bae2931bfc8ae4b5de376beea682992bb06cec7c4e70021db26c45bffa4e"
    sha256 cellar: :any, big_sur:  "7ba3a5a8feb083170f0dd950a4192cb17fd94f748ed852bbf11e52b72bc71049"
  end

  depends_on "jasper"    # for JPEG-2000 support in divest
  depends_on "r"

  def install
    ENV.deparallelize

    system "make", "install"

    prefix.install Dir["*.md", "VERSION", "tests"]

    bin.install "bin/tractor", "bin/plough", "bin/furrow"
    libexec.install "bin/exec/tractor", "lib/R"
    share.install "share/man", "share/tractor"
    doc.install Dir["share/doc/*"]

    prefix.install_symlink libexec => "lib"
    (bin/"exec").mkpath
    (bin/"exec").install_symlink libexec/"tractor"
  end

  def caveats
    "You should probably set the TRACTOR_HOME environment variable to #{opt_prefix}"
  end

  test do
    system "#{bin}/tractor", "platform"
  end
end
