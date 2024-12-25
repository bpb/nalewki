#!/bin/bash

# Enable verbose mode if -v is passed
if [[ "$1" == "-v" ]]; then
	set -x
fi

# Function to generate a random noun
generate_random_noun() {
	local nouns=("phoenix" "nebula" "falcon" "oasis" "horizon" "ember" "echo" "harbor" "summit" "voyage")
	echo "${nouns[$((RANDOM % ${#nouns[@]}))]}"
}

# Generate a default random project name
default_project_name=$(generate_random_noun)_$(generate_random_noun)

# Retrieve default author name from the system
default_author_name=$(whoami)

# Retrieve default author email from Git configuration
default_author_email=$(git config --global user.email)

# Retrieve default code directory
default_code_directory=~/code/python

# Prompt code directory for input with defaults
read -p "Enter code directory (default: $default_code_directory): " code_directory
code_directory=${code_directory:-$default_code_directory}

# Prompt user for input with defaults
read -p "Enter project name (default: $default_project_name): " project_name
project_name=${project_name:-$default_project_name}

read -p "Enter author name (default: $default_author_name): " author_name
author_name=${author_name:-$default_author_name}

author_email=${author_email:-$default_author_email}

read -p "Enter project description (default: A new project): " project_description
project_description=${project_description:-A new project}
# Get the current directory (template directory)
template_dir=$(pwd)

if [ -d "$code_directory" ]; then
	echo "Directory '$code_directory' already exists."
else
	mkdir -p "$code_directory"
	if [ $? -eq 0 ]; then
		echo "Directory '$code_directory' created successfully."
	else
		echo "Failed to create directory '$code_directory'."
		exit 1
	fi
fi

# Set the new project directory name
new_project_dir="${code_directory}/${project_name}"

# Step 1: Copy the template directory to the new location
echo "Copying template directory..."
rsync -av --exclude='project_init.sh' "$template_dir/" "$new_project_dir"

# Step 2: Replace placeholders in directory and file names
echo "Replacing placeholders in directory and file names..."
find "$new_project_dir" -depth -name "*{{project_name}}*" -exec bash -c '
  for file; do
    new_file=$(echo "$file" | sed "s/{{project_name}}/'"$project_name"'/g")
    mv "$file" "$new_file"
  done
' bash {} +

# Step 3: Replace placeholders inside files
echo "Replacing placeholders in files..."
find "$new_project_dir" -type f -exec sed -i '' \
	-e "s/{{project_name}}/${project_name}/g" \
	-e "s/{{author_name}}/${author_name}/g" \
	-e "s/{{author_email}}/${author_email}/g" \
	-e "s/{{project_description}}/${project_description}/g" {} +

# Step 4: Test if pytest passes (optional)
echo "Testing Python Environment Integrity"
cd "$new_project_dir"
python3 -m venv .venv
source .venv/bin/activate
pip3 install -r requirements.txt
pip3 install -e .
pytest tests/
if [[ $? -eq 0 ]]; then
	echo "All tests passed! The project is set up correctly."
else
	echo "Some tests failed. Ensure your python is configured correctly (see pyproject.toml)."
	exit
fi

# Step 5: Option to initialize a Git repository
read -p "Do you want to initialize a Git repository for this project? (y/n): " git_choice
if [[ "$git_choice" == "y" || "$git_choice" == "Y" ]]; then
	echo "Initializing Git repository..."
	git init
	git add .
	git commit -m "Initial commit for $project_name"
	echo "Git repository initialized and first commit created."
else
	echo "Git initialization skipped."
fi

echo "Project setup complete."
