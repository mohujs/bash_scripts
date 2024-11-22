#!/bin/bash

# Output file
output_file="versions.csv"

# Input file containing package names
input_file="packages.txt"

# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
    echo "Input file '$input_file' not found!"
    exit 1
fi

# Header for the CSV file
echo "Package,Version" > "$output_file"

# Function to check version
check_version() {
    package_name=$1
    # Get version output, trying multiple common flags
    version=$($package_name --version 2>/dev/null || $package_name -v 2>/dev/null || $package_name version 2>/dev/null)

    # Extract only the version number using regex
    version=$(echo "$version" | grep -o '[0-9]\+\.[0-9]\+\(\.[0-9]\+\)*' | sort -V | tail -n 1)

    if [ -z "$version" ]; then
        version="Not installed"
    fi

    echo "$package_name,$version" >> "$output_file"
}

# Read each package from the input file
while IFS= read -r package; do
    check_version "$package"
done < "$input_file"

echo "Version check complete. Results saved in $output_file."

