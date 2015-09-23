class GitshotsClient < Formula
  desc "Take a picture and collect some stats every time you commit!"
  homepage "https://github.com/ranman/gitshots-client"
  url "https://github.com/ranman/gitshots-client/archive/1.0-alpha5.tar.gz"
  version "1.0-alpha5"
  sha256 "654c69a9af98faf9f135ccd839e690523e2cea2aedc222e688af148101ed7c33"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "requests" => :python
  depends_on "corelocationcli" => :recommended
  depends_on "imagesnap" => :recommended

  def install
    prefix.install "post-commit.py"
    system "./install.sh", "#{prefix}/post-commit.py", "--no-dependencies"
  end

  test do
    (testpath/".gitconfig").write <<-EOS.undent
      [user]
        name = Gitshots Client
        email = email@gitshots.com
      [github]
        user = GitshotsClient
      EOS
    system "git", "init"
    touch "gitshots"
    system "git", "add", "gitshots"
    system "git", "commit", "--verbose", "-m", "Testing Gitshots Client"
    system "python", "#{prefix}/post-commit.py"
  end
end
