class Tractor < Formula
  desc "TractoR: Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.2.1"
  sha256 "74b6fd3fc526dd271601bdeac09c70d7ac1286ba964ade204a33f6526a899afd"
  head "https://github.com/tractor/tractor.git"
  
  depends_on "r"
  
  bottle do
    root_url "https://www.tractor-mri.org.uk"
    cellar :any
    rebuild 1
    sha256 "2c374f4468901926681a33ee99ba1c935ddf21935bf2c11047205e6fc4df8ba2" => :high_sierra
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
