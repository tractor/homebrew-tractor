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
    rebuild 2
    root_url "https://www.tractor-mri.org.uk"
    sha256 arm64_sequoia: "d25e2c55a865810d901e8a1393f58b5139fbb683bdd6a2a03d8fad264b8a7bb3"
    sha256 arm64_tahoe: "113e17bf10b9240b66697c653c419dae0236c5615bdb7e12ef49de554f674826"
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
