class Gitshots < Formula
  desc "Take a picture and collect some stats every time you commit!"
  homepage "https://github.com/ranman/gitshots-client"
  url "https://github.com/ranman/gitshots-client/releases/download/0.1/0.1.tar.gz"
  version "0.1"
  sha256 "20d798a15db5827c9b5c322732fdc26b94c3f70e52e460a3078709b097408645"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "requests" => :python
  depends_on "corelocationcli" => :recommended
  depends_on "imagesnap" => :recommended

  def install
    prefix.install "post-commit.py"
  end

  test do
    system "false"
  end
end
