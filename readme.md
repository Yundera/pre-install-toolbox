# Pre-Install Toolbox

A lightweight Docker container for executing shell scripts from local files, remote URLs, or multiline strings.

## Overview

The Pre-Install Toolbox is a minimal Alpine-based Docker container that provides a convenient way to run shell scripts from multiple sources:
- Local files mounted into the container
- Remote URLs (downloaded and executed)
- Multiline script strings passed as arguments

It includes essential tools like `curl` and `wget` for fetching remote scripts.

## Usage

### Running a remote script

```bash
docker run nasselle/pre-install-toolbox:1.0.0 https://example.com/script.sh
```

### Running a multiline script string

```bash
docker run nasselle/pre-install-toolbox:1.0.0 "
#!/bin/sh
echo 'Hello from multiline script!'
ls -la /
echo 'Script completed'
"
```

Or with a more complex example:

```bash
docker run nasselle/pre-install-toolbox:1.0.0 "
set -e
echo 'Starting installation...'
apk update
apk add --no-cache git vim
echo 'Installation completed successfully!'
"
```

### Running a local script

Mount your script as `/script.sh` in the container:

```bash
docker run -v $(pwd)/my-script.sh:/script.sh nasselle/pre-install-toolbox:1.0.0
```

### Passing arguments to the script

You can pass additional arguments to any script (URL or multiline string):

```bash
# With URL
docker run nasselle/pre-install-toolbox:1.0.0 https://example.com/script.sh arg1 arg2

# With multiline string
docker run nasselle/pre-install-toolbox:1.0.0 "
echo 'First argument:' \$1
echo 'Second argument:' \$2
" arg1 arg2
```

## How It Works

1. If no parameters are provided, the container looks for a `/script.sh` file to execute
2. If the first parameter starts with `http://` or `https://`, it downloads and executes the script from that URL
3. If the first parameter doesn't start with a URL scheme, it treats it as a multiline script string and executes it directly
4. Any additional parameters are passed to the script as arguments

## Building the Image

```bash
docker build -t nasselle/pre-install-toolbox:1.0.0 .
```

## Project Structure

- `Dockerfile` - Container definition
- `entrypoint.sh` - Container entry point script
- `dockflow.json` - Image metadata

## Security Considerations

**Warning**:
- Running scripts directly from URLs can be a security risk. Always verify the source and content of scripts before execution.
- When using multiline strings, be careful with shell escaping and avoid executing untrusted input.
- Consider the security implications of any scripts you run, especially those that modify system state.

## Examples

### Simple system information script
```bash
docker run nasselle/pre-install-toolbox:1.0.0 "
echo '=== System Information ==='
uname -a
echo '=== Disk Usage ==='
df -h
echo '=== Memory Usage ==='
free -h
"
```

### Package installation script
```bash
docker run nasselle/pre-install-toolbox:1.0.0 "
#!/bin/sh
set -e
echo 'Installing development tools...'
apk update
apk add --no-cache git curl vim bash
echo 'Development tools installed successfully!'
git --version
"
```

## License

MIT