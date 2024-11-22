#!/bin/bash

# File to save the output
output_file="utility_versions_and_licenses.csv"

# Header of the output file
echo -e "Name,Version,License" > "$output_file"

# List of utilities and libraries
utilities=(
  "build-essential"
  "net-tools"
  "python3-venv"
  "qtbase5-dev"
  "qt5-qmake"
  "pkg-config"
  "qtwayland5"
  "libx11-dev"
  "libxext-dev"
  "python3-pyelftools"
  "python3-ftdi1"
  "python3-serial"
  "libncurses-dev"
  "docker"
  "ubuntu"
  "code"
  "node"
  "nvm"
  "apache2"
)

# Loop through each utility/library
for utility in "${utilities[@]}"
do
  # Get the version of the utility/library using dpkg-query if installed via dpkg
  version=$(dpkg-query -W -f='${Version}' $utility 2>/dev/null)
  
  # If not found with dpkg, try snap (for docker, code, etc.)
  if [ -z "$version" ]; then
    version=$(snap list $utility | awk 'NR==2 {print $2}' 2>/dev/null)
  fi
  
  # If not found with snap, try npm (for node and nvm)
  if [ -z "$version" ]; then
    version=$(npm list -g $utility --depth=0 2>/dev/null | grep "$utility" | awk '{print $2}' | sed 's/[()|@]//g')
  fi
  
  # For Ubuntu, use lsb_release or /etc/os-release
  if [ "$utility" == "ubuntu" ]; then
    version=$(lsb_release -d | awk -F"\t" '{print $2}' 2>/dev/null)
  fi
  
  # If the utility is still not found, skip to next
  if [ -z "$version" ]; then
    continue
  fi
  
  # Get the license information using dpkg-query if available
  license=$(dpkg-query -W -f='${License}' $utility 2>/dev/null)
  
  # If license info is not available, use "Unknown"
  if [ -z "$license" ]; then
    license="Unknown"
  fi
  
  # For Docker, Node.js, and NVM, set default licenses if not found
  if [ "$utility" == "docker" ]; then
    license="Apache License 2.0"
  fi
  if [ "$utility" == "node" ]; then
    license="MIT License"
  fi
  if [ "$utility" == "nvm" ]; then
    license="MIT License"
  fi

  # Write to the output file in CSV format
  echo -e "\"$utility\",\"$version\",\"$license\"" >> "$output_file"
done

echo "The information has been saved to $output_file"

