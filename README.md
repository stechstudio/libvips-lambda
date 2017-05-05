# libvips : Executable for AWS Lambda

[libvips](https://github.com/jcupitt/libvips) is a 2D image processing library. Compared to similar libraries, [libvips runs quickly and uses little memory](https://github.com/jcupitt/libvips/wiki/Speed-and-memory-use).
libvips is licensed under the LGPL 2.1+.

We use libvips for image manipulation, primarily tiling image pyramids for blueprints and other construction industry artifacts, which results in about seven thousand vips executions a day for the past several years. We have long wanted to move that processing to AWS Lambda, and were hung up on getting a vips executable into AWS.

In the fall of 2016, I had a good chat with [@jcupitt](https://github.com/jcupitt) and [@lovell](https://github.com/lovell) about the issue in [jcupitt/libvips#492](https://github.com/jcupitt/libvips/issues/492) and @lovell pointed out that they were building vips libraries for the Node.js module [Sharp](https://github.com/lovell/sharp). Sharp builds the shared libraries that have a single runtime dependency of `glibc v2.13+` and the latest Amazon Linux is further along than that.

If we were looking for a Node.js solution in AWS Lambda, we could have simply used the sharp module. If you are using Node.js, you should probably stop here and just go use Sharp. However, we required an executable that we could call directly. So I adapted the [sharp vips build tools](https://github.com/lovell/sharp/tree/master/packaging) to allow us to get what we are after, an executable.

It really didn't take much once I dug around the Sharp Repository a bit and found how they are building for the latest vips. We are ultimately just adding the `/bin` directory to the resulting archive.

Over time, I expect we will diverge from the Sharp code base significantly, but if nothing else, this is a handy place for us to quickly get the binary we desire for AWS Lambda.

# Using libvips for AWS Lambda

We keep some pre-baked tarballs on the release page:

https://github.com/stechstudio/libvips-lambda/releases

You can simply untar that and skip the entire build process if you like.

# Building libvips for AWS Lambda

The process depends on [Docker](https://docs.docker.com/engine/installation/) being installed.

Clone this repository and run:

    $ ./build.sh

When all is said and done you should have something like `libvips-8.5.4-linux-x64.tar.gz` in your working directory.

# Using libvips in an AWS Lambda Package

Creating a [Lambda Deployment Package](http://docs.aws.amazon.com/lambda/latest/dg/lambda-python-how-to-create-deployment-package.html) is beyond the scope of this read me. However, you need to be familiar with the process.

Go about creating your Deployment Package as normal, and extract the libvips tarfile into your base directory. This will result in three new directories if they didn't previously exist:

      ./bin
      ./lib
      ./include

You will find vips at `./bin/vips` along with all the other executables we created. Adding this to your Deployment Package will add about 7.5M to the package size.

In your code you can reference `/var/task/bin/vips` and you will need to ensure you customize the Lambda Function Environment Variable `LD_LIBRARY_PATH=/var/task/lib` from there you should be good to go!
