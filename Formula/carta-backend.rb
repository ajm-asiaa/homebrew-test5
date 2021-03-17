class CartaBackend < Formula
  desc "Source code repository for the backend component of CARTA"
  homepage "https://cartavis.github.io/"
  url "https://github.com/CARTAvis/carta-backend/archive/v2.0.0-dev.21.03.05.tar.gz"
  version "2.0.0"
  sha256 "2aad00bb92dca00be6a03db54ac2558fe8ac80b0da36f4316a428e5fe98d044a"
  license "GPL-3.0"

  depends_on "cmake" => :build
  depends_on "ajm-asiaa/test4/carta-casacore"
  depends_on "ajm-asiaa/test4/zfp"
  depends_on "grpc"
  depends_on "libomp"
  depends_on "libuv"
  depends_on "protobuf"
  depends_on "pugixml"
  depends_on "tbb"
  depends_on "zstd"

  def install
    ENV["OPENSSL_ROOT_DIR"] = "$(brew --prefix openssl)"
    system "git", "submodule", "update", "--init", "--recursive"
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    assert_match "2.0.0-dev.21.03.04", shell_output("#{bin}/carta_backend")
  end
end
