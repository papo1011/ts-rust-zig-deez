# Latest Ubuntu image
FROM ubuntu:latest

# Make a working directory, as it would be binded with the current language one
WORKDIR /deez

COPY . .

# Basic system-level dependencies
RUN apt-get update && apt-get install -y make git curl wget && \
    wget https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.4-linux-x86_64.tar.gz && \
    tar -xvzf julia-1.9.4-linux-x86_64.tar.gz -C /opt/ && \
    ln -s /opt/julia-1.9.4/bin/julia /usr/local/bin/julia && \
    rm julia-1.9.4-linux-x86_64.tar.gz 

# Install Julia dependencies
RUN julia -e 'using Pkg; Pkg.activate("."); Pkg.instantiate();'