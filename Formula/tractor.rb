class Tractor < Formula
  desc "Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.3.5"
  sha256 "b4ae366b006c64415c3149d1d06c1158a914a4245c1e049ed036c064e2712e3b"
  head "https://github.com/tractor/tractor.git"

  bottle do
    root_url "https://www.tractor-mri.org.uk"
    rebuild 1
    sha256 cellar: :any, arm64_big_sur: "fe91dbd20784dfad4f0703ec1176e08ad5c11d2588a564e0ceae152d9f2ab06a"
    sha256 cellar: :any, big_sur:       "c289cda12576e2750863f750a3fd44d1b780bf9f08dfce32a3f73d8d5c8f5b87"
    sha256 cellar: :any, catalina:      "f0dd461d6ddd45118e8f968e62658fc9c9d0ab1d24c7b0b699545d5a56eedaf6"
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
