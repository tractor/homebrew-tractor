class Tractor < Formula
  desc "Magnetic resonance imaging and tractography with R"
  homepage "https://www.tractor-mri.org.uk"
  url "https://www.tractor-mri.org.uk/tractor.tar.gz"
  head "https://github.com/tractor/tractor.git"
  license "GPL-2.0-only"
  
  depends_on "jasper" # for JPEG-2000 support in "divest"
  depends_on "r"
  
  version "3.5.2"
  sha256 "5ba47f27bd0e8f42cfc38532df9a7dd46a684a6afb957388c281d23754bd69c6"
  
  def install
    ENV.deparallelize

    system "make", "install"

    prefix.install Dir["*.md", "VERSION", "tests"]

    bin.install "bin/tractor", "bin/plough", "bin/furrow", "bin/lr"
    lib.install "lib/R"
    libexec.install "libexec/tractor"
    share.install "share/man", "share/tractor"
    doc.install Dir["share/doc/*"]
  end

  def caveats
    "You should probably set the TRACTOR_HOME environment variable to #{opt_prefix}"
  end

  test do
    system "#{bin}/tractor", "platform"
  end
end
