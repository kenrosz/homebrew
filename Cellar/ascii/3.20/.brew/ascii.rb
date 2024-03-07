class Ascii < Formula
  desc "List ASCII idiomatic names and octal/decimal code-point forms"
  homepage "http://www.catb.org/~esr/ascii/"
  url "http://www.catb.org/~esr/ascii/ascii-3.20.tar.gz"
  sha256 "9e6e57ea60d419a803a024ce6366254efb716266b84eedd58cd980dabcc11674"
  license "BSD-2-Clause"

  livecheck do
    url :homepage
    regex(/ascii[._-]v?(\d+(?:\.\d+)+)/i)
  end

  head do
    url "https://gitlab.com/esr/ascii.git", branch: "master"
    depends_on "xmlto" => :build
  end

  def install
    ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog" if build.head?
    bin.mkpath
    man1.mkpath
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_match "Official name: Line Feed", shell_output(bin/"ascii 0x0a")
  end
end
