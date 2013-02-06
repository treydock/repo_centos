# Configure repositories for CentOS to point to custom repo

# About
This module allows you to configure the CentOS repo definitions to point to your
own mirror. GPG keys are imported.

The following Repos will be setup and enabled by default:

  * centos-base
  * centos-updates

Other repositories that will setup but disabled

  * centos-cr
  * centos-plus
  * centos-extras

## New in 0.1.0

Initial release. This module is based on the following puppetlabs module:
http://github.com/stahnma/puppet-module-puppetlabs_yum

# Testing

  * This was tested on CentOS 5 and 6 clients
  * Tested using Puppet 3.0.2

# License
Apache Software License 2.0
