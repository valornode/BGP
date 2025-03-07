# BGP Install Script

## Overview

This script automates the installation of essential BGP-related tools on a Debian-based system. It installs:

- bgpq4 (Prefix list generator)

- BIRD (BGP daemon)

- Pathvector (Routing policy automation)

This script also enables IPv4 forwarding.

## Installation

Download and Run the Script:

```wget https://raw.githubusercontent.com/valornode/BGP/main/install-basics.sh -O install-basics.sh```

```chmod +x install-basics.sh```

```./install-basics.sh```

## Features

- Updates package lists and installs dependencies
- Builds and installs bgpq4 from source
- Installs BIRD and Pathvector
- Enables IPv4 forwarding for routing
- Verifies installations after completion

## Requirements

- Debian-based OS (Ubuntu, Debian, etc.)
- Root or sudo privileges

## Verification

After installation, verify the installed components:

- birdc show status
- pathvector --version
- bgpq4 -h
