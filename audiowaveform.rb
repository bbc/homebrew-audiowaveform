class Audiowaveform < Formula
  desc "Program to generate waveform data and render waveform images from audio files"
  homepage "https://github.com/bbc/audiowaveform"
  url "https://github.com/bbc/audiowaveform/archive/1.8.1.tar.gz"
  sha256 "bd1254a4ddbc0eb68eb8dbd549335c3207260afdae4bf80cfe5d4129de51d1e7"
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
