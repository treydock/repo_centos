require 'spec_helper'

describe 'repo_centos' do
  shared_examples 'centos-6' do
    it { should have_class_count(9) }
    it { should have_file_resource_count(5) }
    it { should have_gpg_key_resource_count(1) }

    it { should create_class('repo_centos') }
    it { should contain_class('repo_centos::params') }

    it { should contain_anchor('repo_centos::start').that_comes_before('Class[repo_centos::base]') }
    it { should contain_anchor('repo_centos::end') }

    it { should contain_class('repo_centos::base').that_comes_before('Class[repo_centos::contrib]') }
    it { should contain_class('repo_centos::contrib').that_comes_before('Class[repo_centos::cr]') }
    it { should contain_class('repo_centos::cr').that_comes_before('Class[repo_centos::extras]') }
    it { should contain_class('repo_centos::extras').that_comes_before('Class[repo_centos::plus]') }
    it { should contain_class('repo_centos::plus').that_comes_before('Class[repo_centos::scl]') }
    it { should contain_class('repo_centos::scl').that_comes_before('Class[repo_centos::updates]') }
    it { should contain_class('repo_centos::updates').that_comes_before('Anchor[repo_centos::end]') }

    it { should contain_file('/etc/yum.repos.d/centos6.repo').
      with_ensure('absent').
      with_before('Anchor[repo_centos::start]')
    }
    it { should contain_file('/etc/yum.repos.d/CentOS-Base.repo').
      with_ensure('absent').
      with_before('Anchor[repo_centos::start]')
    }
    it { should contain_file('/etc/yum.repos.d/CentOS-Debuginfo.repo').
      with_ensure('absent').
      with_before('Anchor[repo_centos::start]')
    }
    it { should contain_file('/etc/yum.repos.d/CentOS-Media.repo').
      with_ensure('absent').
      with_before('Anchor[repo_centos::start]')
    }

    it { should contain_gpg_key('RPM-GPG-KEY-CentOS-6').
      with_path('/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6').
      with_before('Anchor[repo_centos::start]')
    }

    it do
      should contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6').with({
        :ensure => 'present',
        :owner  => '0',
        :group  => '0',
        :mode   => '0644',
        :source => 'puppet:///modules/repo_centos/RPM-GPG-KEY-CentOS-6',
      })
    end
  end

  context 'when operatingsystemmajrelease => undef, os_maj_version => undef, and operatingsystemrelease => 6.5' do
    let :facts do
      {
        :operatingsystem            => 'CentOS',
        :operatingsystemrelease     => '6.5',
        :architecture               => 'x86_64',
      }
    end

    it_behaves_like 'centos-6'
  end

  context 'when operatingsystemmajrelease => 6, os_maj_version => undef, and operatingsystemrelease => 6.5' do
    let :facts do
      {
        :operatingsystem            => 'CentOS',
        :operatingsystemmajrelease  => '6',
        :architecture               => 'x86_64',
      }
    end

    it_behaves_like 'centos-6'
  end

  context 'when operatingsystemmajrelease => undef, os_maj_version => 6, and operatingsystemrelease => 6.5' do
    let :facts do
      {
        :operatingsystem            => 'CentOS',
        :os_maj_version             => '6',
        :architecture               => 'x86_64',
      }
    end

    it_behaves_like 'centos-6'
  end

  context 'when os_maj_version => 5' do
    let :facts do
      {
        :operatingsystem        => 'CentOS',
        :os_maj_version         => '5',
        :architecture           => 'x86_64',
      }
    end

    it { should contain_file('/etc/yum.repos.d/centos5.repo') }
    it { should contain_gpg_key('RPM-GPG-KEY-CentOS-5').with_path('/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5') }
    it { should contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5').with_source('puppet:///modules/repo_centos/RPM-GPG-KEY-CentOS-5') }
  end

  context 'when operatingsystem => "Fedora"' do
    let :facts do
      {
        :operatingsystem        => 'Fedora',
        :os_maj_version         => '20',
        :architecture           => 'x86_64',
      }
    end

    it { should have_class_count(2) }
    it { should have_file_resource_count(0) }
    it { should have_gpg_key_resource_count(0) }

    it { should_not contain_class('repo_centos::base') }
    it { should_not contain_class('repo_centos::contrib') }
    it { should_not contain_class('repo_centos::cr') }
    it { should_not contain_class('repo_centos::extras') }
    it { should_not contain_class('repo_centos::plus') }
    it { should_not contain_class('repo_centos::scl') }
    it { should_not contain_class('repo_centos::updates') }
  end
end
