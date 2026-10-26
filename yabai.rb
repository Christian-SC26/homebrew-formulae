class Yabai < Formula
  desc "A tiling window manager for macOS based on binary space partitioning."
  homepage "https://github.com/Christian-SC26/yabai"
  url "https://github.com/Christian-SC26/yabai/releases/download/v7.1.34/yabai-v7.1.34.tar.gz"
  sha256 "34c09d15bc371aeb85b30c93862f7419c34e9c3d0f80dee65e850c46aa36ffa6"
  head "https://github.com/Christian-SC26/yabai.git"

  depends_on :macos => :big_sur

  def install
    man.mkpath

    if build.head?
      system "make", "-j1", "install"
      bin.install "#{buildpath}/bin/yabai"
    elsif File.exist?("#{buildpath}/yabai")
      bin.install "#{buildpath}/yabai"
    elsif File.exist?("#{buildpath}/bin/yabai")
      bin.install "#{buildpath}/bin/yabai"
    elsif File.exist?("#{buildpath}/archive/bin/yabai")
      bin.install "#{buildpath}/archive/bin/yabai"
    end

    if File.exist?("#{buildpath}/doc/yabai.1")
      man1.install "#{buildpath}/doc/yabai.1"
    elsif File.exist?("#{buildpath}/archive/doc/yabai.1")
      man1.install "#{buildpath}/archive/doc/yabai.1"
    end

    if File.exist?("#{buildpath}/examples/yabairc")
      (pkgshare/"examples").install "#{buildpath}/examples/yabairc"
      (pkgshare/"examples").install "#{buildpath}/examples/skhdrc" if File.exist?("#{buildpath}/examples/skhdrc")
    elsif File.exist?("#{buildpath}/archive/examples/yabairc")
      (pkgshare/"examples").install "#{buildpath}/archive/examples/yabairc"
      (pkgshare/"examples").install "#{buildpath}/archive/examples/skhdrc" if File.exist?("#{buildpath}/archive/examples/skhdrc")
    end
  end

  def caveats
    <<~EOS
      Copy the example configuration into your home directory:
        cp #{opt_pkgshare}/examples/yabairc ~/.yabairc
        cp #{opt_pkgshare}/examples/skhdrc ~/.skhdrc

      If you want yabai to be managed by launchd (start automatically upon login):
        yabai --start-service

      When running as a launchd service logs will be found in:
        /tmp/yabai_<user>.[out|err].log

      If you are using the scripting-addition; remember to update your sudoers file:
        sudo visudo -f /private/etc/sudoers.d/yabai

      Build the configuration row by running:
        echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa"

      README: https://github.com/Christian-SC26/yabai/wiki/Installing-yabai-(latest-release)#configure-scripting-addition
    EOS
  end

  test do
    assert_match "yabai-v#{version}", shell_output("#{bin}/yabai --version")
  end
end
