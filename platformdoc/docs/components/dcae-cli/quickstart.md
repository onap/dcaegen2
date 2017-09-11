# Quickstart

The `dcae-cli` is a Python command-line tool built to aide component developers with the development and testing of their micro-service component for the DCAE platform.  It will help developers do functional and integration testing of their components locally and on remote environments as simple as possible.

The tool requires the component developers to create a valid component specification for their component which is used by the tool.  This same component specification will be published in the [onboarding catalog](../../glossary#onboarding-catalog) at the end of development and testing.

The git repository can be found [here](ONAP LINK TBD)

## Pre-requisite

### For Docker

There are two options for development with Docker: developing locally on your machine which requires Docker to be installed and developing remotely by deploying onto remote infrastructure.

#### For local development

* You must install [Docker engine](https://docs.docker.com/engine/installation/) locally on your machine.
* You must know the *external ip* of where the Docker engine is running.  The external ip is needed so that service discovery will wire up correctly.
    - For OSX users, this means making sure the VirtualBox VM that is running your Docker engine has a bridged adapter and getting the ip of that adapter.

#### For remote development

You need access to a remote host with Docker engine installed with remote API access.  You must have the associated connection information: domain name or IP and port (should be either 2375 or 2376).  This information should be set in [an active profile](walkthrough.md#setting-profile).

### For CDAP

TBD

## Install

```
pip install --extra-index-url https://YOUR_NEXUS_PYPI_SERVER/simple dcae-cli
```

To do an upgrade, use the `--upgrade` flag.

### Configuration

When you run the tool for the first time, the tool will create a [configuration directory](http://click.pocoo.org/5/api/#click.get_app_dir) and generate a configuration file.

Configuration is first sourced from an remote server that the platform team manages.  This is overlaid with configuration details that you will be prompted to input particularly your AT&T UID.

#### `--reinit`

Configuration can be re-initialized or reset.  There is a `--reinit` flag that is to be used to re-initialize your configuration and your environment profiles.

To re-initialize:

```
$ dcae_cli --reinit
```

### Verify

Verify that its installed:

```
$ dcae_cli --help
Usage: dcae_cli [OPTIONS] COMMAND [ARGS]...

Options:
  -v, --verbose  Prints INFO-level logs to screen.
  --reinit       Re-initialize dcae-cli configuration
  --version      Show the version and exit.
  --help         Show this message and exit.

Commands:
  catalog
  component
  data_format
  profiles
```
## Version

You can verify the version of the dcae-cli with the following command:

```
$ dcae_cli --version
```
