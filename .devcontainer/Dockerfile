FROM golang:latest as devcontainer

# Set the maintainer label
LABEL maintainer="lzipp"

# Set the working directory inside the container
WORKDIR /workspace

# Copy the source code, go.mod, and go.sum files into the container
COPY ./go.mod ./go.sum ./

# Install development tools
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        make \
        openssh-client \
        curl \
        python3 \
        python3-pip \
        zsh \
    && rm -rf /var/lib/apt/lists/*

# Configure oh my zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc \
    && sed -i 's/plugins=(git)/plugins=(git docker)/' ~/.zshrc
COPY .zshrc /root/.zshrc

# Install Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_current.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
# Install nodejs tools
    && npm install -g @web3-storage/w3cli

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && . $HOME/.cargo/env \
    && rustup --version \
    && cargo --version \
    && rustc --version \
# Install rust tool
    && cargo install --force cargo-stylus cargo-stylus-check \
    && rustup target add wasm32-unknown-unknown

# Download the Go modules
RUN go mod download \
    && go install github.com/ethereum/go-ethereum/cmd/abigen@latest 

# Command to run the application
CMD ["/bin/sh"]
