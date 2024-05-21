class Tractor < Formula
  desc "Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.4.2"
  sha256 "982b75d27b4aef00c9d8804cc2c90b9bafdce0d816150141ff232db746755c9f"
  head "https://github.com/tractor/tractor.git"

  bottle do
    root_url "https://www.tractor-mri.org.uk"
    rebuild 1
    sha256 cellar: :any, arm64_sonoma: "fcff28d9b44302a3f9fe3933d30f0cdc690803e623fb98f5cc252af6702c67ac"
    sha256 cellar: :any, sonoma:       "99d3523f45221f9e37100f2afccb64b206b2247873942617536e660baae3a126"
  end

  depends_on "jasper" # for JPEG-2000 support in divest
  depends_on "r"

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
