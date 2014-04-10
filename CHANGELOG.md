## flakrat-repo_centos changelog

Release notes for the flakrat-repo_centos module.

------------------------------------------

#### 2.0.1 - 2014/04/10

Bug fix for beaker acceptance tests.

------------------------------------------

#### 2.0.0 - 2014/04/01

This major release

Detailed Changes:

* Use the Anchor pattern to order the classes so existing repo files are removed before new repos added.
* Use Package resource collector to ensure this module runs before any managed Package resources
* Add dependency treydock-gpg_key to manage GPG keys replacing the repo_centos::rpm_gpg_key defined type
* Remove CentOS-Vault.repo and CentOS-SCL.repo files
* Add newline to GPG keys so they aren't unnecessarily replaced
* Remove os_maj_version fact in favor of using external facts in the following order:
  * facter's operatingsystemmajrelease
  * another module's os_maj_version
  * inline template parsing facter's operatingsystemrelease fact
* Cleanup code to pass puppet-lint tests (proper variable scopes, spacing ,etc)
* Add rspec-puppet unit testing
* Add beaker-rspec system tests
  * NOTE: The `should_not` matchers do not work despite the module correctly disabling yumrepo resources and removing repo files.

------------------------------------------

#### New in 0.1.0 - 2013/02/06

Initial release.

This module is based on the following puppetlabs module: http://github.com/stahnma/puppet-module-puppetlabs_yum
