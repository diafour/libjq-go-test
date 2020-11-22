# Static build

You can build static binaries with libjq-go. For example, you can use image `golang:1.15-alpine` to build static binary and then COPY this binary to alpine or ubuntu or debian images. It will works even in older versions and in a scratch image.

This example is an illustration of this setup.

## run it!

You need docker for this example.

Just execute `./run.sh` and it will build static binary, create alpine and debian images and tests them.

To clean up, just run `./run.sh --clean`