export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=${PATH}:/usr/local/mysql/bin
export PATH=$PATH:$(go env GOPATH)/bin
export GOPATH=$(go env GOPATH)
export PATH=$HOME/Downloads/apache-maven-3.5.0/bin:$PATH
export PATH=$HOME/Downloads/protoc-3.3.0-osx-x86_64/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export HADOOP_HOME=/usr/local/Cellar/hadoop/2.8.0  #your Hadoop path
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib
export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_HOME/lib/native"
export HIVE_HOME=/usr/local/Cellar/hive/2.3.1/
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$HIVE_HOME/bin
export PATH=$PATH:/usr/local/sbin
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export SPARK_HOME=/usr/local/spark-2.3.3
export PATH=$SPARK_HOME/bin:$PATH
export PYTHON3_HOME=/Users/birdstorm/Library/Python/3.7
export PATH=$PYTHON3_HOME/bin:$PATH
export LLVM_DIR=/usr/local/Cellar/llvm/5.0.1
export RUSTUP_HOME=/Users/birdstorm/.cargo/
export CARGO_HOME=/Users/birdstorm/.cargo/
export GPG_TTY=$(tty)

alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -la'
alias grep='grep --color'
export tispark_version='2.2.0-SNAPSHOT'
alias spark-shell-run='spark-shell --jars assembly/target/tispark-assembly-${tispark_version}.jar'
alias spark-shell-debug='spark-shell-run --conf spark.driver.extraJavaOptions=-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005'
alias mi='mvn clean install'
alias mit='mi -Dmaven.test.skip=true'
alias mip='mit -P spark-2.4'
alias mir='mip && spark-shell-run'
alias mid='mip && spark-shell-debug'
alias tidb-shell='mysql -h 127.0.0.1 -P 4000 -uroot'
alias mysql-shell='mysql -h 127.0.0.1 -uroot -proot'
alias pd-version='./bin/pd-server -V'
alias kv-version='./bin/tikv-server -V'
alias db-version='./bin/tidb-server -V'
alias start-pd='./bin/pd-server --name="pd" --data-dir="pd"'
alias start-kv='./bin/tikv-server --config="./last_tikv.toml" --pd-endpoints="127.0.0.1:2379"'
alias start-kv-debug='./target/debug/tikv-server --config="./last_tikv.toml" --pd-endpoints="127.0.0.1:2379"'
alias start-rngine='./bin/tikv-server --addr "127.0.0.1:20332" --advertise-addr "127.0.0.1:20332" --pd "127.0.0.1:2379" --config="./rngine.toml"'
alias start-db='./bin/tidb-server --path="127.0.0.1:2379" --store=tikv'
# alias stop-tidb-componenets='stop-db && stop-kv && stop-pd'
# alias start-tidb-components='start-pd && start-kv && start-db'
alias gfp='git fetch -p'
function gitrefresh {
	for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`
	do
		git branch -D $branch
	done
}
alias grp='gfp && gitrefresh'
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35;40'
export http_proxy='http://127.0.0.1:1087'
export https_proxy='http://127.0.0.1:1087'

export titleFlag=false

function title {
	if [[ $ITERM_SESSION_ID ]]; then
		titleFlag=true
		echo -ne "\033]0;"$*"\007"
	fi
}

function resetTitle {
	titleFlag=false
}

if [[ $ITERM_SESSION_ID ]]; then
	# Display the current git repo, or directory, in iterm tabs.
	get_iterm_label() {
		if [[ $titleFlag = "false" ]]; then
			if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
				local directory
				directory=${PWD##*/}
				echo -ne "\\033];$directory\\007"
			else
				local branch
				local branchdir
				local commithash
				branchdir=$(basename "$(git rev-parse --show-toplevel)") #| sed -E "s/HEAD detached at //g"
				commithash=$(git rev-parse --short HEAD)
				branch=$(git branch 2>/dev/null | grep -e '\* ' | sed "s/^..\(.*\)/▶ \1/" | sed "/HEAD detached at/s/^.*$/▶ $commithash/")
				echo -ne "\\033];$branchdir $branch\\007"
			fi
		fi
	}
	export PROMPT_COMMAND=get_iterm_label;"${PROMPT_COMMAND}"
fi

if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	. /usr/local/etc/bash_completion.d/git-completion.bash
fi


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
