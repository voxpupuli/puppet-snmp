require 'spec_helper'

describe 'snmp::client', type: 'class' do
  context 'on a non-supported osfamily' do
    let(:params) { {} }
    let :facts do
      {
        osfamily: 'foo',
        operatingsystem: 'bar'
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
            osfamily: 'RedHat',
            operatingsystem: os,
            operatingsystemrelease: '6.4',
            lsbmajdistrelease: '6',
            operatingsystemmajrelease: '6'
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
            path: '/etc/snmp/snmp.conf',
            require: ['Package[snmp-client]', 'File[/etc/snmp]']
          )
        }
      end
    end

    debianish.each do |os|
      describe "for osfamily Debian, operatingsystem #{os}" do
        let(:params) { {} }
        let :facts do
          {
            osfamily: 'Debian',
            operatingsystem: os,
            operatingsystemrelease: '6.0.7',
            lsbmajdistrelease: '6',
            operatingsystemmajrelease: '6'
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
            path: '/etc/snmp/snmp.conf',
            require: 'Package[snmp-client]'
          )
        }
      end
    end

    suseish.each do |os|
      describe "for osfamily Suse, operatingsystem #{os}" do
        let(:params) { {} }
        let :facts do
          {
            osfamily: 'Suse',
            operatingsystem: os,
            operatingsystemrelease: '11.1',
            lsbmajdistrelease: '11',
            operatingsystemmajrelease: '11'
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
            osfamily: 'FreeBSD',
            operatingsystem: os,
            operatingsystemrelease: '9.2',
            operatingsystemmajrelease: '9'
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
            path: '/usr/local/etc/snmp/snmp.conf',
            require: nil
          )
        }
      end
    end

    openbsdish.each do |os|
      describe "for osfamily OpenBSD, operatingsystem #{os}" do
        let(:params) { {} }
        let :facts do
          {
            osfamily: 'OpenBSD',
            operatingsystem: os,
            operatingsystemrelease: '5.9',
            operatingsystemmajrelease: '5'
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
        osfamily: 'RedHat',
        operatingsystem: 'RedHat',
        operatingsystemrelease: '6.4',
        lsbmajdistrelease: '6',
        operatingsystemmajrelease: '6'
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
