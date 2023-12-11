#!/bin/bash

function ProgressBar {

  let _progress=(${1}*100/${2}*100)/100
  let _done=(${_progress}*4)/10
  let _left=40-$_done

  _fill=$(printf "%${_done}s")
  _empty=$(printf "%${_left}s")

  printf "\rProgress : [${_fill// /#}${_empty// /-}] ${_progress}%%"
}

help() {
  echo -e "  - [ StressTester ] -\n\n  -y, --yandex         use yandex cloud\n  -v, --vk             use vk cloud\n  -h, --help           output help menu\n"
  exit
}

if [ $# -eq 0 ]
  then
    help
fi

if [ $1 == "--yandex" ] || [ $1 == "-y" ]; then
  export YC_TOKEN=$(yc iam create-token)
  export YC_CLOUD_ID=$(yc config get cloud-id)
  export YC_FOLDER_ID=$(yc config get folder-id)
  ip=$(cd ./terraform-yandex-cloud && terraform init && terraform fmt && terraform validate && terraform plan && terraform apply | tee /dev/tty)
  global_ip=$(echo "$ip" | tail -2 | cut -d' ' -f3 | head -n -1)
  global_ip="${global_ip:1:-1}"
  #echo "$global_ip"
  sed -i -E "s/((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])/$global_ip/" ./ansible/hosts.ini
  echo "Pseudo loading to wait when the infra is set up"
  _start=1
  _end=400

  for number in $(seq ${_start} ${_end})
  do
    sleep 0.1
    ProgressBar ${number} ${_end}
  done

  (cd ansible && ansible-playbook ./playbooks/ab/main.yml)
elif [ $1 == "--vk" ] || [ $1 == "-v" ]; then
    ip=$(cd ./terraform-vk-cloud && terraform init && terraform fmt && terraform validate && terraform plan && terraform apply | tee /dev/tty)
elif [ $1 == "--help" ] || [ $1 == "-h" ]; then
  help
else
  help
fi


#ansible-playbook playbooks/ab/main.yml
