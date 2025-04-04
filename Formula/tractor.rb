class Tractor < Formula
  desc "Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.4.5"
  sha256 "9637ac24c062614968dcb65665a4c77a8953cb19eb2422d50845fb3b754dfb8f"
  head "https://github.com/tractor/tractor.git"

  depends_on "jasper" # for JPEG-2000 support in "divest"
  depends_on "r"
  
  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_sequoia: "e8693ad8f2905bc4a1aca3609f37a91c74b6b7c0f07e4864340235ff26a98f1f"
  end

  def install
    ENV.deparallelize

    system "make", "install"

    prefix.install Dir["*.md", "VERSION", "tests"]

    bin.install "bin/tractor", "bin/plough", "bin/furrow"
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
