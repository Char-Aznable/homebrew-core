class Ode < Formula
  desc "Simulating articulated rigid body dynamics"
  homepage "https://www.ode.org/"
  url "https://bitbucket.org/odedevs/ode/downloads/ode-0.16.tar.gz"
  sha256 "4ba3b76f9c1314160de483b3db92b0569242a07452cbb25b368e75deb3cabf27"
  head "https://bitbucket.org/odedevs/ode/", :using => :hg

  bottle do
    cellar :any_skip_relocation
    sha256 "e5b71e7f775b1d5d17e80cda8d174e72cd8b0b99c75bc266f198abd8a42bb134" => :catalina
    sha256 "ea4f04cfd28205dfa4215c96342046a9b89e7c13731159aecd5788a791d07ec2" => :mojave
    sha256 "eb5e88678caee617bee029a5d90ec2e2344b1d4ff1ac28d4953549e9dd4f6dcf" => :high_sierra
    sha256 "8a5ab1cb46e5454379dcbc090d012b42cdc0b3dba9b81475af7fda8abc7b93a0" => :sierra
    sha256 "9817fd567b6c833772b4828334a6d56787e4f6330d1a3a21c1a35346a82deee5" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libccd"

  def install
    inreplace "bootstrap", "libtoolize", "glibtoolize"
    system "./bootstrap"

    system "./configure", "--prefix=#{prefix}", "--enable-libccd"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <ode/ode.h>
      int main() {
        dInitODE();
        dCloseODE();
        return 0;
      }
    EOS
    std = OS.mac? ? "-lc++" : "-lstdc++"
    system ENV.cc, "test.cpp", "-I#{include}/ode", "-L#{lib}", "-lode",
                   "-L#{Formula["libccd"].opt_lib}", "-lccd",
                   *("-lm" unless OS.mac?),
                   std, *("-lpthread" unless OS.mac?), "-o", "test"
    system "./test"
  end
end
