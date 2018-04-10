class Tractor < Formula
  desc "TractoR: Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.2.3"
  sha256 "18b80cd1ae57a0921b492895ada64ab89131a4e2035aba7e01edf34b8035abe4"
  head "https://github.com/tractor/tractor.git"
  
  depends_on "r"
  depends_on "jasper"   # for JPEG-2000 support in divest
  
  bottle do
    root_url "https://www.tractor-mri.org.uk"
    cellar :any
    sha256 "35e211300881b1599e9170153193ebe3b14c3014892951e441d133bb25dec38a" => :high_sierra
  end
  
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
  
  test do
    system "#{bin}/tractor", "platform"
  end
  
  def caveats
    "You should probably set the TRACTOR_HOME environment variable to #{opt_prefix}"
  end
end
