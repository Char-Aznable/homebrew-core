class Fonttools < Formula
  include Language::Python::Virtualenv

  desc "Library for manipulating fonts"
  homepage "https://github.com/fonttools/fonttools"
  url "https://github.com/fonttools/fonttools/releases/download/4.1.0/fonttools-4.1.0.zip"
  sha256 "683d4bebf9a5976e3b7d46a64a90708f6fcf8e13cf770e5a0b0d258a02c11d76"
  head "https://github.com/fonttools/fonttools.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "8d1b58f1950a575b11ed9819ca8478dc355c874aa42759cd8ce2393ab1da1219" => :catalina
    sha256 "b8bdc630c96eb1476aff2bc34ac873ffa79473b3d7e01ece6e5c96b9dc1665b5" => :mojave
    sha256 "9582787abf8d0f852bab81408ce191fc41e9f4121feb9bd71e9c32f5fba5eb9e" => :high_sierra
    sha256 "b184f9fe1b21d0e3c70e69dd770369a8dec3a0dcd928f3a5420dcc0279fd9f59" => :x86_64_linux
  end

  depends_on "python"

  def install
    virtualenv_install_with_resources
  end

  test do
    unless OS.mac?
      assert_match "usage", shell_output("#{bin}/ttx -h")
      return
    end
    cp "/System/Library/Fonts/ZapfDingbats.ttf", testpath
    system bin/"ttx", "ZapfDingbats.ttf"
  end
end
