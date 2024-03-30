FROM ubuntu:latest

# Install necessary packages for building Neovim
RUN apt-get update && apt-get install -y \
    git \
    ninja-build \
    gettext \
    libtool \
    libtool-bin \
    autoconf \
    automake \
    cmake \
    g++ \
    pkg-config \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set up environment variables
ENV NVIM_DIR=/neovim
ENV NVIM_BUILD_DIR=$NVIM_DIR/build
ENV NVIM_INSTALL_DIR=$NVIM_DIR/install

# Clone Neovim repository
RUN git clone https://github.com/neovim/neovim.git $NVIM_DIR

# Build Neovim
RUN cd $NVIM_DIR \
    && make CMAKE_BUILD_TYPE=RelWithDebInfo \
    CMAKE_INSTALL_PREFIX=$NVIM_INSTALL_DIR \
    CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$NVIM_INSTALL_DIR" \
    && make install

ENV PATH=$NVIM_INSTALL_DIR/bin:$PATH


RUN git clone https://github.com/itsvinayak/TurboNvimConfig.nvim.git /root/.config/nvim

CMD ["nvim"]


