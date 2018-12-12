class Tractor < Formula
  desc "TractoR: Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.3.0"
  sha256 "533420fdae899842bcf1aaa69f306b98501d3a0f2a7c310ea107bf67cbad2d31"
  head "https://github.com/tractor/tractor.git"
  
  depends_on "r"
  depends_on "jasper"   # for JPEG-2000 support in divest
  
  bottle do
    root_url "https://www.tractor-mri.org.uk"
    cellar :any
    sha256 "c5d4a2d8878517e2d5475f0cf6c3a7253b2b70f63bc7b15d5fc8212f75e1b16f" => :mojave
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
