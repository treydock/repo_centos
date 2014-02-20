# Configure repositories for CentOS to point to custom repo

# About
This module manages the CentOS repositories on CentOS clients.

By default, the module configures the repo files to use
http://mirror.centos.org/centos as the package source. This
can be modified by using the class parameter repourl as follows
(also demonstrates how to enable the SCL repo):

class {'repo_centos':
  repourl       => 'http://myrepo/centos',
  enable_scl    => true,
}

Alternate usage via hiera YAML:

repo_centos::repourl: 'http://myrepo/centos'
repo_centos::enable_scl: true

GPG keys are imported.

The following Repos will be setup and enabled by default:

  * centos-base
  * centos-extras
  * centos-updates

Other repositories that will setup but disabled

  * centos-contrib
  * centos-cr
  * centos-plus
  * scl

## New in 0.1.0

Initial release. This module is based on the following puppetlabs module:
http://github.com/stahnma/puppet-module-puppetlabs_yum

# Testing

  * This was tested on CentOS 5 and 6 clients
  * Tested using Puppet 3.4.2

# License
Apache Software License 2.0
