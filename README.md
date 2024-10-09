![NeoMinimalVim](https://github.com/itsvinayak/TurboNvimConfig.nvim/assets/33996594/12083d5e-8b35-4ce5-b563-962d0717cbba)

<div align="center">
<p>
     <a href="https://github.com/itsvinayak/TurboNvimConfig.nvim/blob/main/LICENSE">
      <img alt="License" src="https://img.shields.io/github/license/itsvinayak/TurboNvimConfig.nvim?style=for-the-badge&logo=starship&color=ee999f&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/itsvinayak/TurboNvimConfig.nvim/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/itsvinayak/TurboNvimConfig.nvim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/itsvinayak/TurboNvimConfig.nvim/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/itsvinayak/TurboNvimConfig.nvim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
    <a href="https://github.com/itsvinayak/TurboNvimConfig.nvim">
      <img alt="Repo Size" src="https://img.shields.io/github/repo-size/itsvinayak/TurboNvimConfig.nvim?color=%23DDB6F2&label=SIZE&logo=codesandbox&style=for-the-badge&logoColor=D9E0EE&labelColor=302D41" />
    </a>
</p>
</div>

---

# Index

  1. [Introduction](#introduction)
  2. [Installation](#installation)
  3. [Neovim Installation and Configuration via Docker](#neovim-installation-and-configuration-via-docker)
  4. [Recommended GUI Client](#recommended-gui-client)

## Introduction

TurboNvimConfig is a minimalist starting point for configuring Neovim, designed to offer an IDE-like experience. Unlike full-fledged Neovim distributions, TurboNvimConfig is not a Neovim distribution in itself but rather a foundation upon which you can build your personalized Neovim setup tailored to your specific workflow and preferences. Use it as a launching pad to craft your ideal Neovim environment.

[![Lua Format](https://github.com/itsvinayak/TurboNvimConfig.nvim/actions/workflows/stylua.yml/badge.svg?branch=main)](https://github.com/itsvinayak/TurboNvimConfig.nvim/actions/workflows/stylua.yml)
[![Docker Image CI](https://github.com/itsvinayak/TurboNvimConfig.nvim/actions/workflows/docker-image.yml/badge.svg)](https://github.com/itsvinayak/TurboNvimConfig.nvim/actions/workflows/docker-image.yml)

![Screenshot from 2024-03-14 23-36-51](https://github.com/itsvinayak/TurboNvimConfig.nvim/assets/33996594/a068dea3-58d6-4c23-8cf2-3b19f959964f)

## Installation

To install TurboNvimConfig and set it up as your Neovim configuration, follow these steps:

- Backup Your Existing Configuration (optional but recommended):
  If you have an existing Neovim configuration that you want to preserve, make sure to back it up. You can follow the backup instructions provided earlier.

  ```bash
     cp -r ~/.config/nvim ~/nvim_backup
  ```

- Clone TurboNvimConfig Repository:
  Clone the TurboNvimConfig repository to your local machine. You can do this using Git by running the following command in your terminal:

  ```bash
     git clone https://github.com/itsvinayak/TurboNvimConfig.nvim.git ~/.config/nvim
  ```

- Launch Neovim:
  Open Neovim by running nvim in your terminal.
- Install Plugins:
  Upon first launch, Neovim will automatically install plugins specified in the configuration file. This might take a few moments depending on your internet connection.
- Additional Configuration:
  Optionally, you can further customize TurboNvimConfig to suit your preferences by editing the init.vim file located at ~/.config/nvim/init.vim.
- Restart Neovim:
  After making any customizations or adjustments to the configuration, restart Neovim to apply the changes.

That's it! You now have TurboNvimConfig installed and configured as your Neovim setup. Enjoy your streamlined and minimalist Neovim environment!

## Neovim Installation and Configuration via Docker

TurboNvimConfig can also be built and run within a Docker container. Below are the steps to build and run TurboNvimConfig using Docker:

- Clone TurboNvimConfig Repository:

Clone the TurboNvimConfig repository to your local machine. You can do this using Git by running the following command in your terminal:

```bash
  git clone https://github.com/itsvinayak/TurboNvimConfig.nvim.git
```

- Build Docker Image:
  To build the Docker image, navigate to the directory containing the Dockerfile. In this case, it's the Docker folder within the TurboNvimConfig repository.
  
  This folder contains two essential files:
  - Dockerfile: This file specifies the steps to build the Docker image with Neovim and TurboNvimConfig installed.
  - run-docker.sh: This script simplifies the process of building and running the Docker container. It automates the commands mentioned above.

- Run run-docker.sh

Simply execute the following command in your terminal:

```bash
  ./run-docker.sh
```

## Recommended GUI Client

For users preferring a graphical interface for managing Neovim, the following list of recommended GUI clients is provided:

- [neovide](https://neovide.dev/)
- [nvim-ui](https://github.com/sakhnik/nvim-ui)
- [Neovim Qt](https://github.com/equalsraf/neovim-qt)
