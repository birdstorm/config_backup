export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=${PATH}:/usr/local/mysql/bin
export GOROOT=/Users/birdstorm/sdk/go1.25.0
export PATH=$GOROOT/bin:$PATH
export PATH=$(go env GOPATH)/bin:$PATH
export GOPATH=$(go env GOPATH)
export GOROOT_BOOTSTRAP=$GOROOT
#export GOPROXY=https://mirrors.aliyun.com/goproxy/

#export PYTHONPATH=$PYTHONPATH:/Users/birdstorm/Library/Python/3.9/lib/python/site-packages
export PATH=$PATH:/Users/birdstorm/Library/Python/3.9/bin
export PATH=$PATH:/opt/homebrew/bin
export PATH=/Users/birdstorm/.pixi/bin:$PATH
export PATH=/opt/homebrew/opt/llvm/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

source $HOME/.cargo/env

export https_proxy=http://127.0.0.1:7890
export http_proxy=http://127.0.0.1:7890
export all_proxy=socks5://127.0.0.1:7890

source "/Users/birdstorm/.sdkman/bin/sdkman-init.sh"

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

#alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -la'
alias grep='grep --color'

unset LSCOLORS
export CLICOLOR=0
export CLICOLOR_FORCE=0

# git
alias gco='git checkout'	# git checkout
alias gcp='git cherry-pick'	# git cherry-pick
alias gcg='git commit -m'	# git commit
alias gca='git commit -a -m'	# git commit add all
alias gpr='git push'	# git push to remote
alias gpo='git push origin'	# git push to origin
alias grv='git remote -vv'	# git remote
alias gbv='git branch -vv'	# git branch
alias gfp='git fetch -p --all'	# git fetch all
function gitrefresh {
	for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`
	do
		git branch -D $branch
	done
}
alias grp='gfp && gitrefresh && git pull'	# git refresh and fetch and pull
alias gst='git status'	# show git status
alias grs='grp && gst'	# show latest status
alias grb='grp && gbv'	# show latest branches
alias gra='grp && gbv && gst' # show latest

# transfer.sh
transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

# google-java-format
google-java-format-diff() {
	google-java-format $1 | diff $1 -
}

# everything else
# export GREP_OPTIONS=
# export GREP_COLOR=
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35;40'

alias gb='./gradlew build'
alias gbt='./gradlew build -x test'
export OPENSSL_ROOT_DIR=/opt/homebrew/opt/openssl@3

source /opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/path.zsh.inc
source /opt/homebrew/Caskroom/gcloud-cli/latest/google-cloud-sdk/completion.zsh.inc
source /Users/birdstorm/.cocli.completion.zsh
