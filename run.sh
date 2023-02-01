#!/bin/bash

#cpu占用百分比
load=20

count=1
path=/sys/fs/cgroup/cpu/cpu_task


start () {
  if [ ! -d $path ]
  then
      mkdir $path
      echo  ${load}000 > $path/cpu.cfs_quota_us
      echo $$ >> $path/tasks 

      while true
      do
         let count++ 
      done  &
      echo "start success"
   else
      echo "is running"
   fi
}

stop () { 
  if [ -d $path ]
  then
    kill -9 $(cat $path/tasks) 
    sleep 3
    rmdir $path
    echo "stop success"
  else
    echo "not running"
  fi 
}


case $1 in 
  "start")
      start ;;
  "stop")
      stop ;;
  *)
      echo " $0  start | stop ";;

esac

