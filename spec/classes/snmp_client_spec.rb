# frozen_string_literal: true

require 'spec_helper'

describe 'snmp::client' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      let(:params) { {} }

      it { is_expected.to compile.with_all_deps }

      case facts[:os]['family']
      when 'RedHat'
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
      when 'Debian'
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
      when 'Suse'
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
      when 'FreeBSD'
        it {
          is_expected.not_to contain_package('snmp-client').with(
            ensure: 'present',
            name: 'net-snmp'
          )
        }

        it {
          is_expected.to contain_file('snmp.conf').with(
            path: '/usr/local/etc/snmp/snmp.conf'
          )
        }
      when 'Darwin'
        it {
          is_expected.not_to contain_package('snmp-client').with(
            ensure: 'present'
          )
        }

        it {
          is_expected.to contain_file('snmp.conf').with(
            path: '/private/etc/snmp/snmp.conf'
          )
        }
      end
    end

    context "on #{os} with ensure => 'absent'" do
      let(:facts) do
        facts
      end
      let(:params) { { ensure: 'absent' } }

      it { is_expected.to contain_file('snmp.conf').with_ensure('absent') }

      case facts[:os]['family']
      when 'Suse', 'FreeBSD', 'Darwin'
        it { is_expected.not_to contain_package('snmp-client') }
      else
        it { is_expected.to contain_package('snmp-client').with_ensure('absent') }
      end
    end

    context "on #{os} with autoupgrade => true" do
      let(:facts) do
        facts
      end
      let(:params) { { autoupgrade: true } }

      it { is_expected.to contain_file('snmp.conf').with_ensure('present') }

      case facts[:os]['family']
      when 'Suse', 'FreeBSD', 'Darwin'
        it { is_expected.not_to contain_package('snmp-client') }
      else
        it { is_expected.to contain_package('snmp-client').with_ensure('latest') }
      end
    end

    context "on #{os} with snmp_config" do
      let(:facts) do
        facts
      end
      let(:params) { { snmp_config: ['defVersion 2c', 'defCommunity public'] } }

      it do
        is_expected.to contain_file('snmp.conf').
          with_content(%r{defVersion 2c}).
          with_content(%r{defCommunity public})
      end
    end
  end
end
