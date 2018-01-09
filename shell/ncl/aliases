#!/usr/bin/env sh

###########################################################
# NCL Dev
###########################################################

alias runCharlie='~/bin/charlieLoop'

# Percona
alias runPercona='sudo service mysql start'
alias stopPercona='sudo service mysql stop'


# Make our common paths global for use in other programs.
export NCL_SRC=/home/bryan/src
export NCL_COM_PATH=$NCL_SRC/ncl-com
export NCL_CBE_PATH=$NCL_SRC/cbe-java/cbe
export NCL_SHOREX_PATH=$NCL_SRC/ncl-shore-excursions
export NCL_SEARCH_PATH=$NCL_SRC/nclh-search-service
export NCL_STATIC_PATH=$NCL_SRC/static


###########################################################
# NCL Common
###########################################################

function nclCom() {
   cd $NCL_COM_PATH
   sbt -jvm-debug 9393  "run 9000 -Dconfig.file=conf/local.conf -Dhttps.port=9443 -Dscala.color=true"
}

function nclComCompile() {
   cd $NCL_COM_PATH
   sbt clean compile
}

function nclComComplete() {
  nclComCompile
  nclCom
}

# function nclcom-custom-run() {
#    cd $NCL_COM_PATH
#    sbt "run -Dconfig.file=conf/local.conf -Dlogger.file=$HOME/src/ncl-com/conf/logger-qa.xml"
# }

###########################################################
# NCL Shorex
###########################################################

function nclShorex() {
   cd $NCL_SHOREX_PATH
   sbt -jvm-debug 9899  "run 9001 -Dconfig.file=conf/local.conf -Dscala.color=true"
}

###########################################################
# NCL Search
###########################################################

function nclSearch() {
   cd $NCL_SEARCH_PATH
   sbt -jvm-debug 9799  "~run 9003"
}

###########################################################
# NCL CBE - Customer Booking Engine
###########################################################

export CBE_LOG_DIR="/home/bryan/.cbe"

function setCbeLogDirectory() {
    echo "Running Jetty..."
    if [ ! -d $CBE_LOG_DIR ]; then
        echo "No log directory found, using home"
        export CBE_LOG_DIR=~/
    fi
}

function nclCbe() {
    cd $NCL_CBE_PATH
    setCbeLogDirectory

    cd cbe-war
    mvn jetty:run \
      -U -s $NCL_CBE_PATH/settings.xml \
      -Djetty.port=8080 \
      -Dbuild=local \
      -Dcbe.config.env=local \
      -Dcbe.config.path=file:///home/bryan/src/cbe-java/cbe/properties \
      | tee $CBE_LOG_DIR/cbe-server.log
}

function nclCbeCompile() {
    cd $NCL_CBE_PATH
    setCbeLogDirectory

    mvn clean install -U -s settings.xml \
      -Dbuild=local \
      -DskipTests=true \
      | tee $CBE_LOG_DIR/cbe-build.log
}

function nclCbeDebug() {
    cd $NCL_CBE_PATH
    setCbeLogDirectory

#  export MAVEN_OPTS=''
# export JAVA_OPTS='-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8070,server=y,suspend=n'

    cd cbe-war
    mvnDebug jetty:run \
      -s $NCL_CBE_PATH/settings.xml \
      -Djetty.port=8080 \
      -Dbuild=local \
      -Dcbe.config.env=local \
      -Dcbe.config.path=file:///home/bryan/src/cbe-java/cbe/properties \
      -DskipTests \
      | tee $CBE_LOG_DIR/cbe-server.log
}

function nclCbeCompileDebug() {
   nclCbeCompile
   nclCbeDebug
}

function nclCbeComplete() {
   nclCbeCompile
   nclCbe
}

function nclCbeClear() {
   curl -X POST localhost:8080/cache
}

###########################################################
# NCL Drupal
###########################################################

# Check that a running container with given name does not exist.
dockerRunningContainerExists() {
  # https://docs.docker.com/engine/reference/commandline/ps/#usage
  local containerName=$1
  docker ps -q -f name=$containerName
}

# Check that an exited container with given name does not exist.
dockerExitedContainerExists() {
  # https://docs.docker.com/engine/reference/commandline/ps/#usage
  local containerName=$1
  docker ps -aq -f status=exited -f name=$containerName
}


function startDrupal() {
  # Container should exist but be exited.
  if [ "$(dockerExitedContainerExists drupal)" ]; then
    docker start drupal
  else
    printf "Building drupal first...\n"
    buildDrupal
    startDrupal
  fi
}

function stopDrupal() {
  # Container should be running to prevent cmd err.
  if [ "$(dockerRunningContainerExists drupal)" ]; then
    docker stop drupal
  fi
}

function buildDrupal() {
  # If our container isn't already running:
  if [ ! "$(dockerRunningContainerExists drupal)" ]; then
      # If our container is exited, remove it:
      if [ "$(dockerExitedContainerExists drupal)" ]; then
          docker rm drupal
      fi
      # build and run container
      docker run -t -d -p 8888:80 -i --name drupal -v $HOME/src/static:/var/www/static -v $HOME/src/drupal:/var/www/html/ ncl/php53 /bin/bash
  else
    printf "Container drupal is running.\nExit it before building.\n"
  fi
}

alias restartDrupal='stopDrupal && startDrupal'
alias connectDrupal='docker exec -i -t drupal /bin/bash'

alias drushCC='docker exec -it drupal  /root/drushCC.sh'
alias drushUpDb='docker exec -it drupal  /root/drushUpDb.sh'

alias patchDrupal='cd ~/src/drupal && scripts/patch-drupal'
alias unPatchDrupal='cd ~/src/drupal && scripts/patch-drupal -r'


# from Matti
# alias runDrupal='docker run -d -t -p 8888:80 -i --name drupal -v $HOME/scripts:/tmp  -v $HOME/src/static:/var/www/static  -v $HOME/src/drupal:/var/www/html/ -v $HOME/src/NCL-Dashboard:/var/www/dashboard/ ncl/php53 /bin/bash'


# function sync-web-files() {
#    echo “Starting Syncing drupal_files”;
#    sleep 5;
#    rsync -az --progress --delete apache@192.168.200.86:/share/dr/files/ /home/bryan/src/drupal/files;
#    echo “Finished Syncing drupal_files”sleep 5;

#    echo “rsyncing the drupal_files/sites/default/”
#    sleep 5;
#    rsync -az --progress --delete apache@192.168.200.86:/share/dr/sites/default/files/ /home/bryan/src/drupal/sites/default/files;
#    echo “finished rsyncing the drupal_files/sites/default/”
# }

