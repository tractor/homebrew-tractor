class Tractor < Formula
  desc "TractoR: Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.2.0"
  sha256 "e8e07be0b725cf87aba81e5ef7df0a5035eb8823f30d2ca8cdd19ade56997b01"
  head "https://github.com/tractor/tractor.git"

  depends_on "r"

  bottle do
    root_url "https://www.tractor-mri.org.uk"
    cellar :any
    sha256 "5b78b67153da2ee975fa3dca26f5144f1ca4b1ab0c6e2fb5fa4ad43fb829c43a" => :high_sierra
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
