FROM stechstudio/aws-lambda-build:1.2.2
LABEL authors="Bubba Hines <bubba@stechstudio.com>"

# Install devel where we can
RUN mkdir -p /deps
RUN mkdir -p /target
RUN mkdir -p /target/modules

# Compiler settings
ENV FLAGS="-O3"