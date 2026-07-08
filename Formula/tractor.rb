class Tractor < Formula
  desc "Magnetic resonance imaging and tractography with R"
  homepage "https://www.tractor-mri.org.uk"
  url "https://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.5.1"
  sha256 "35fd2f65e28a5569e88ed9677214d59789ffc9a385199607eaf5b0a8836404c3"
  head "https://github.com/tractor/tractor.git"
  license "GPL-2.0-only"
  
  depends_on "jasper" # for JPEG-2000 support in "divest"
  depends_on "r"
  
  bottle do
    rebuild 1
    root_url "https://www.tractor-mri.org.uk"
    sha256 arm64_tahoe: "832e0ced739157c217717e7ec86836b2def105543a013b7711b9d7d9774b7eb2"
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
