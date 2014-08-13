require 'spec_helper'

describe 'repo_centos::debug' do
  let :facts do
    {
      :operatingsystem            => 'CentOS',
      :operatingsystemrelease     => '6.5',
      :operatingsystemmajrelease  => '6',
      :architecture               => 'x86_64',
    }
  end

  it_behaves_like "centos6_debug"
end
