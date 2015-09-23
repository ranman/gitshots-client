#!/bin/bash

###############################################################################
# Instalation Script for Gitshots
# Repository: https://github.com/ranman/gitshots-client
# gitshots.com - Take a picture and collect some stats every time you commit!
###############################################################################

USERHOME=$(dscl . -read /Users/`whoami` NFSHomeDirectory | awk -F": " '{print $2}')
POST_COMMIT_FILE=${USERHOME}/bin/post-commit.py
GIT_TEMPLATE_DIR=${USERHOME}/.git_template
GIT_TEMPLATE_HOOKS_DIR=${GIT_TEMPLATE_DIR}/hooks

printf "\nPutting post-commit.py in bin.\n"
if [[ -f $POST_COMMIT_FILE ]]; then
   printf "\nRemoving old file: $POST_COMMIT_FILE\n"
   rm $POST_COMMIT_FILE
else
	mkdir -p ~/bin
fi

if [[ $1 && -f $1 ]]; then
   	printf "\nSymbolic link from: $1 to $POST_COMMIT_FILE\n"
	ln -s $1 $POST_COMMIT_FILE
else
	printf "\nDownload from github master branch: $POST_COMMIT_FILE\n"
	curl https://raw.githubusercontent.com/ranman/gitshots-client/master/post-commit.py > $POST_COMMIT_FILE
fi

printf "\nCreating git_template dir.\n"
mkdir -p $GIT_TEMPLATE_HOOKS_DIR
git config --global init.templatedir $GIT_TEMPLATE_DIR

printf "\nCreating post-commit hook.\n"
cat << EOF > $GIT_TEMPLATE_HOOKS_DIR/post-commit
#!/bin/sh
/usr/bin/python2.7 $POST_COMMIT_FILE
EOF
chmod +x $GIT_TEMPLATE_HOOKS_DIR/post-commit

if [[ !($2 && $2 == "--no-dependencies") ]]; then
	printf "Installing CoreLocationCLI dependency\n"
	brew install corelocationcli
	printf "Installing imagesnap dependency\n"
	brew install imagesnap
	printf "Installing requests dependency, if this fails fix your python or use sudo\n"
	pip install requests
fi

printf "\nNow just run git init in any repo you want to use the commit hook in!"
printf "\ngitshots.com - Take a picture and collect some stats every time you commit!\n"
