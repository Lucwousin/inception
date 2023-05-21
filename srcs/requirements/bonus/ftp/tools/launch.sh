#!/bin/sh

start_server() {
  exec vsftpd /etc/vsftpd/vsftpd.conf
}

stop_server() {
  echo "It's TIME to STOP!"
  pid=$(cat /var/run/vsftpd/vsftpd.pid)
  kill -SIGTERM "$pid"
  wait "$pid"
}

trap stop_server INT TERM
start_server &
pid=$!

mkdir -p /var/run/vsftpd
echo "$pid" > /var/run/vsftpd/vsftpd.pid
wait "$pid"
