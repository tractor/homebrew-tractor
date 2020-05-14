class Tractor < Formula
  desc "TractoR: Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.3.3"
  sha256 "d78ae0afa0ec36162c011095a37ca61c812d7c039719c492b637e7be5d5f9275"
  head "https://github.com/tractor/tractor.git"
  
  depends_on "r"
  depends_on "jasper"   # for JPEG-2000 support in divest
  
  bottle do
    root_url "https://www.tractor-mri.org.uk"
    cellar :any
    sha256 "eae0a368a6cbdfd78c9e2ef844d1bce768ec8f7aa53002abd3d2b7a62c4a5841" => :catalina
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
