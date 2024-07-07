FROM golang:latest

# Set the maintainer label
LABEL maintainer="lzipp"

# Set the working directory inside the container
WORKDIR /app

# Copy the source code, go.mod, and go.sum files into the container
COPY ./src ./src
COPY ./go.mod ./go.sum ./

# Install development tools
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        openssh-client \
        curl \
        python3 \
        python3-pip \
        && rm -rf /var/lib/apt/lists/*

# Download the Go modules
RUN go mod download \
    && go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest \
    && go install go.uber.org/mock/mockgen@latest \
    && go install github.com/ethereum/go-ethereum/cmd/abigen@latest \
    && go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest \
    && go install -v github.com/go-delve/delve/cmd/dlv@latest

# Install Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest

# Install nodejs tools
RUN npm install -g @web3-storage/w3cli

# Command to run the application
CMD ["go", "run", "main.go"]
