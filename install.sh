#!/bin/bash

print_message() {
  txtgreen='\e[0;32m'
  echo -e "${txtgreen}green print_message"
}

print_message

read
