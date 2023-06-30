class Tractor < Formula
  desc "Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.4.1"
  sha256 "4aa00b8afdee259e881e07602cb9f9c47a979cc99fb6b2fb521ceafd0831fa10"
  head "https://github.com/tractor/tractor.git"
  
  bottle do
    rebuild 1
    sha256 cellar: :any, ventura: "b62f9a2a026c48c957292a3c56a4f7c8e60cb50f592885f7cb4bcec94b8be55c"
    sha256 cellar: :any, arm64_ventura: "b75d4df729e626267e27eb75b9e9319ef53d667f90edf97dbb34bf2b3fc3fabc"
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
