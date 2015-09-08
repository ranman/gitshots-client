# Gitshots — Remember every commit
Take a picture and collect some stats every time you commit! - By using `imagesnap` gitshots will make you remember every commit you have ever done, it also can collect files changed and your location.
Everything will be stored locally. You can upload your gitshots to a [remote server](https://github.com/ranman/gitshots-server) of your own, or you can use the public [ranman's gitshot server](http://gitshots.ranman.org) and share your gitshots with the world.

![http://gitshots.com/ranman](https://raw.githubusercontent.com/ranman/gitshots-client/master/images/gitshot_example.jpg)

Taking a gitshot on every commit
-------------

### Installation
* Required: python `requests` library
```bash
 pip install requests
```
* Required: `imagesnap`, on OSX you can easily install it with [homebrew](http://mxcl.github.io/homebrew/):
```bash
brew install imagesnap
```
* Optional: CoreLocationCLI to fetch your location from CoreLocation 
```bash
 cd /tmp
 git clone git@github.com:fulldecent/corelocationcli.git
 cd corelocationcli
 xcodebuild
 mv build/Release/CoreLocationCLI /usr/bin
```
* Required: Install post-commit.py 
```bash
cd /tmp
git clone git@github.com:ranman/gitshots-client.git
chmod +x install.sh
./install.sh
```

### Optional Configurations
Add the following line to your `.bash_profile` or `.bashrc`. If you don't add this line with your server URL, your gitshots will be posted to [ranman's gitshot server](http://gitshots.ranman.org).

    export GITSHOTS_SERVER_URL=<your gitshots server url>


Enjoy!
-------------
Now just run git init in any repo you want to use the commit hook in!

### License
Licensed under the MIT License