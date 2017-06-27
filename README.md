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

    $ ./build-vips.sh 8.5.6

When all is said and done you should have something like `dist/libvips-8.5.6-linux-x64.tar.gz` in your working directory.


# Building libvips with php-vips-ext for AWS Lambda

The process depends on [Docker](https://docs.docker.com/engine/installation/) being installed.

It is important to note that for running in Lambda we need to ensure that PHP is compiled against the exact same
libraries that we use for VIPS and the subsequent compilation of the PECL extension needs to build against those as well. 
Simply using PECL will not work because PECL gets easily confused with other system libraries that we are overriding.

Clone this repository and run:

    $ ./build-phpvips.sh 8.5.6 7.1.6 1.0.7

When all is said and done you should have something like `dist/vips-8.5.6_php-7.1.6_ext-php-1.0.7-lambda.tar.gz` in your working directory.

# Using libvips in an AWS Lambda Package

Creating a [Lambda Deployment Package](http://docs.aws.amazon.com/lambda/latest/dg/lambda-python-how-to-create-deployment-package.html) is beyond the scope of this read me. However, you need to be familiar with the process.

Go about creating your Deployment Package as normal, and extract the libvips tarfile into your base directory. This will 
result in new directories (assumes PHP build )if they didn't previously exist:

      ./bin         Our Binaries
      ./etc         Pear configuration
      ./include     Headers for everything we built
      ./lib         All the Shared Libraries
      ./modules     PHP Module Config Dir

You will find vips at `./bin/vips` along with all the other executables we created. If you were to add everything to your
lambda package it would be about 30M zipped and 86M on disk. However, you probably only want one or two of the executables
in which case you should cherry pick only the executables your lambda function needs. The entire `./bin` directory is about 
45MB on disk.

There is probably no reason to deploy the `./include` (15M on disk) to lambda at all. It is only packaged to allow additional
compilation if desired.

The `./lib` (27M on disk) directory is the big one. Just assume you need every file in the root directory for `vips` or `php` to work
properly at all. However, there are a number of subdirectories that you don't need at all, and you can effectively delete
all of them prior to lambda deployment to save a little space.

Note that there are a large number of symlinks in the `./lib` directory and it is important that those be maintained when 
creating your lambda package. Not all operating systems nor zipping programs properly handle the symlinks. You are warned.

In your code you can reference `/var/task/bin/vips` and you will need to ensure you customize the Lambda Function 
Environment Variables:
```bash
LD_LIBRARY_PATH=${LAMBDA_TASK_ROOT}/lib:LD_LIBRARY_PATH
PATH=${LAMBDA_TASK_ROOT}/bin:${LAMBDA_TASK_ROOT}:${PATH}
 ```

This will ensure our libraries and binaries get preference.
