FROM golang:latest as devcontainer

# Set the maintainer label
LABEL maintainer="lzipp"

# Set the working directory inside the container
WORKDIR /workspace

# Copy the source code, go.mod, and go.sum files into the container
COPY ./go.mod ./go.sum ./

# Install & configure zsh and Oh My Zsh
RUN apt -y install zsh \
    && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    # Set ZSH_THEME
    && sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc \
    # Add plugins
    && sed -i 's/plugins=(git)/plugins=(git docker)/' ~/.zshrc
COPY config/.zshrc /root/.zshrc

# Install development tools
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        make \
        openssh-client \
        curl \
        python3 \
        python3-pip \
        && rm -rf /var/lib/apt/lists/*

# Download the Go modules
RUN go mod download 
# RUN go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest 
# RUN go install go.uber.org/mock/mockgen@latest 
RUN go install github.com/ethereum/go-ethereum/cmd/abigen@latest 
# RUN go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest 
# RUN go install -v github.com/go-delve/delve/cmd/dlv@latest

# Install Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_current.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Install nodejs tools
RUN npm install -g @web3-storage/w3cli

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && . $HOME/.cargo/env \
    && rustup --version \
    && cargo --version \
    && rustc --version

# Install rust tool
RUN cargo install --force cargo-stylus cargo-stylus-check \
    && rustup target add wasm32-unknown-unknown

ENTRYPOINT ["/bin/zsh"]
