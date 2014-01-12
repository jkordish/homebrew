require 'formula'

class Handbrake < Formula
  HEAD 'svn://svn.handbrake.fr/HandBrake/trunk'
  homepage 'http://handbrake.fr'

  depends_on 'wget'
  depends_on 'yasm'

  def install
    # Determine the arch
    arch = MacOS.prefer_64_bit? ? 'x86_64' : 'i386'

./configure --launch --launch-jobs=0
    args = ["--arch=#{arch}",
           "--force",
           "--launch",
           "--launch-jobs=0",
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
