class Tractor < Formula
  desc "TractoR: Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.2.5"
  sha256 "e38dca5eb01f566a919b9f668c7c93f35246feb0cf996f850a9f87fde4f7eba0"
  head "https://github.com/tractor/tractor.git"
  
  depends_on "r"
  depends_on "jasper"   # for JPEG-2000 support in divest
  
  bottle do
    root_url "https://www.tractor-mri.org.uk"
    cellar :any
    sha256 "3ab7de28da30274e896bf88834010b545c23de7b7d582b03602dfc88c41a0ee9" => :high_sierra
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
