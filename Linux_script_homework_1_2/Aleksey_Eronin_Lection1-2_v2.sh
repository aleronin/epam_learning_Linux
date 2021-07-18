#!/bin/bash

exec > >(tee -a stdout.log) 2> >(tee -a stderr.log >&2)  #Про сделать логи переменными не понял. Нужно дополнительную функцию, наверное, написать?

args=$@   #Надеюсь, что правильно понял про перемещение логики

environments() {
  if [[ $args =~ basic ]]; then
    echo -e "\nThese are environment outputs:"   #Про это молчу..правда пропустил
    printenv | grep SHELL
    printenv | grep -w USER
    printenv | grep SESSION_MANAGER
  else
    >&2 echo -e "\nPlease enter basic argument"
  fi
}


statistics() {
  if [[ $args =~ stat ]]; then
    echo -e "\nThese are statistic outputs:"
    echo "1.Stat of current directory:"
    stat .                              #А здесь все таки пойдет так?
    echo "2.List Files of current directory:"
    ls -liu .
    echo "3.Searching for logs in current directory:"
    find . -name "*.log" -type f
  else
    >&2 echo -e "\nPlease enter stat argument"
  fi
}


environments
sleep 0.5      #Добавил, потому что при вводе одного аргумента stat фраза Please enter basic argument слетала внутрь вывода statistics
statistics


