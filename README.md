# Bloodhound-docker
Bloodhound is an Active Directory reconnaissance tool. If you've ever struggled to compile
Bloodhound due to OS compatibility issues, this project is for you!
I've compiled the latest major releases (1.x, 2.x, 3.x, 4.x) so you don't have to,
and the best part is, you don't need to install anything on your computer.

## Prerequisites
This setup is primarily for Linux systems with X11. To enable X11 forwarding,
you'll need to add `root` to the xhost whitelist:

```bash
# Check current xhost settings (this is the default in Kali)
$ xhost
access control enabled, only authorized clients can connect
SI:localuser:kali

# Add root to xhost
$ xhost +si:localuser:root

# Verify the changes
$ xhost
access control enabled, only authorized clients can connect
SI:localuser:root
SI:localuser:kali
```

**Note**: Adding root to xhost has security implications. Use with caution and consider
reverting changes after use with `xhost -si:localuser:root`.

## File Sharing
The directory `/tmp/test` is shared with the Bloodhound container.
You can use this to exchange files between your host and the container.
For convenience, you can find the correct `SharpHound.exe` and `SharpHound.ps1`
for each version in this directory.

## Default Credentials
The default credentials for neo4j are `neo4j:bloodhound`. You can change these in the compose file,
but note that the autologin feature will be disabled unless you compile the container yourself.

## Running Bloodhound
I've prepared a compose yaml for each version, along with the corresponding Dockerfile.
To run a specific version (where `x` can be `1.5.2`, `2.2.1`, `3.0.5`):

```bash
docker compose -f docker-compose-x.yaml up -d
# To stop: docker compose -f docker-compose-x.yaml down
```

To run the latest released version (Bloodhound master/v4.3.1):

```bash
docker compose up -d
# To stop: docker compose down
```
> To run the tagged 4.3.1 version, swap the comment symbol between the `image` lines
> in `docker-compose.yaml`.

This is the compose to run the latest version

```bash
services:
  bloodhound:
    image: scmanjarrez/bloodhound:latest  # master
    # image: scmanjarrez/bloodhound:4.3.1  # use stable v4.3.1
    volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix
      - /tmp/shared:/tmp/shared  # directory to share files between host and container
    environment:
      DISPLAY: ":0.0"  # this should match your $DISPLAY value

  neo4j:
    image: neo4j:4.4.20
    ulimits:
      nofile:
        soft: 65536
        hard: 65536
    environment:
      NEO4J_AUTH: "neo4j/bloodhound"  # default login credentials to automate login, check Dockerfile
```

## Accessing Bloodhound
After starting the container, the Bloodhound electron app window should automatically
open as if it were running directly on your host.

## Troubleshooting
White Screen: Sometimes the Bloodhound electron app may display a completely white screen.
If this happens, try pressing `Ctrl+R` a few times to refresh the application.
This solution has been consistently effective.

## Contributing
Your contributions are welcome! If you have any suggestions or fixes, please don't
hesitate to open an issue on the GitHub repository. Your input helps improve this
project for everyone.
