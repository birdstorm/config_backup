export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_141.jdk/Contents/Home
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
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export PATH=$PATH:/usr/local/sbin
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias l='ls -la'
alias grep='grep --color'
export tispark_version='1.1-SNAPSHOT'
alias spark-shell-run='spark-shell --jars target/tispark-core-${tispark_version}-jar-with-dependencies.jar'
alias spark-shell-debug='spark-shell-run --conf spark.driver.extraJavaOptions=-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005'
alias mi='mvn clean install'
alias mit='mi -Dmaven.test.skip=true'
alias mir='mit && spark-shell-run'
alias mid='mit && spark-shell-debug'
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

function title {
    echo -ne "\033]0;"$*"\007"
}

if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	. /usr/local/etc/bash_completion.d/git-completion.bash
fi

