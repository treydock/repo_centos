# repo_centos

Configure repositories for CentOS to point to custom repo

## Overview

This is a puppet module that manages the CentOS repositories
on CentOS clients.

Originally based off of http://github.com/stahnma/puppet-module-puppetlabs_yum'

## Usage

### Class: `repo_centos`

By default, the module configures the repo files to use
http://mirror.centos.org/centos as the package source. This
can be modified by using the class parameter `repourl` as follows
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
  * centos-scl

#### Parameters for `repo_centos` class

#####`repourl`

The base repo URL.  Defaults to 'http://mirror.centos.org/centos'

#####`enable_base`

Boolean to decide if the CentOS Base Repo should be enabled (defaults to true).

#####`enable_contrib`

Boolean to decide if the CentOS User Contrib Repo should be enabled (defaults to false).

#####`enable_cr`

Boolean to decide if the CentOS Continuous Release Repo should be enabled (defaults to false).

#####`enable_extras`

Boolean to decide if the CentOS Extras Repo should be enabled (defaults to true).

#####`enable_plus`

Boolean to decide if the CentOS Plus Repo should be enabled (defaults to false).

#####`enable_scl`

Boolean to decide if the CentOS SCL Repo should be enabled (defaults to false).

This only affects to CentOS 6 clients.

#####`enable_updates`

Boolean to decide if the CentOS Updates Repo should be enabled (defaults to true).

## Compatibility

  * This was tested on CentOS 5 and 6 clients
  * Tested using Puppet 3.4.2

## Development

### Testing

Make sure you have:

* rake
* bundler

Install the necessary gems:

    bundle install

Run the tests from root of the source code:

    bundle exec rake test

You can also run acceptance tests:

    bundle exec rake acceptance

## TODO

* Add CentOS-Media.repo contents
* Add CentOS-Debuginfo.repo contents
* Add CentOS-Vault.repo contents
* Make yum priorities configurable

## License

Apache Software License 2.0
