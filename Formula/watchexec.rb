class Watchexec < Formula
  desc "Execute commands when watched files change"
  homepage "https://github.com/watchexec/watchexec"
  url "https://github.com/watchexec/watchexec/archive/1.11.1.tar.gz"
  sha256 "6d74f336d6734c7625ee5acc5991f14bc0dff8e7cac40cb11303a5ef2f232f5c"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "eed083352cf7ed682acc1e35babc9f410f3b17fd403a7dbb816dc312242cf741" => :catalina
    sha256 "66d0ff90111182e9b982f76157885d5c7bcd8fd795eeb322bdf86868d7433ab6" => :mojave
    sha256 "0b44845c30c08cce6a218e11aae9d635b7dbf195165a3c2e43798a4ea95813ef" => :high_sierra
    sha256 "fd9bdd1e030e1101bb77e1267503e4904519ccec609143098d5bddb3dec4b354" => :x86_64_linux
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "."
    man1.install "doc/watchexec.1"
  end

  test do
    line = "saw file change"
    Utils.popen_read("#{bin}/watchexec", "--", "echo", line) do |o|
      assert_match line, o.readline.chomp
      Process.kill("INT", o.pid)
    end
  end
end
