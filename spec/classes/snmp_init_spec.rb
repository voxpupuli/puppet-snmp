# frozen_string_literal: true

require 'spec_helper'

describe 'snmp' do
  NO_SNMPTRAPD = ['Darwin'].freeze
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end
      let(:params) { {} }

      # rubocop:disable RSpec/RepeatedExample
      it { is_expected.to compile.with_all_deps }
      it { is_expected.not_to contain_class('snmp::client') }

      describe 'snmpv2_enable => true' do
        let(:params) { { snmpv2_enable: true } }

        # TODO: add more contents for File[snmpd.conf]
        it 'contains File[snmpd.conf] with expected contents' do
          is_expected.to contain_file('snmpd.conf').
            with_content(%r{agentaddress udp:127.0.0.1:161,udp6:\[::1\]:161}).
            with_content(%r{rocommunity public 127.0.0.1}).
            with_content(%r{rocommunity6 public ::1}).
            with_content(%r{com2sec notConfigUser  default       public}).
            with_content(%r{com2sec6 notConfigUser  default       public}).
            with_content(%r{group   notConfigGroup v1            notConfigUser}).
            with_content(%r{group   notConfigGroup v2c           notConfigUser}).
            with_content(%r{view    systemview    included   .1.3.6.1.2.1.1}).
            with_content(%r{view    systemview    included   .1.3.6.1.2.1.25.1.1}).
            with_content(%r{access  notConfigGroup ""      any       noauth    exact  systemview none  none}).
            with_content(%r{sysLocation Unknown}).
            with_content(%r{sysContact Unknown}).
            with_content(%r{sysServices 72}).
            with_content(%r{dontLogTCPWrappersConnects no})
        end
      end

      unless NO_SNMPTRAPD.include?(facts[:os]['family'])
        # TODO: add more contents for File[snmptrapd.conf]
        it 'contains File[snmptrapd.conf] with correct contents' do
          is_expected.to contain_file('snmptrapd.conf').
            with_content(%r{doNotLogTraps no}).
            with_content(%r{authCommunity log,execute,net public}).
            with_content(%r{disableAuthorization no})
        end
      end

      case facts[:os]['family']
      when 'RedHat'

        describe 'manage_snmpdtrapd => false RedHat' do
          let(:params) { { manage_snmptrapd: false } }

          it { is_expected.not_to contain_file('snmptrapd.sysconfig') }
        end

        it {
          is_expected.to contain_package('snmpd').with(
            ensure: 'present',
            name: 'net-snmp'
          )
        }

        it {
          is_expected.to contain_file('var-net-snmp').with(
            ensure: 'directory',
            mode: '0755',
            owner: 'root',
            group: 'root',
            path: '/var/lib/net-snmp'
          ).that_requires('Package[snmpd]')
        }

        it {
          is_expected.to contain_file('snmpd.conf').with(
            ensure: 'present',
            mode: '0600',
            owner: 'root',
            group: 'root',
            path: '/etc/snmp/snmpd.conf'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
        }

        it {
          is_expected.to contain_file('snmpd.sysconfig').with(
            ensure: 'present',
            mode: '0644',
            owner: 'root',
            group: 'root',
            path: '/etc/sysconfig/snmpd'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
        }

        it {
          is_expected.to contain_service('snmpd').with(
            ensure: 'running',
            name: 'snmpd',
            enable: true,
            hasstatus: true,
            hasrestart: true
          ).that_requires(['Package[snmpd]', 'File[var-net-snmp]'])
        }

        it {
          is_expected.to contain_file('snmptrapd.conf').with(
            ensure: 'present',
            mode: '0600',
            owner: 'root',
            group: 'root',
            path: '/etc/snmp/snmptrapd.conf'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmptrapd]')
        }

        it {
          is_expected.to contain_file('snmptrapd.sysconfig').with(
            ensure: 'present',
            mode: '0644',
            owner: 'root',
            group: 'root',
            path: '/etc/sysconfig/snmptrapd'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmptrapd]')
        }

        it {
          is_expected.to contain_service('snmptrapd').with(
            ensure: 'stopped',
            name: 'snmptrapd',
            enable: false,
            hasstatus: true,
            hasrestart: true
          ).that_requires(['Package[snmpd]', 'File[var-net-snmp]'])
        }

        case facts[:os]['release']['major']
        when '6'
          it 'contains File[snmpd.sysconfig] with contents "OPTIONS="-LS0-6d -Lf /dev/null -p /var/run/snmpd.pid"' do
            is_expected.to contain_file('snmpd.sysconfig').
              with_content(%r{OPTIONS="-LS0-6d -Lf /dev/null -p /var/run/snmpd.pid"})
          end

          it 'contains File[snmptrapd.sysconfig] with contents "OPTIONS="-Lsd -p /var/run/snmptrapd.pid""' do
            is_expected.to contain_file('snmptrapd.sysconfig').
              with_content(%r{OPTIONS="-Lsd -p /var/run/snmptrapd.pid"})
          end
        else
          it 'contains File[snmpd.sysconfig] with contents "OPTIONS="-LS0-6d"' do
            is_expected.to contain_file('snmpd.sysconfig').
              with_content(%r{OPTIONS="-LS0-6d"})
          end

          it 'contains File[snmptrapd.sysconfig] with contents "OPTIONS="-Lsd"' do
            is_expected.to contain_file('snmptrapd.sysconfig').
              with_content(%r{OPTIONS="-Lsd"})
          end
        end

        describe 'ensure => absent' do
          let(:params) { { ensure: 'absent' } }

          it { is_expected.to contain_package('snmpd').with_ensure('absent') }
          it { is_expected.not_to contain_class('snmp::client') }
          it { is_expected.to contain_file('var-net-snmp').with_ensure('absent') }
          it { is_expected.to contain_file('snmpd.conf').with_ensure('absent') }
          it { is_expected.to contain_file('snmpd.sysconfig').with_ensure('absent') }
          it { is_expected.to contain_service('snmpd').with_ensure('stopped') }
          it { is_expected.to contain_file('snmptrapd.conf').with_ensure('absent') }
          it { is_expected.to contain_file('snmptrapd.sysconfig').with_ensure('absent') }
          it { is_expected.to contain_service('snmptrapd').with_ensure('stopped') }
        end

        describe 'ensure => badvalue' do
          let(:params) { { ensure: 'badvalue' } }

          it { is_expected.to compile.and_raise_error(%r{expects a match for}) }
        end

        describe 'autoupgrade => true' do
          let(:params) { { autoupgrade: true } }

          it { is_expected.to contain_package('snmpd').with_ensure('latest') }
          it { is_expected.not_to contain_class('snmp::client') }
          it { is_expected.to contain_file('var-net-snmp').with_ensure('directory') }
          it { is_expected.to contain_file('snmpd.conf').with_ensure('present') }
          it { is_expected.to contain_file('snmpd.sysconfig').with_ensure('present') }
          it { is_expected.to contain_service('snmpd').with_ensure('running') }
          it { is_expected.to contain_file('snmptrapd.conf').with_ensure('present') }
          it { is_expected.to contain_file('snmptrapd.sysconfig').with_ensure('present') }
          it { is_expected.to contain_service('snmptrapd').with_ensure('stopped') }
        end

        describe 'autoupgrade => badvalue' do
          let(:params) { { autoupgrade: 'badvalue' } }

          it { is_expected.to compile.and_raise_error(%r{expects a Boolean value, got String}) }
        end

        describe 'service_ensure => badvalue' do
          let(:params) { { service_ensure: 'badvalue' } }

          it { is_expected.to compile.and_raise_error(%r{expects a match for Stdlib::Ensure::Service}) }
        end

        describe 'service_config_perms => "0123"' do
          let(:params) { { service_config_perms: '0123' } }

          it { is_expected.to contain_file('snmpd.conf').with_mode('0123') }
          it { is_expected.to contain_file('snmptrapd.conf').with_mode('0123') }
        end

        describe 'service_config_dir_group => "anothergroup"' do
          let(:params) { { service_config_dir_group: 'anothergroup' } }

          it { is_expected.to contain_file('snmpd.conf').with_group('anothergroup') }
          it { is_expected.to contain_file('snmptrapd.conf').with_group('anothergroup') }
        end

        describe 'manage_client => true' do
          let(:params) { { manage_client: true } }

          it {
            is_expected.to contain_class('snmp::client').with(
              ensure: 'present',
              autoupgrade: 'false',
              snmp_config: nil
            )
          }
        end

        describe 'manage_snmpdtrapd => false' do
          let(:params) { { manage_snmptrapd: false } }

          it { is_expected.not_to contain_package('snmptrapd') }
          it { is_expected.not_to contain_file('snmptrapd.conf') }
        end

        describe 'manage_client => true, snmp_config => [ "defVersion 2c", "defCommunity public" ], ensure => absent, and autoupgrade => true' do
          let :params do
            {
              manage_client: true,
              ensure: 'absent',
              autoupgrade: true,
              snmp_config: ['defVersion 2c', 'defCommunity public']
            }
          end

          it {
            is_expected.to contain_class('snmp::client').with(
              ensure: 'absent',
              autoupgrade: 'true',
              snmp_config: ['defVersion 2c', 'defCommunity public']
            )
          }
        end

        describe 'service_ensure => stopped' do
          let(:params) { { service_ensure: 'stopped' } }

          it { is_expected.to contain_service('snmpd').with_ensure('stopped') }
          it { is_expected.to contain_service('snmptrapd').with_ensure('stopped') }
        end

        describe 'trap_service_ensure => running' do
          let(:params) { { trap_service_ensure: 'running' } }

          it { is_expected.to contain_service('snmpd').with_ensure('running') }
          it { is_expected.to contain_service('snmptrapd').with_ensure('running') }
        end

        describe 'service_ensure => stopped and trap_service_ensure => running' do
          let :params do
            {
              service_ensure: 'stopped',
              trap_service_ensure: 'running'
            }
          end

          it { is_expected.to contain_service('snmpd').with_ensure('stopped') }
          it { is_expected.to contain_service('snmptrapd').with_ensure('running') }
        end

        describe 'snmpd_options => blah' do
          let(:params) { { snmpd_options: 'blah' } }

          it { is_expected.to contain_file('snmpd.sysconfig') }

          it 'contains File[snmpd.sysconfig] with contents "OPTIONS=\'blah\'"' do
            is_expected.to contain_file('snmpd.sysconfig').
              with_content(%r{OPTIONS="blah"})
          end
        end

        describe 'snmptrapd_options => bleh' do
          let(:params) { { snmptrapd_options: 'bleh' } }

          it { is_expected.to contain_file('snmptrapd.sysconfig') }

          it 'contains File[snmptrapd.sysconfig] with contents "OPTIONS=\'bleh\'"' do
            is_expected.to contain_file('snmptrapd.sysconfig').
              with_content(%r{OPTIONS="bleh"})
          end
        end

        describe 'com2sec => [ SomeString ]' do
          let(:params) { { com2sec: ['SomeString'] } }

          it 'contains File[snmpd.conf] with contents "com2sec SomeString"' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{com2sec SomeString})
          end
        end

        describe 'com2sec6 => [ SomeString ]' do
          let(:params) { { com2sec6: ['SomeString'] } }

          it 'contains File[snmpd.conf] with contents "com2sec6 SomeString"' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{com2sec6 SomeString})
          end
        end

        describe 'groups => [ SomeString ]' do
          let(:params) { { groups: ['SomeString'] } }

          it 'contains File[snmpd.conf] with contents "group SomeString"' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{group   SomeString})
          end
        end

        describe 'views => [ "SomeArray1", "SomeArray2" ]' do
          let(:params) { { views: %w[SomeArray1 SomeArray2] } }

          it 'contains File[snmpd.conf] with contents from array' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{view    SomeArray1}).
              with_content(%r{view    SomeArray2})
          end
        end

        describe 'accesses => [ "SomeArray1", "SomeArray2" ]' do
          let(:params) { { accesses: %w[SomeArray1 SomeArray2] } }

          it 'contains File[snmpd.conf] with contents from array' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{access  SomeArray1}).
              with_content(%r{access  SomeArray2})
          end
        end

        describe 'dlmod => [ SomeString ]' do
          let(:params) { { dlmod: ['SomeString'] } }

          it 'contains File[snmpd.conf] with contents "dlmod SomeString"' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{dlmod SomeString})
          end
        end

        describe 'extends => [ "SomeArray1", "SomeArray2" ]' do
          let(:params) { { extends: %w[SomeArray1 SomeArray2] } }

          it 'contains File[snmpd.conf] with contents from array' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{extend SomeArray1}).
              with_content(%r{extend SomeArray2})
          end
        end

        describe 'pass => [ "SomeArray1", "SomeArray2" ]' do
          let(:params) { { pass: %w[SomeArray1 SomeArray2] } }

          it 'contains File[snmpd.conf] with contents from array' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{pass SomeArray1}).
              with_content(%r{pass SomeArray2})
          end
        end

        describe 'pass_persist => [ "SomeArray1", "SomeArray2" ]' do
          let(:params) { { pass_persist: %w[SomeArray1 SomeArray2] } }

          it 'contains File[snmpd.conf] with contents from array' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{pass_persist SomeArray1}).
              with_content(%r{pass_persist SomeArray2})
          end
        end

        describe 'openmanage_enable => true' do
          let(:params) { { openmanage_enable: true } }

          it 'contains File[snmpd.conf] with smuxpeers content' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{smuxpeer .1.3.6.1.4.1.674.10892.1}).
              with_content(%r{smuxpeer .1.3.6.1.4.1.674.10893.1})
          end
        end

        describe 'agentaddress => [ "1.2.3.4", "8.6.7.5:222" ]' do
          let(:params) { { agentaddress: ['1.2.3.4', '8.6.7.5:222'] } }

          it 'contains File[snmpd.conf] with contents "agentaddress 1.2.3.4,8.6.7.5:222"' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{agentaddress 1.2.3.4,8.6.7.5:222})
          end
        end

        describe 'do_not_log_tcpwrappers => "yes"' do
          let(:params) { { do_not_log_tcpwrappers: 'yes' } }

          it 'contains File[snmpd.conf] with contents "dontLogTCPWrappersConnects yes' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{dontLogTCPWrappersConnects yes})
          end
        end

        describe 'snmptrapdaddr => [ "5.6.7.8", "2.3.4.5:3333" ]' do
          let(:params) { { snmptrapdaddr: ['5.6.7.8', '2.3.4.5:3333'] } }

          it 'contains File[snmptrapd.conf] with contents "snmpTrapdAddr 5.6.7.8,2.3.4.5:3333"' do
            is_expected.to contain_file('snmptrapd.conf').
              with_content(%r{snmpTrapdAddr 5.6.7.8,2.3.4.5:3333})
          end
        end

        describe 'snmpd_config => [ "option 1", "option 2", ]' do
          let(:params) { { snmpd_config: ['option 1', 'option 2'] } }

          it 'contains File[snmpd.conf] with contents "option1" and "option 2"' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{option 1}).
              with_content(%r{option 1})
          end
        end

        describe 'snmptrapd_config => [ "option 3", "option 4", ]' do
          let(:params) { { snmptrapd_config: ['option 3', 'option 4'] } }

          it 'contains File[snmptrapd.conf] with contents "option 3" and "option 4"' do
            is_expected.to contain_file('snmptrapd.conf').
              with_content(%r{option 3}).
              with_content(%r{option 4})
          end
        end

        describe 'ro_network => [ "127.0.0.1", "192.168.1.1/24", ]' do
          let(:params) { { ro_network: ['127.0.0.1', '192.168.1.1/24'] } }

          it 'contains File[snmpd.conf] with contents "127.0.0.1" and "192.168.1.1/24"' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{rocommunity public 127.0.0.1}).
              with_content(%r{rocommunity public 192.168.1.1/24})
          end
        end

        describe 'ro_network => "127.0.0.2"' do
          let(:params) { { ro_network: '127.0.0.2' } }

          it 'contains File[snmpd.conf] with contents "127.0.0.2"' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{rocommunity public 127.0.0.2})
          end
        end

        describe 'ro_community => [ "a", "b", ] and ro_network => "127.0.0.2"' do
          let(:params) { { ro_community: %w[a b], ro_network: '127.0.0.2' } }

          it 'contains File[snmpd.conf] with contents "a 127.0.0.2" and "b 127.0.0.2"' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{rocommunity a 127.0.0.2}).
              with_content(%r{rocommunity b 127.0.0.2})
          end

          it 'contains File[snmptrapd.conf] with contents "a" and "b"' do
            is_expected.to contain_file('snmptrapd.conf').
              with_content(%r{authCommunity log,execute,net a}).
              with_content(%r{authCommunity log,execute,net b})
          end
        end

        describe 'master => true' do
          let(:params) { { master: true } }

          it 'contains File[snmpd.conf] with contents "master agentx"' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{master agentx})
          end
        end

        describe 'master => true, with all agentx options set' do
          let(:params) do
            {
              master: true,
              agentx_perms: '0644',
              agentx_ping_interval: 5,
              agentx_socket: 'unix:/var/agentx/master',
              agentx_timeout: 10,
              agentx_retries: 10
            }
          end

          it 'contains File[snmpd.conf] with correct contents' do
            is_expected.to contain_file('snmpd.conf').
              with_content(%r{master agentx}).
              with_content(%r{agentXPerms 0644}).
              with_content(%r{agentXPingInterval 5}).
              with_content(%r{agentXSocket unix:/var/agentx/master}).
              with_content(%r{agentXTimeout 10}).
              with_content(%r{agentXRetries 10})
          end
        end

        describe 'master => false, with all agentx options set' do
          let(:params) do
            {
              master: false,
              agentx_perms: '0644',
              agentx_ping_interval: 5,
              agentx_socket: 'unix:/var/agentx/master',
              agentx_timeout: 10,
              agentx_retries: 10
            }
          end

          it { is_expected.to contain_file('snmpd.conf').without_content('/master agentx/') }
          it { is_expected.to contain_file('snmpd.conf').without_content('/agentXPerms 0644/') }
          it { is_expected.to contain_file('snmpd.conf').without_content('/agentXPingInterval 5/') }
          it { is_expected.to contain_file('snmpd.conf').without_content('/agentXSocket unix:/var/agentx/master/') }
          it { is_expected.to contain_file('snmpd.conf').without_content('/agentXTimeout 10/') }
          it { is_expected.to contain_file('snmpd.conf').without_content('/agentXRetries 10/') }
        end

      when 'Debian'

        describe 'manage_snmpdtrapd => false Debian' do
          let(:params) { { manage_snmptrapd: false } }

          # TRAPDOPTS begins being set by the package in Ubuntu 22.04; we should not log a failure
          # in this case
          case facts[:os]['release']['major']
          when '10', '11', '12', '18.04', '20.04'
            it { is_expected.to contain_file('snmpd.sysconfig').without_content(%r{TRAPDRUN|TRAPDOPTS}) }
          end
        end

        it {
          is_expected.to contain_package('snmpd').with(
            ensure: 'present',
            name: 'snmpd'
          )
        }

        it {
          is_expected.to contain_file('snmpd.conf').with(
            ensure: 'present',
            mode: '0600',
            owner: 'root',
            group: 'root',
            path: '/etc/snmp/snmpd.conf'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
        }

        it {
          is_expected.to contain_file('snmpd.sysconfig').with(
            ensure: 'present',
            mode: '0644',
            owner: 'root',
            group: 'root',
            path: '/etc/default/snmpd'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
        }

        it {
          is_expected.to contain_service('snmpd').with(
            ensure: 'running',
            name: 'snmpd',
            enable: true,
            hasstatus: true,
            hasrestart: true
          ).that_requires(['Package[snmpd]', 'File[var-net-snmp]'])
        }

        it {
          is_expected.to contain_file('snmptrapd.conf').with(
            ensure: 'present',
            mode: '0600',
            owner: 'root',
            group: 'root',
            path: '/etc/snmp/snmptrapd.conf'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
        }

        it {
          is_expected.to contain_file('snmptrapd.sysconfig').with(
            ensure: 'present',
            mode: '0644',
            owner: 'root',
            group: 'root',
            path: '/etc/default/snmptrapd'
          ).that_requires('Package[snmptrapd]').that_notifies('Service[snmptrapd]')
        }

        it {
          is_expected.to contain_service('snmptrapd').with(
            ensure: 'stopped',
            name: 'snmptrapd',
            enable: false,
            hasstatus: true,
            hasrestart: true
          ).that_requires(['Package[snmptrapd]', 'File[var-net-snmp]'])
        }

        it {
          is_expected.to contain_systemd__dropin_file('snmpd.conf').with_unit('snmpd.service')
        }

        it {
          is_expected.to contain_systemd__dropin_file('snmptrapd.conf').with_unit('snmptrapd.service')
        }

        case facts[:os]['release']['major']
        when '10', '18.04'
          it {
            is_expected.to contain_systemd__dropin_file('snmpd.conf').with_content(
              %r{ExecStart=\nExecStart=/usr/sbin/snmpd -Lsd -Lf /dev/null -u Debian-snmp -g Debian-snmp -I -smux,mteTrigger,mteTriggerConf -f -p /run/snmpd.pid}
            )
          }

          it {
            is_expected.to contain_systemd__dropin_file('snmptrapd.conf').with_content(
              %r{ExecStart=\nExecStart=/usr/sbin/snmptrapd -Lsd -f -p /run/snmptrapd.pid}
            )
          }

        when '11', '20.04'
          it {
            is_expected.to contain_systemd__dropin_file('snmpd.conf').with_content(
              %r{ExecStart=\nExecStart=/usr/sbin/snmpd -LOw -u Debian-snmp -g Debian-snmp -I -smux,mteTrigger,mteTriggerConf -f -p /run/snmpd.pid}
            )
          }

          it {
            is_expected.to contain_systemd__dropin_file('snmptrapd.conf').with_content(
              %r{ExecStart=\nExecStart=/usr/sbin/snmptrapd -LOw -f -p /run/snmptrapd.pid}
            )
          }
        else
          it {
            is_expected.to contain_systemd__dropin_file('snmpd.conf').with_content(
              %r{ExecStart=\nExecStart=/usr/sbin/snmpd -LOw -u Debian-snmp -g Debian-snmp -I -smux,mteTrigger,mteTriggerConf -f}
            )
          }

          it {
            is_expected.to contain_systemd__dropin_file('snmptrapd.conf').with_content(
              %r{ExecStart=\nExecStart=/usr/sbin/snmptrapd -LOw -f udp:162 udp6:162}
            )
          }
        end

        describe 'Debian-snmp as snmp user' do
          it {
            is_expected.to contain_file('var-net-snmp').with(
              ensure: 'directory',
              mode: '0755',
              owner: 'Debian-snmp',
              group: 'Debian-snmp',
              path: '/var/lib/snmp'
            ).that_requires('Package[snmpd]')
          }
        end

        describe 'service_ensure => stopped and trap_service_ensure => running' do
          let :params do
            {
              service_ensure: 'stopped',
              trap_service_ensure: 'running'
            }
          end

          it { is_expected.to contain_service('snmpd').with_ensure('running') }
          it { is_expected.to contain_service('snmptrapd').with_ensure('running') }

          it 'contains File[snmpd.sysconfig] with content "SNMPDRUN=no"' do
            is_expected.to contain_file('snmpd.sysconfig').
              with_content(%r{SNMPDRUN=no})
          end

          it 'contains File[snmptrapd.sysconfig] with content "TRAPDRUN=yes"' do
            is_expected.to contain_file('snmptrapd.sysconfig').
              with_content(%r{TRAPDRUN=yes})
          end
        end

        describe 'snmpd_options => blah' do
          let(:params) { { snmpd_options: 'blah' } }

          it {
            is_expected.to contain_systemd__dropin_file('snmpd.conf').with_content(
              %r{ExecStart=\nExecStart=/usr/sbin/snmpd blah}
            )
          }

          it { is_expected.to contain_file('snmpd.sysconfig') }

          it 'contains File[snmpd.sysconfig] with contents "SNMPDOPTS=\'blah\'"' do
            is_expected.to contain_file('snmpd.sysconfig').
              with_content(%r{SNMPDOPTS='blah'})
          end
        end

        describe 'snmptrapd_options => bleh' do
          let(:params) { { snmptrapd_options: 'bleh' } }

          it {
            is_expected.to contain_systemd__dropin_file('snmptrapd.conf').with_content(
              %r{ExecStart=\nExecStart=/usr/sbin/snmptrapd bleh}
            )
          }

          it { is_expected.to contain_file('snmpd.sysconfig') }

          it 'contains File[snmpd.sysconfig] with contents "TRAPDOPTS=\'bleh\'"' do
            is_expected.to contain_file('snmpd.sysconfig').
              with_content(%r{TRAPDOPTS='bleh'})
          end
        end
      when 'Suse'
        it {
          is_expected.to contain_package('snmpd').with(
            ensure: 'present',
            name: 'net-snmp'
          )
        }

        it {
          is_expected.to contain_file('var-net-snmp').with(
            ensure: 'directory',
            mode: '0755',
            owner: 'root',
            group: 'root',
            path: '/var/lib/net-snmp'
          ).that_requires('Package[snmpd]')
        }

        it {
          is_expected.to contain_file('snmpd.conf').with(
            ensure: 'present',
            mode: '0600',
            owner: 'root',
            group: 'root',
            path: '/etc/snmp/snmpd.conf'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
        }

        it {
          is_expected.to contain_file('snmpd.sysconfig').with(
            ensure: 'present',
            mode: '0644',
            owner: 'root',
            group: 'root',
            path: '/etc/sysconfig/net-snmp'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
        }

        it 'contains File[snmpd.sysconfig] with contents "SNMPD_LOGLEVEL="d""' do
          is_expected.to contain_file('snmpd.sysconfig').
            with_content(%r{SNMPD_LOGLEVEL="d"})
        end

        it {
          is_expected.to contain_service('snmpd').with(
            ensure: 'running',
            name: 'snmpd',
            enable: true,
            hasstatus: true,
            hasrestart: true
          ).that_requires(['Package[snmpd]', 'File[var-net-snmp]'])
        }

        it {
          is_expected.to contain_file('snmptrapd.conf').with(
            ensure: 'present',
            mode: '0600',
            owner: 'root',
            group: 'root',
            path: '/etc/snmp/snmptrapd.conf'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmptrapd]')
        }

        it { is_expected.not_to contain_file('snmptrapd.sysconfig') }

        it {
          is_expected.to contain_file('/etc/init.d/snmptrapd').with(
            source: '/usr/share/doc/packages/net-snmp/rc.snmptrapd',
            owner: 'root',
            group: 'root',
            mode: '0755'
          ).that_requires('Package[snmpd]').that_comes_before('Service[snmptrapd]')
        }

        it {
          is_expected.to contain_service('snmptrapd').with(
            ensure: 'stopped',
            name: 'snmptrapd',
            enable: false,
            hasstatus: true,
            hasrestart: true
          ).that_requires(['Package[snmpd]', 'File[var-net-snmp]', 'File[/etc/init.d/snmptrapd]'])
        }

        describe 'service_ensure => stopped' do
          let(:params) { { service_ensure: 'stopped' } }

          it { is_expected.to contain_service('snmpd').with_ensure('stopped') }
          it { is_expected.to contain_service('snmptrapd').with_ensure('stopped') }
        end

        describe 'trap_service_ensure => running' do
          let(:params) { { trap_service_ensure: 'running' } }

          it { is_expected.to contain_service('snmpd').with_ensure('running') }
          it { is_expected.to contain_service('snmptrapd').with_ensure('running') }
        end

        describe 'service_ensure => stopped and trap_service_ensure => running' do
          let :params do
            {
              service_ensure: 'stopped',
              trap_service_ensure: 'running'
            }
          end

          it { is_expected.to contain_service('snmpd').with_ensure('stopped') }
          it { is_expected.to contain_service('snmptrapd').with_ensure('running') }
        end

        describe 'snmpd_options => blah' do
          let(:params) { { snmpd_options: 'blah' } }

          it { is_expected.to contain_file('snmpd.sysconfig') }

          it 'contains File[snmpd.sysconfig] with contents "SNMPD_LOGLEVEL="blah""' do
            is_expected.to contain_file('snmpd.sysconfig').
              with_content(%r{SNMPD_LOGLEVEL="blah"})
          end
        end
      when 'FreeBSD'
        it {
          is_expected.to contain_package('snmpd').with(
            ensure: 'present',
            name: 'net-snmp'
          )
        }

        it {
          is_expected.to contain_file('var-net-snmp').with(
            ensure: 'directory',
            mode: '0600',
            owner: 'root',
            group: 'wheel',
            path: '/var/net-snmp'
          ).that_requires('Package[snmpd]')
        }

        it {
          is_expected.to contain_file('snmpd.conf').with(
            ensure: 'present',
            mode: '0755',
            owner: 'root',
            group: 'wheel',
            path: '/usr/local/etc/snmp/snmpd.conf'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
        }

        it {
          is_expected.to contain_service('snmpd').with(
            ensure: 'running',
            name: 'snmpd',
            enable: true,
            hasstatus: true,
            hasrestart: true
          ).that_requires(['Package[snmpd]', 'File[var-net-snmp]'])
        }

        it {
          is_expected.to contain_file('snmptrapd.conf').with(
            ensure: 'present',
            mode: '0755',
            owner: 'root',
            group: 'wheel',
            path: '/usr/local/etc/snmp/snmptrapd.conf'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmptrapd]')
        }

        it {
          is_expected.to contain_service('snmptrapd').with(
            ensure: 'stopped',
            name: 'snmptrapd',
            enable: false,
            hasstatus: true,
            hasrestart: true
          ).that_requires(['Package[snmpd]', 'File[var-net-snmp]'])
        }
      when 'Darwin'
        it { is_expected.not_to contain_package('snmpd') }
        it { is_expected.to contain_file('var-net-snmp').with_path('/var/db/net-snmp') }

        it {
          is_expected.to contain_file('snmpd.conf').with(
            ensure: 'present',
            mode: '0755',
            owner: 'root',
            group: 'wheel',
            path: '/private/etc/snmp/snmpd.conf'
          ).that_notifies('Service[snmpd]')
        }

        it {
          is_expected.to contain_service('snmpd').with(
            ensure: 'running',
            name: 'org.net-snmp.snmpd',
            enable: true,
            hasstatus: true,
            hasrestart: true
          )
        }

        it {
          is_expected.not_to contain_file('snmptrapd.conf').with(
            ensure: 'present',
            mode: '0755',
            owner: 'root',
            group: 'wheel',
            path: '/private/etc/snmp/snmptrapd.conf'
          )
        }

        it {
          is_expected.not_to contain_service('snmptrapd').with(
            ensure: 'stopped',
            name: 'org.net-snmp.snmptrapd',
            enable: false,
            hasstatus: true,
            hasrestart: true
          )
        }
      else
        it { is_expected.to raise_error(Puppet::Error, %r{Module snmp is not supported on}) }
      end
    end
  end
end
