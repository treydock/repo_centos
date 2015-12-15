shared_examples_for 'repo_centos-default' do
  # Enabled by default
  [
    'base',
    'extras',
    'updates',
  ].each do |repo|
    describe yumrepo(repo) do
      it { should exist }
      it { should be_enabled }
    end
  end

  # Disabled by default
  [
    'centosplus',
    'fasttrack',
    'base-debuginfo',
  ].each do |repo|
    describe yumrepo(repo) do
      it { should exist }
      it { should_not be_enabled }
    end
  end

  # Not present by default
  [
    'scl',
    'centos-base-source',
    'centos-updates-source',
  ].each do |repo|
    describe yumrepo(repo) do
      it { should_not exist }
    end
  end

  # cr only on EL 7 by default
  describe yumrepo('cr') do
    if fact('operatingsystemmajrelease') >= '7'
      it { should exist }
      it { should_not be_enabled }
    else
      it { should_not exist }
    end
  end

  # centos-contrib only on EL 5 and 6
  describe yumrepo('contrib') do
    if fact('operatingsystemmajrelease') <= '6'
      it { should exist }
      it { should_not be_enabled }
    else
      it { should_not exist }
    end
  end
end