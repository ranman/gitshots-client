#!/bin/bash

###############################################################################
# Instalation Script for Gitshots
# Repository: https://github.com/ranman/gitshots-client
# gitshots.com - Take a picture and collect some stats every time you commit!
###############################################################################

POST_COMMIT_FILE=~/bin/post-commit.py
GIT_TEMPLATE_DIR=~/.git_template
GIT_TEMPLATE_HOOKS_DIR=$GIT_TEMPLATE_DIR/hooks

printf "\nPutting post-commit.py in bin.\n"
if [[ -f $POST_COMMIT_FILE ]]; then
   rm ~/bin/post-commit.py
else
	mkdir -p ~/bin
fi

if [[ $1 && -f $1 ]]; then
	ln -s $1 $POST_COMMIT_FILE
else
	curl https://raw.githubusercontent.com/ranman/gitshots-client/master/post-commit.py > $POST_COMMIT_FILE
fi

printf "\nCreating git_template dir.\n"
mkdir -p $GIT_TEMPLATE_HOOKS_DIR
git config --global init.templatedir '$GIT_TEMPLATE_DIR'

printf "\nCreating post-commit hook.\n"
cat << EOF > $GIT_TEMPLATE_HOOKS_DIR/post-commit
#!/bin/sh
/usr/bin/python2.7 $POST_COMMIT_FILE
EOF
chmod +x $GIT_TEMPLATE_HOOKS_DIR/post-commit

printf "\nValidating CoreLocationCLI dependency\n"
brew install corelocationcli
printf "\nValidating imagesnap dependency\n"
brew install imagesnap
printf "\nValidating requests dependency, if this fails fix your python or use sudo\n"
pip install requests

printf "\nNow just run git init in any repo you want to use the commit hook in!\n"
