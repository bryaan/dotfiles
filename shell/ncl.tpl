#!/usr/bin/env sh

###########################################################
# NCL Dev
###########################################################

function runCharlie
  ~/bin/charlieLoop
end

# Make our common paths global for use in other programs.
set -x NCL_SRC /home/bryan/src
set -x NCL_COM_PATH $NCL_SRC/ncl-com
set -x NCL_CBE_PATH $NCL_SRC/cbe-java/cbe
set -x NCL_SHOREX_PATH $NCL_SRC/ncl-shore-excursions
set -x NCL_SEARCH_PATH $NCL_SRC/nclh-search-service
set -x NCL_STATIC_PATH $NCL_SRC/static


###########################################################
# NCL Common
###########################################################

function ncl.com.run
   cd $NCL_COM_PATH
   sbt -jvm-debug 9393  "run 9000 -Dconfig.file=conf/local.conf -Dhttps.port=9443 -Dscala.color=true"
end

function ncl.com.compile
   cd $NCL_COM_PATH
   sbt clean compile
end

function ncl.com.debug
   cd $NCL_COM_PATH
   sbt ensimeRunDebug
   # -Dconfig.file=conf/local.conf -Dhttps.port=9443 -Dscala.color=true
end
# function nclComComplete
#   nclComCompile
#   nclCom
# end

# function nclcom-custom-run() {
#    cd $NCL_COM_PATH
#    sbt "run -Dconfig.file=conf/local.conf -Dlogger.file=$HOME/src/ncl-com/conf/logger-qa.xml"
# }

###########################################################
# NCL Shorex
###########################################################

function ncl.shorex.run
   cd $NCL_SHOREX_PATH
   sbt -jvm-debug 9899  "run 9001 -Dconfig.file=conf/local.conf -Dscala.color=true"
end

###########################################################
# NCL Search
###########################################################

function ncl.search.run
   cd $NCL_SEARCH_PATH
   sbt -jvm-debug 9799  "~run 9003"
end

###########################################################
# NCL CBE - Customer Booking Engine
###########################################################

set -x CBE_LOG_DIR $HOME/.cbe

function set_cbe_log_directory
    echo "Running Jetty..."
    if not test -d $CBE_LOG_DIR
        echo "No log directory found, using home"
        set -x CBE_LOG_DIR ~/
    end
end

function ncl.cbe.clear
   curl -X POST localhost:8080/cache
end

function ncl.cbe.compile
    cd $NCL_CBE_PATH
    set_cbe_log_directory

    mvn clean install -U -s settings.xml \
      -Dbuild=local \
      -DskipTests=true \
      # >| /usr/bin/vim
      | tee $CBE_LOG_DIR/cbe-build.log
    # vimpager $CBE_LOG_DIR/cbe-build.log
end

function ncl.cbe.run
    cd $NCL_CBE_PATH
    set_cbe_log_directory

    cd cbe-war
    mvn jetty:run \
      -U -s $NCL_CBE_PATH/settings.xml \
      -Djetty.port=8080 \
      -Dbuild=local \
      -Dcbe.config.env=local \
      -Dcbe.config.path=file:///home/bryan/src/cbe-java/cbe/properties \
      | tee $CBE_LOG_DIR/cbe-server.log
end

function ncl.cbe.debug
    cd $NCL_CBE_PATH
    set_cbe_log_directory

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
end

function ncl.cbe.debug.complete
   ncl.cbe.compile
   ncl.cbe.debug
end

function ncl.cbe.complete
   ncl.cbe.compile
   ncl.cbe.run
end

###########################################################
# NCL Drupal
###########################################################

# Check that a running container with given name does not exist.
function dockerRunningContainerExists
  # https://docs.docker.com/engine/reference/commandline/ps/#usage
  set -l containerName $argv
  docker ps -q -f name=$containerName
end

# Check that an exited container with given name does not exist.
function dockerExitedContainerExists
  # https://docs.docker.com/engine/reference/commandline/ps/#usage
  set -l containerName $argv
  docker ps -aq -f status=exited -f name=$containerName
end


function drupal.start
  # Container should exist but be exited.
  if dockerExitedContainerExists drupal
    docker start drupal
  else
    printf "Building drupal first...\n"
    drupal.build
    drupal.start
  end
end

function drupal.stop
  # Container should be running to prevent cmd err.
  if dockerRunningContainerExists drupal
    docker stop drupal
  end
end

function drupal.restart
  drupal.stop
  drupal.start
end

function drupal.build
  # If our container isn't already running:
  if dockerRunningContainerExists drupal
      # If our container is exited, remove it:
      if dockerExitedContainerExists drupal
          docker rm drupal
      end
      # build and run container
      docker run -t -d -p 8888:80 -i --name drupal -v $HOME/src/static:/var/www/static -v $HOME/src/drupal:/var/www/html/ ncl/php53 /bin/bash
  else
    printf "Container drupal is running.\nExit it before building.\n"
  end
end

function drupal.connect
  docker exec -i -t drupal /bin/bash
end

function drupal.drushCC
  docker exec -it drupal  /root/drushCC.sh
end
function drupal.drushUpDb
  docker exec -it drupal  /root/drushUpDb.sh
end

function drupal.patch
  cd ~/src/drupal; scripts/patch-drupal
end
function drupal.unpatch
  cd ~/src/drupal; scripts/patch-drupal -r
end

# from Matti
# alias runDrupal='docker run -d -t -p 8888:80 -i --name drupal -v $HOME/scripts:/tmp  -v $HOME/src/static:/var/www/static  -v $HOME/src/drupal:/var/www/html/ -v $HOME/src/NCL-Dashboard:/var/www/dashboard/ ncl/php53 /bin/bash'
