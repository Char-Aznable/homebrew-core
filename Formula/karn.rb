class Karn < Formula
  desc "Manage multiple Git identities"
  homepage "https://github.com/prydonius/karn"
  url "https://github.com/prydonius/karn/archive/v0.0.4.tar.gz"
  sha256 "68d244558ef62cf1da2b87927a0a2fbf907247cdd770fc8c84bf72057195a6cb"

  bottle do
    cellar :any_skip_relocation
    sha256 "dbe143cddeeb74fa8cbac57f8f28f9280ce6ba554fe00d02b44f68316a229710" => :catalina
    sha256 "3a353fc809699b904cdbc845138518fddabfac7250b22d68a47f9ecdd98de967" => :mojave
    sha256 "a837fd65265db402d67fda5ff5bb4337822d1efd945bee56f7a664e6bc67c343" => :high_sierra
    sha256 "0b29500ed8d75753402ea041190021d679624b739665b3a4d11df3d4a3100e59" => :sierra
    sha256 "bc217bf56d073ffabd11c81382387029aa09d216ef8060b3134a6190997ef0f5" => :el_capitan
    sha256 "03533f5131e54f5c363cdb27a03a245770cfd952a0eb0d8b4ed6d3242a4194ac" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/prydonius/karn").install buildpath.children

    cd "src/github.com/prydonius/karn" do
      system "go", "build", "-o", bin/"karn", "./cmd/karn/karn.go"
      prefix.install_metafiles
    end
  end

  test do
    (testpath/".karn.yml").write <<~EOS
      ---
      #{testpath}:
        name: Homebrew Test
        email: test@brew.sh
    EOS
    system "git", "init"
    system "git", "config", "--global", "user.name", "Test"
    system "git", "config", "--global", "user.email", "test@test.com"
    system "#{bin}/karn", "update"
  end
end
