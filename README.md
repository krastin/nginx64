# nginx64

This repository is based on the following repository:
- https://github.com/nielsabels/packer-xenial64
Based on the following repository:
- https://github.com/cbednarski/packer-ubuntu

# How to build

## Local virtualisation

    make
    
Using the supplied makefile should automatically detect your OS environment and build the image correctly.
If that doesn't work, you can specify which provider to use to build the image:

    make nginx64-vbox.box # when using virtualbox
    make nginx64-vmware.box # when using vmware

## Using AWS

You need to set up the AWS CLI utility for packer to be able to interact with AWS. [Check this article out.](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)

    make nginx64-aws.box # when using AWS


# How to test

    make kitchen
    
Just like with building, you can specify which provider to use with your tests:

    make kitchen-vbox
    make kitchen-vmware

# Purpose

This repository attempts to store the minimum amount of code that is required to create a:
- Ubuntu Xenial64 box
- with standard nginx
- using Packer
- for VirtualBox or VMware
