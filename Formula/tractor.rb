class Tractor < Formula
  desc "Magnetic resonance and tractography with R"
  homepage "http://www.tractor-mri.org.uk"
  url "http://www.tractor-mri.org.uk/tractor.tar.gz"
  version "3.3.4"
  sha256 "01eb640b36493d72b1824cb826bc7dc83d55585bf2d17c36f57c9803c724fc8e"
  head "https://github.com/tractor/tractor.git"

  bottle do
    root_url "https://www.tractor-mri.org.uk"
    sha256 cellar: :any, arm64_big_sur: "f23217b7a21d37351888a0f7ec2fca4719d8a48fb5ba97715829a1c678761230"
    sha256 cellar: :any, big_sur:       "fdcac2ab25146ee1580a491aa8934e9d3cc79eb304a1a32d7b92f4d06d8b7911"
    sha256 cellar: :any, catalina:      "2d42a38ff200055ae0e7698fd7c8f6ccf03d0e7758a5156739bfa2d144e2beb0"
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
