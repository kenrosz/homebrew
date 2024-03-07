class Diffutils < Formula
  desc "File comparison utilities"
  homepage "https://www.gnu.org/s/diffutils/"
  url "https://ftp.gnu.org/gnu/diffutils/diffutils-3.10.tar.xz"
  mirror "https://ftpmirror.gnu.org/diffutils/diffutils-3.10.tar.xz"
  sha256 "90e5e93cc724e4ebe12ede80df1634063c7a855692685919bfe60b556c9bd09e"
  license "GPL-3.0-or-later"

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"a").write "foo"
    (testpath/"b").write "foo"
    system bin/"diff", "a", "b"
  end
end
