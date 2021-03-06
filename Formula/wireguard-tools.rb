class WireguardTools < Formula
  desc "Tools for the WireGuard secure network tunnel"
  homepage "https://www.wireguard.com/"
  # Please only update version when the tools have been modified/updated,
  # since the Linux module aspect isn't of utility for us.
  url "https://git.zx2c4.com/WireGuard/snapshot/WireGuard-0.0.20191012.tar.xz"
  sha256 "93573193c9c1c22fde31eb1729ad428ca39da77a603a3d81561a9816ccecfa8e"
  head "https://git.zx2c4.com/WireGuard", :using => :git

  bottle do
    cellar :any_skip_relocation
    sha256 "430f85ccb7fa687eed9692b0ebda2daa4b67566f667d63383524cffddc041fa9" => :catalina
    sha256 "6012b7c4ceaa1bd6c32638c26dd7823835d84d4ba05abc58daa68dd2e6ad6e1c" => :mojave
    sha256 "847e9270ae88160d80b331a63da506f71dd4f9582c49bf6599c031ec3680bf65" => :high_sierra
    sha256 "c12370f4a5c0f64a6bd3e416d7d0d5effe3af69a9ba2b5802befb092ec73e013" => :x86_64_linux
  end

  depends_on "bash"
  depends_on "wireguard-go"
  depends_on "libmnl" unless OS.mac?

  def install
    system "make", "BASHCOMPDIR=#{bash_completion}", "WITH_BASHCOMPLETION=yes", "WITH_WGQUICK=yes",
                   "WITH_SYSTEMDUNITS=no", "PREFIX=#{prefix}", "SYSCONFDIR=#{prefix}/etc",
                   "-C", "src/tools", "install"
  end

  test do
    system "#{bin}/wg", "help"
  end
end
