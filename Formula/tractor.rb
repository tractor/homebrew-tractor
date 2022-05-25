class Tractor < Formula
  desc "Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.3.5"
  sha256 "b4ae366b006c64415c3149d1d06c1158a914a4245c1e049ed036c064e2712e3b"
  head "https://github.com/tractor/tractor.git"
  revision 1

  bottle do
    root_url "https://www.tractor-mri.org.uk"
    rebuild 1
    sha256 cellar: :any, monterey: "720bedbf5f6eb8cfd6879b1169da00bf64f7bf798b1403dd05d35125b9986890"
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
