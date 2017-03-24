require 'formula'

class Audiowaveform < Formula
  desc "C++ program to generate waveform data and render waveform images from audio files"
  homepage "https://github.com/bbc/audiowaveform"
  url "https://github.com/bbc/audiowaveform/archive/1.1.0.tar.gz"
  sha256 "2c1a01fcb2297197c43ef920b7088f9ed93ce68ffcacc3ad9e50b2622e64aebc"

  depends_on "cmake"
  depends_on "libmad"
  depends_on "libid3tag"
  depends_on "libsndfile"
  depends_on "gd"

  if MacOS.version < :mavericks
    depends_on "boost" => "c++11"
  else
    depends_on "boost"
  end
  # depends_on "gmock"

  def install
    cmake_args = std_cmake_args
    cmake_args << "-DENABLE_TESTS=0"
    cmake_args << "-DCMAKE_C_COMPILER=/usr/bin/clang"
    cmake_args << "-DCMAKE_CXX_COMPILER=/usr/bin/clang++"
    cmake_args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"

    mkdir "build" do
      system "cmake", "..", *cmake_args
      system "make", "install"
    end
  end

  test do
    # system "make", "test"
  end
end
