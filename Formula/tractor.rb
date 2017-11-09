class Tractor < Formula
  desc "TractoR: Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.1.4"
  sha256 "bd18e183f383b1decb42f41266035767e58670bb105d7548997e4ce9ad780a9d"
  head "https://github.com/tractor/tractor.git"

  depends_on "r"

  def install
    ENV.deparallelize

    system "make", "install"
    
    prefix.install Dir["*.md", "VERSION", "tests"]
    
    bin.install "bin/tractor", "bin/plough"
    libexec.install "bin/exec/tractor", "lib/R"
    share.install "share/man", "share/tractor"
    doc.install Dir["share/doc/*"]
    
    prefix.install_symlink libexec => "lib"
    (bin/"exec").mkpath
    (bin/"exec").install_symlink libexec/"tractor"
  end

  test do
    system "#{bin}/tractor", "platform"
  end
  
  def caveats
    "You should probably set the TRACTOR_HOME environment variable to #{opt_prefix}"
  end
end
