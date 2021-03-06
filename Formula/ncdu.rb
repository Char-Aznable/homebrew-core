class Ncdu < Formula
  desc "NCurses Disk Usage"
  homepage "https://dev.yorhel.nl/ncdu"
  url "https://dev.yorhel.nl/download/ncdu-1.14.1.tar.gz"
  sha256 "be31e0e8c13a0189f2a186936f7e298c6390ebdc573bb4a1330bc1fcbf56e13e"

  bottle do
    cellar :any_skip_relocation
    sha256 "757cbcc5ed617cbe01b66d04b4db07fa6ef568077f6f66eb46cbf0c0cabb3d7c" => :catalina
    sha256 "4affa4dad2978f22cb284a3efed3b63408e0e4d4d77ac851266df15386a02c30" => :mojave
    sha256 "9fcb90b8776c442b94d387f679cf8dfceb6c7f043f33212aa77ecc72db6a8ff8" => :high_sierra
    sha256 "874b76e2ff36b231358596581ed2e8536682bf17e65e5762ae5d5aa20e511a3a" => :sierra
    sha256 "e959200e31e58256f8bd00159bc8fcd4c343db2669704a110dc28e93545ad4e2" => :x86_64_linux
  end

  head do
    url "https://g.blicky.net/ncdu.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  uses_from_macos "ncurses"

  def install
    system "autoreconf", "-i" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ncdu -v")
  end
end
