#!/bin/bash

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if go is installed
if ! command_exists go; then
  # Install Go
  echo "Installing Go..."
  sudo apt update
  sudo apt install -y golang
fi


export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"


temp_dir=$(mktemp -d)
echo "Temporary directory: $temp_dir"
echo "cloning the Samora-Lang repository ..."

git clone https://github.com/GraHms/Samora-Lang "$temp_dir"
cd "$temp_dir"

echo "Building..."
go build -o "samora" main.go

echo "Installing samora-lang"

sudo cp samora /usr/bin/samora

if command_exists samora; then
 echo "Installation Completed."
else
 echo "Something went wrong during the installation."
fi

rm -rf "$temp_dir"

