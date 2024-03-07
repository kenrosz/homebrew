class Jsoncpp < Formula
  desc "Library for interacting with JSON"
  homepage "https://github.com/open-source-parsers/jsoncpp"
  url "https://github.com/open-source-parsers/jsoncpp/archive/1.9.5.tar.gz"
  sha256 "f409856e5920c18d0c2fb85276e24ee607d2a09b5e7d5f0a371368903c275da2"
  license "MIT"
  head "https://github.com/open-source-parsers/jsoncpp.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  # NOTE: Do not change this to use CMake, because the CMake build is deprecated.
  # See: https://github.com/open-source-parsers/jsoncpp/wiki/Building#building-and-testing-with-cmake
  #      https://github.com/Homebrew/homebrew-core/pull/103386
  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <json/json.h>
      int main() {
          Json::Value root;
          Json::CharReaderBuilder builder;
          std::string errs;
          std::istringstream stream1;
          stream1.str("[1, 2, 3]");
          return Json::parseFromStream(builder, stream1, &root, &errs) ? 0: 1;
      }
    EOS
    system ENV.cxx, "-std=c++11", testpath/"test.cpp", "-o", "test",
                  "-I#{include}/jsoncpp",
                  "-L#{lib}",
                  "-ljsoncpp"
    system "./test"
  end
end
