require 'formula'

class Handbrake < Formula
  url 'svn://svn.handbrake.fr/HandBrake/trunk', :using => :svn, :tag => '0.9.9.1'
  homepage 'http://handbrake.fr'

  depends_on 'wget'
  depends_on 'yasm'

  def install
    # Determine the arch
    arch = MacOS.prefer_64_bit? ? 'x86_64' : 'i386'

    args = ["--arch=#{arch}",
           "--force",
           "--launch",
           "--launch-jobs=0",
           "--prefix=/usr/local/Cellar/handbrake/0.9.9.1"
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
