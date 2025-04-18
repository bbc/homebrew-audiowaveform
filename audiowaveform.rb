class Audiowaveform < Formula
  desc "Generate waveform data and render waveform images from audio files"
  homepage "https://github.com/bbc/audiowaveform"
  url "https://github.com/bbc/audiowaveform/archive/1.10.2.tar.gz"
  sha256 "e4de669dbf2be56f6cad99a877a46541d0ad6be89c894bb1d1e866b0dd8e8841"
  depends_on "cmake"
  depends_on "gd"
  depends_on "libid3tag"
  depends_on "libmad"
  depends_on "libsndfile"

  if MacOS.version < :mavericks
    depends_on "boost" => "c++11"
  else
    depends_on "boost"
  end
  # depends_on "gmock"

  def install
    cmake_args = std_cmake_args
    cmake_args << "-DENABLE_TESTS=0"
    cmake_args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"

    if OS.mac?
      cmake_args << "-DCMAKE_C_COMPILER=/usr/bin/clang"
      cmake_args << "-DCMAKE_CXX_COMPILER=/usr/bin/clang++"
    end

    mkdir "build" do
      system "cmake", "..", *cmake_args
      system "make", "install"
    end
  end

  test do
    # system "make", "test"
  end
end
