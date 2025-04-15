# Pre-Install Toolbox

A lightweight Docker container for executing shell scripts from both local files and remote URLs.

## Overview

The Pre-Install Toolbox is a minimal Alpine-based Docker container that provides a convenient way to run shell scripts, either locally mounted or fetched from remote URLs. It includes essential tools like `curl` and `wget` for fetching remote scripts.

## Usage

### Running a remote script

```bash
docker run nasselle/pre-install-toolbox:1.0.0 https://example.com/script.sh
```

### Running a local script

Mount your script as `/script.sh` in the container:

```bash
docker run -v $(pwd)/my-script.sh:/script.sh nasselle/pre-install-toolbox:1.0.0
```

### Passing arguments to the script

You can pass additional arguments to the script:

```bash
docker run nasselle/pre-install-toolbox:1.0.0 https://example.com/script.sh arg1 arg2
```

## How It Works

1. If no parameters are provided, the container looks for a `/script.sh` file to execute
2. If a URL is provided as the first parameter, it downloads and executes the script from that URL
3. Any additional parameters are passed to the script

## Building the Image

```bash
docker build -t nasselle/pre-install-toolbox:1.0.0 .
```

## Project Structure

- `Dockerfile` - Container definition
- `entrypoint.sh` - Container entry point script
- `dockflow.json` - Image metadata

## Security Considerations

**Warning**: Running scripts directly from URLs can be a security risk. Always verify the source and content of scripts before execution.

## License

MIT