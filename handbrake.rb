require 'formula'

class Handbrake < Formula
  url 'http://downloads.sourceforge.net/project/handbrake/0.9.9/HandBrake-0.9.9.tar.bz2'
  homepage 'http://handbrake.fr'
  md5 'ee81337a46f8af76599d6038f193a2c1'

  depends_on 'wget'
  depends_on 'yasm'

  def install
    # Determine the arch
    arch = MacOS.prefer_64_bit? ? 'x86_64' : 'i386'

    args = ["--arch=#{arch}",
           "--force",
           "--debug=none"]

    system "./configure", *args

    system "cd build; make"

    prefix.install "build/HandBrake.app"
    bin.install "build/HandBrakeCLI"
  end

  def caveats; <<-EOS.undent
    HandBrake.app installed to:
      #{prefix}

    To link the application to a normal Mac OS X location:
      brew linkapps
    or:
      ln -s #{prefix}/HandBrake.app /Applications
    EOS
  end
end
