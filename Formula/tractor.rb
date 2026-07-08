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
  
  bottle do
    root_url "https://www.tractor-mri.org.uk"
    rebuild 1
    sha256 arm64_tahoe: "cfa6e086c62786972c82841aca4d0c6ecb35bcd68a854e2c280cf77660811dd9"
    sha256 arm64_sequoia: "2bf65e4979601881b2c4eed3aec88713f94cba470312753854b56d496c660c81"
  end
  
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
