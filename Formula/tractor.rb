class Tractor < Formula
  desc "Magnetic resonance imaging and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.5.0_1"
  sha256 "f3f85314716e116bfd39250d14e1dddd0bba920f128064316ea43e6a1d1ce210"
  head "https://github.com/tractor/tractor.git"

  depends_on "jasper" # for JPEG-2000 support in "divest"
  depends_on "r"
  
  bottle do
    rebuild 1
    root_url "https://www.tractor-mri.org.uk"
    sha256 arm64_sequoia: "dc70798cbabfd103407374204442a29a331e3809aaf6c99fcf326722ef0ccd56"
    sha256 arm64_tahoe: "44b79c698b87378ecc233a274a97b55813c80a4eb8d3849e9880b058f1eeeec5"
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
