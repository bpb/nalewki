# Nalewki

## Overview

`pour_nalewka.sh` is a Bash script that accepts a programming language as an argument and selectively executes a corresponding sub-script that creates a boilerplate template for a project in the language chosen. The term **"nalewka"** is a playful nod to the Polish word for homemade liqueur, suggesting "pouring" a specific script.

## Features

- **Supported languages**: `python`, `go`, `rust`, `scala`, `java`
- **Optional verbosity**: `-v` flag enables verbose output for this script

## Usage

```bash
./pour_nalewka.sh [-v] <language>
```

- `-v`: Optional flag that enables verbose output.  
- `<language>`: Must be one of `python`, `go`, `rust`, `scala`, or `java`.

## Examples

1. **Basic Usage (Python)**  

   ```bash
   ./pour_nalewka.sh python
   ```

   Executes `python_script.sh`.

2. **Verbose Mode (Python)**  

   ```bash
   ./pour_nalewka.sh -v python
   ```

   In case there is issue scripts are run with `set -x` helpful for debugging or tracing the workflow.
