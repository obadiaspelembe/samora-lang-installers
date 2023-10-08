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

git clone https://github.com/GraHms/Samora-Lang "$temp_dir"
cd "$temp_dir"

echo "Installing samora-lang..."
go build -o "samora" main.go


sudo cp samora /usr/bin/samora

if command_exists samora; then
 echo "Installation Completed."
else
 echo "Something went wrong during the installation."
fi

rm -rf "$temp_dir"

