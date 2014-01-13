require 'formula'

class Handbrake < Formula
  head 'svn://svn.handbrake.fr/HandBrake/trunk', :using => :svn
  homepage 'http://handbrake.fr'

  depends_on 'curl'
  depends_on 'yasm'
  depends_on 'doxygen'

  def install
    ENV.x11
    # Determine the arch
    arch = MacOS.prefer_64_bit? ? 'x86_64' : 'i386'

    args = %W[--prefix=#{prefix}
              --arch=#{arch}
              --force
              --launch
              --fetch=curl
              --enable-ff-mpeg2
              --enable-fdk-aac
              --enable-local-yasm
              --enable-local-autotools
              ]

    system "./configure", *args

    # system "cd build"
    # system "make"

    prefix.install "build/xroot/HandBrake.app"
    bin.install "build/xroot/HandBrakeCLI"
  end

  def caveats; <<-EOS.undent

    To install:
    brew install --HEAD https://raw2.github.com/joethemongoose/homebrew/master/handbrake.rb

    ---

    Handbrake requires either one of two things prior to installing:
    1) Install XQuartz at http://xquartz.macosforge.org/landing/
    2) sudo mkdir -p /usr/X11/var/cache/fontconfig
    Either one of those steps should allow for a easy install -- otherwise it will error out.

    ---

    HandBrake.app installed to:
      #{prefix}
    To link the application to a normal Mac OS X location:
      brew linkapps
    or:
      ln -s #{prefix}/HandBrake.app /Applications
    EOS
  end
end
