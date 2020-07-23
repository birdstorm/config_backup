#!/bin/zsh

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
export RUST_BACKTRACE=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -la'
alias grep='grep --color'


unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1


# TiSpark
export tispark_version='2.3.0-SNAPSHOT'
alias spark-shell-run='spark-shell --jars assembly/target/tispark-assembly-${tispark_version}.jar'
alias spark-shell-jdbc='spark-shell --jars /Users/birdstorm/Downloads/mysql-connector-java-5.1.44/mysql-connector-java-5.1.44-bin.jar -i /usr/local/spark-2.3.3/jdbc.scala'
alias spark-shell-debug='spark-shell-run --conf spark.driver.extraJavaOptions=-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005'
alias mi='mvn clean install'
alias mit='mi -Dmaven.test.skip=true'
alias mip='mit -P spark-2.4'
alias mir='mip && spark-shell-run'
alias mid='mip && spark-shell-debug'

# shells
alias tidb-shell='mysql -h 127.0.0.1 -P 4000 -uroot'
alias mysql-shell='mysql -h 127.0.0.1 -uroot -proot'

# show versions
alias pd-version='./bin/pd-server -V'
alias kv-version='./bin/tikv-server -V'
alias db-version='./bin/tidb-server -V'

# parameter
# export pd-parameter-settings='--name="pd" --data-dir="pd"'
# export kv-parameter-settings='--config="./last_tikv.toml" --pd-endpoints="127.0.0.1:2379"'
# export rngine-parameter-settings='--addr "127.0.0.1:20332" --advertise-addr "127.0.0.1:20332" --pd "127.0.0.1:2379" --config="./rngine.toml"'

# start components
alias start-pd='./bin/pd-server --name="pd" --data-dir="pd"'
alias start-kv='./bin/tikv-server --config="./last_tikv.toml" --pd-endpoints="127.0.0.1:2379"'
alias start-kv-release='./target/release/tikv-server --config="./last_tikv.toml" --pd-endpoints="127.0.0.1:2379"'
alias start-kv-debug='./target/debug/tikv-server --config="./last_tikv.toml" --pd-endpoints="127.0.0.1:2379"'
alias start-rngine='./bin/tikv-server --addr "127.0.0.1:20332" --advertise-addr "127.0.0.1:20332" --pd "127.0.0.1:2379" --config="./rngine.toml"'
alias start-rngine-debug='./target/debug/tikv-server --addr "127.0.0.1:20332" --advertise-addr "127.0.0.1:20332" --pd "127.0.0.1:2379" --config="./rngine.toml"'
alias start-db='./bin/tidb-server --path="127.0.0.1:2379" --store=tikv'
alias start-flash='./theflash server --config config.xml'
alias start-flash-client='./theflash client'
# alias stop-tidb-componenets='stop-db && stop-kv && stop-pd'
# alias start-tidb-components='start-pd && start-kv && start-db'

# git
alias gco='git checkout'	# git checkout
alias gcp='git cherry-pick'	# git cherry-pick
alias gcm='git commit -m'	# git commit
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
alias grp='gfp && gitrefresh'	# git refresh and fetch
alias gst='git status'	# show git status
alias grs='grp && gst'	# show latest status
alias grb='grp && gbv'	# show latest branches
alias gra='grp && gbv && gst' # show latest

# transfer.sh
transfer() { if [ $# -eq 0 ]; then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

# gcp beta
# alias google-cloud-instance1='gcloud beta compute ssh --zone "asia-northeast1-b" "instance-1" --project "shanawyf"'
# alias google-cloud-instance2='gcloud beta compute ssh --zone "us-central1-c" "instance-us" --project "shanawyf"'

# everything else
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35;40'
export http_proxy='http://127.0.0.1:1087'
export https_proxy='http://127.0.0.1:1087'

# Iterm2
export PATH=/Users/birdstorm/.tiup/bin:$PATH
