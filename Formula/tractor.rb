class Tractor < Formula
  desc "Magnetic resonance imaging and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.5.1"
  sha256 "35fd2f65e28a5569e88ed9677214d59789ffc9a385199607eaf5b0a8836404c3"
  head "https://github.com/tractor/tractor.git"

  depends_on "jasper" # for JPEG-2000 support in "divest"
  depends_on "r"
  
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
