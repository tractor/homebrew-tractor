class Tractor < Formula
  desc "Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.4.0"
  sha256 "9f9ab63dceab4001f7efcc4904ebcaa39d78cad05ab2b5dbbe787f1445745be1"
  head "https://github.com/tractor/tractor.git"
  
  bottle do
    root_url "https://www.tractor-mri.org.uk"
    rebuild 2
    sha256 cellar: :any, ventura: "5c80a462e9e3b5071542fba2728fe12a3e472ad01dbf83f52ff48193d24e6e61"
    sha256 cellar: :any, arm64_ventura: "536ff6027cad2abb04daf7e1b7f549054f4113ebba55236b3486f350f020d71e"
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
