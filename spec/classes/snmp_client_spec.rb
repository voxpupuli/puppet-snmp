require 'spec_helper'

describe 'snmp::client', type: 'class' do
  context 'on a non-supported osfamily' do
    let(:params) { {} }
    let :facts do
      {
        os: { 'release' => { 'full' => '42', 'major' => '42' }, 'name' => 'bar', 'family' => 'foo' }
      }
    end

    it 'fails' do
      expect do
        is_expected.to raise_error(Puppet::Error, %r{Module snmp is not supported on bar})
      end
    end
  end

  redhatish = ['RedHat']
  # redhatish = ['RedHat', 'Fedora']
  debianish = ['Debian']
  # debianish = ['Debian', 'Ubuntu']
  suseish = ['Suse']
  freebsdish = ['FreeBSD']
  openbsdish = ['OpenBSD']

  context 'on a supported osfamily, default parameters' do
    redhatish.each do |os|
      describe "for osfamily RedHat, operatingsystem #{os}" do
        let(:params) { {} }
        let :facts do
          {
            os: { 'release' => { 'full' => '6.4', 'major' => '6' }, 'name' => 'CentOS', 'family' => 'RedHat' }
          }
        end

        it {
          is_expected.to contain_package('snmp-client').with(
            ensure: 'present',
            name: 'net-snmp-utils'
          )
        }
        it {
          is_expected.to contain_file('snmp.conf').with(
            ensure: 'present',
            mode: '0644',
            owner: 'root',
            group: 'root',
            path: '/etc/snmp/snmp.conf'
          ).that_requires(['Package[snmp-client]', 'File[/etc/snmp]'])
        }
      end
    end

    debianish.each do |os|
      describe "for osfamily Debian, operatingsystem #{os}" do
        let(:params) { {} }
        let :facts do
          {
            os: { 'release' => { 'full' => '6.0.7', 'major' => '6' }, 'name' => 'Debian', 'family' => 'Debian' }
          }
        end

        it {
          is_expected.to contain_package('snmp-client').with(
            ensure: 'present',
            name: 'snmp'
          )
        }
        it {
          is_expected.to contain_file('snmp.conf').with(
            ensure: 'present',
            mode: '0644',
            owner: 'root',
            group: 'root',
            path: '/etc/snmp/snmp.conf'
          ).that_requires('Package[snmp-client]')
        }
      end
    end

    suseish.each do |os|
      describe "for osfamily Suse, operatingsystem #{os}" do
        let(:params) { {} }
        let :facts do
          {
            os: { 'release' => { 'full' => '11.1', 'major' => '11' }, 'name' => 'SLES', 'family' => 'Suse' }
          }
        end

        it { is_expected.not_to contain_package('snmp-client') }
        it {
          is_expected.to contain_file('snmp.conf').with(
            ensure: 'present',
            mode: '0644',
            owner: 'root',
            group: 'root',
            path: '/etc/snmp/snmp.conf',
            require: nil
          )
        }
      end
    end

    freebsdish.each do |os|
      describe "for osfamily FreeBSD, operatingsystem #{os}" do
        let(:params) { {} }
        let :facts do
          {
            os: { 'release' => { 'full' => '9.2', 'major' => '9' }, 'name' => 'FreeBSD', 'family' => 'FreeBSD' }
          }
        end

        it {
          is_expected.to contain_package('snmp-client').with(
            ensure: 'present',
            name: 'net-mgmt/net-snmp'
          )
        }
        it {
          is_expected.not_to contain_file('snmp.conf').with(
            ensure: 'present',
            mode: '0755',
            owner: 'root',
            group: 'wheel',
            path: '/usr/local/etc/snmp/snmp.conf'
          )
        }
      end
    end

    openbsdish.each do |os|
      describe "for osfamily OpenBSD, operatingsystem #{os}" do
        let(:params) { {} }
        let :facts do
          {
            os: { 'release' => { 'full' => '5.9', 'major' => '5' }, 'name' => 'OpenBSD', 'family' => 'OpenBSD' }
          }
        end

        it {
          is_expected.to contain_package('snmp-client').with(
            ensure: 'present',
            name: 'net-snmp'
          )
        }
        it {
          is_expected.not_to contain_file('snmp.conf').with(
            ensure: 'present',
            mode: '0755',
            owner: 'root',
            group: 'wheel',
            path: '/etc/snmp/snmp.conf',
            require: nil
          )
        }
      end
    end
  end

  context 'on a supported osfamily, custom parameters' do
    let :facts do
      {
        os: { 'release' => { 'full' => '6.4', 'major' => '6' }, 'name' => 'CentOS', 'family' => 'RedHat' }
      }
    end

    describe 'ensure => absent' do
      let(:params) { { ensure: 'absent' } }

      it { is_expected.to contain_package('snmp-client').with_ensure('absent') }
      it { is_expected.to contain_file('snmp.conf').with_ensure('absent') }
    end

    describe 'ensure => badvalue' do
      let(:params) { { ensure: 'badvalue' } }

      it 'fails' do
        expect do
          is_expected.to raise_error(Puppet::Error, %r{ensure parameter must be present or absent})
        end
      end
    end

    describe 'autoupgrade => true' do
      let(:params) { { autoupgrade: true } }

      it { is_expected.to contain_package('snmp-client').with_ensure('latest') }
      it { is_expected.to contain_file('snmp.conf').with_ensure('present') }
    end

    describe 'autoupgrade => badvalue' do
      let(:params) { { autoupgrade: 'badvalue' } }

      it 'fails' do
        expect do
          is_expected.to raise_error(Puppet::Error, %r{"badvalue" is not a boolean.})
        end
      end
    end

    describe 'snmp_config => [ "defVersion 2c", "defCommunity public" ]' do
      let(:params) { { snmp_config: ['defVersion 2c', 'defCommunity public'] } }

      it { is_expected.to contain_file('snmp.conf') }
      it 'contains File[snmp.conf] with contents "defVersion 2c" and "defCommunity public"' do
        verify_contents(catalogue, 'snmp.conf', [
                          'defVersion 2c',
                          'defCommunity public'
                        ])
      end
    end
  end
end
