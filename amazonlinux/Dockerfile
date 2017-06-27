FROM stechstudio/aws-lambda-build:d0.0.4
LABEL authors="Bubba Hines <bubba@stechstudio.com>"

# Create container suitable for building Lambda binaries
COPY bash/.bashrc /root/.bashrc
COPY bash/.bashrc_help /root/.bashrc_help

# Install devel where we can
RUN mkdir -p /deps
RUN mkdir -p /target
RUN mkdir -p /target/modules

# Compiler settings
ENV FLAGS="-O3"