require 'spec_helper'

describe 'snmp', type: 'class' do
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

  debianish = ['Debian']
  suseish = ['Suse']
  freebsdish = ['FreeBSD']
  openbsdish = ['OpenBSD']

  context 'on a supported osfamily, default parameters' do
    describe 'for osfamily RedHat, operatingsystem RedHat, operatingsystemrelease 5.9' do
      let(:params) { {} }
      let :facts do
        {
          os: { 'release' => { 'full' => '5.9', 'major' => '5' }, 'name' => 'CentOS', 'family' => 'RedHat' },
          networking: { 'fqdn' => 'myhost.localdomain' }
        }
      end

      it {
        is_expected.to contain_package('snmpd').with(
          ensure: 'present',
          name: 'net-snmp'
        )
      }
      it { is_expected.not_to contain_class('snmp::client') }
      it {
        is_expected.to contain_file('var-net-snmp').with(
          ensure: 'directory',
          mode: '0700',
          owner: 'root',
          group: 'root',
          path: '/var/net-snmp'
        ).that_requires('Package[snmpd]')
      }

      it {
        is_expected.to contain_file('snmpd.conf').with(
          ensure: 'present',
          mode: '0644',
          owner: 'root',
          group: 'root',
          path: '/etc/snmp/snmpd.conf'
        ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
      }
      # TODO: add more contents for File[snmpd.conf]
      it 'contains File[snmpd.conf] with expected contents' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'agentaddress udp:127.0.0.1:161,udp6:[::1]:161',
                          'rocommunity public 127.0.0.1',
                          'rocommunity6 public ::1',
                          'com2sec notConfigUser  default       public',
                          'com2sec6 notConfigUser  default       public',
                          'group   notConfigGroup v1            notConfigUser',
                          'group   notConfigGroup v2c           notConfigUser',
                          'view    systemview    included   .1.3.6.1.2.1.1',
                          'view    systemview    included   .1.3.6.1.2.1.25.1.1',
                          'access  notConfigGroup ""      any       noauth    exact  systemview none  none',
                          'sysLocation Unknown',
                          'sysContact Unknown',
                          'sysServices 72',
                          'sysName myhost.localdomain',
                          'dontLogTCPWrappersConnects no'
                        ])
      end
      it {
        is_expected.to contain_file('snmpd.sysconfig').with(
          ensure: 'present',
          mode: '0644',
          owner: 'root',
          group: 'root',
          path: '/etc/sysconfig/snmpd.options'
        ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
      }
      it 'contains File[snmpd.sysconfig] with contents "OPTIONS="-Lsd -Lf /dev/null -p /var/run/snmpd.pid -a""' do
        verify_contents(catalogue, 'snmpd.sysconfig', [
                          'OPTIONS="-Lsd -Lf /dev/null -p /var/run/snmpd.pid -a"'
                        ])
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
          mode: '0644',
          owner: 'root',
          group: 'root',
          path: '/etc/snmp/snmptrapd.conf'
        ).that_requires('Package[snmpd]').that_notifies('Service[snmptrapd]')
      }
      # TODO: add more contents for File[snmptrapd.conf]
      it 'contains File[snmptrapd.conf] with correct contents' do
        verify_contents(catalogue, 'snmptrapd.conf', [
                          'doNotLogTraps no',
                          'authCommunity log,execute,net public',
                          'disableAuthorization no'
                        ])
      end
      it {
        is_expected.to contain_file('snmptrapd.sysconfig').with(
          ensure: 'present',
          mode: '0644',
          owner: 'root',
          group: 'root',
          path: '/etc/sysconfig/snmptrapd.options'
        ).that_requires('Package[snmpd]').that_notifies('Service[snmptrapd]')
      }
      it 'contains File[snmptrapd.sysconfig] with contents "OPTIONS="-Lsd -p /var/run/snmptrapd.pid""' do
        verify_contents(catalogue, 'snmptrapd.sysconfig', [
                          'OPTIONS="-Lsd -p /var/run/snmptrapd.pid"'
                        ])
      end
      it {
        is_expected.to contain_service('snmptrapd').with(
          ensure: 'stopped',
          name: 'snmptrapd',
          enable: false,
          hasstatus: true,
          hasrestart: true
        ).that_requires(['Package[snmpd]', 'File[var-net-snmp]'])
      }
    end
    describe 'for osfamily RedHat, operatingsystem RedHat, operatingsystemrelease 6.4' do
      let(:params) { {} }
      let :facts do
        {
          os: { 'release' => { 'full' => '6.4', 'major' => '6' }, 'name' => 'CentOS', 'family' => 'RedHat' },
          networking: { 'fqdn' => 'myhost.localdomain' }
        }
      end

      it {
        is_expected.to contain_package('snmpd').with(
          ensure: 'present',
          name: 'net-snmp'
        )
      }
      it { is_expected.not_to contain_class('snmp::client') }
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
      # TODO: add more contents for File[snmpd.conf]
      it 'contains File[snmpd.conf] with expected contents' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'agentaddress udp:127.0.0.1:161,udp6:[::1]:161',
                          'rocommunity public 127.0.0.1',
                          'rocommunity6 public ::1',
                          'com2sec notConfigUser  default       public',
                          'com2sec6 notConfigUser  default       public',
                          'group   notConfigGroup v1            notConfigUser',
                          'group   notConfigGroup v2c           notConfigUser',
                          'view    systemview    included   .1.3.6.1.2.1.1',
                          'view    systemview    included   .1.3.6.1.2.1.25.1.1',
                          'access  notConfigGroup ""      any       noauth    exact  systemview none  none',
                          'sysLocation Unknown',
                          'sysContact Unknown',
                          'sysServices 72',
                          'sysName myhost.localdomain',
                          'dontLogTCPWrappersConnects no'
                        ])
      end
      it {
        is_expected.to contain_file('snmpd.sysconfig').with(
          ensure: 'present',
          mode: '0644',
          owner: 'root',
          group: 'root',
          path: '/etc/sysconfig/snmpd'
        ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
      }
      it 'contains File[snmpd.sysconfig] with contents "OPTIONS="-LS0-6d -Lf /dev/null -p /var/run/snmpd.pid""' do
        verify_contents(catalogue, 'snmpd.sysconfig', [
                          'OPTIONS="-LS0-6d -Lf /dev/null -p /var/run/snmpd.pid"'
                        ])
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
      # TODO: add more contents for File[snmptrapd.conf]
      it 'contains File[snmptrapd.conf] with correct contents' do
        verify_contents(catalogue, 'snmptrapd.conf', [
                          'doNotLogTraps no',
                          'authCommunity log,execute,net public',
                          'disableAuthorization no'
                        ])
      end
      it {
        is_expected.to contain_file('snmptrapd.sysconfig').with(
          ensure: 'present',
          mode: '0644',
          owner: 'root',
          group: 'root',
          path: '/etc/sysconfig/snmptrapd'
        ).that_requires('Package[snmpd]').that_notifies('Service[snmptrapd]')
      }
      it 'contains File[snmptrapd.sysconfig] with contents "OPTIONS="-Lsd -p /var/run/snmptrapd.pid""' do
        verify_contents(catalogue, 'snmptrapd.sysconfig', [
                          'OPTIONS="-Lsd -p /var/run/snmptrapd.pid"'
                        ])
      end
      it {
        is_expected.to contain_service('snmptrapd').with(
          ensure: 'stopped',
          name: 'snmptrapd',
          enable: false,
          hasstatus: true,
          hasrestart: true
        ).that_requires(['Package[snmpd]', 'File[var-net-snmp]'])
      }
    end

    debianish.each do |os|
      describe "for osfamily Debian, operatingsystem #{os}" do
        let(:params) { {} }
        let :facts do
          {
            os: { 'release' => { 'full' => '6.0.7', 'major' => '6' }, 'name' => 'Debian', 'family' => 'Debian' },
            networking: { 'fqdn' => 'myhost2.localdomain' }
          }
        end

        it {
          is_expected.to contain_package('snmpd').with(
            ensure: 'present',
            name: 'snmpd'
          )
        }
        it { is_expected.not_to contain_class('snmp::client') }
        it {
          is_expected.to contain_file('var-net-snmp').with(
            ensure: 'directory',
            mode: '0755',
            owner: 'snmp',
            group: 'snmp',
            path: '/var/lib/snmp'
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
        # TODO: add more contents for File[snmpd.conf]
        it 'contains File[snmpd.conf] with expected contents' do
          verify_contents(catalogue, 'snmpd.conf', [
                            'agentaddress udp:127.0.0.1:161,udp6:[::1]:161',
                            'rocommunity public 127.0.0.1',
                            'rocommunity6 public ::1',
                            'com2sec notConfigUser  default       public',
                            'com2sec6 notConfigUser  default       public',
                            'group   notConfigGroup v1            notConfigUser',
                            'group   notConfigGroup v2c           notConfigUser',
                            'view    systemview    included   .1.3.6.1.2.1.1',
                            'view    systemview    included   .1.3.6.1.2.1.25.1.1',
                            'access  notConfigGroup ""      any       noauth    exact  systemview none  none',
                            'sysLocation Unknown',
                            'sysContact Unknown',
                            'sysServices 72',
                            'sysName myhost2.localdomain',
                            'dontLogTCPWrappersConnects no'
                          ])
        end
        it {
          is_expected.to contain_file('snmpd.sysconfig').with(
            ensure: 'present',
            mode: '0644',
            owner: 'root',
            group: 'root',
            path: '/etc/default/snmpd'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
        }
        it 'contains File[snmpd.sysconfig] with contents "SNMPDOPTS=\'-Lsd -Lf /dev/null -u snmp -g snmp -I -smux -p /var/run/snmpd.pid\'"' do
          verify_contents(catalogue, 'snmpd.sysconfig', [
                            'SNMPDRUN=yes',
                            'SNMPDOPTS=\'-Lsd -Lf /dev/null -u snmp -g snmp -I -smux -p /var/run/snmpd.pid\''
                          ])
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
          ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
        }
        # TODO: add more contents for File[snmptrapd.conf]
        it 'contains File[snmptrapd.conf] with correct contents' do
          verify_contents(catalogue, 'snmptrapd.conf', [
                            'doNotLogTraps no',
                            'authCommunity log,execute,net public',
                            'disableAuthorization no'
                          ])
        end
        it { is_expected.not_to contain_file('snmptrapd.sysconfig') }
        it 'contains File[snmpd.sysconfig] with contents "TRAPDOPTS=\'-Lsd -p /var/run/snmptrapd.pid\'"' do
          verify_contents(catalogue, 'snmpd.sysconfig', [
                            'TRAPDRUN=no',
                            'TRAPDOPTS=\'-Lsd -p /var/run/snmptrapd.pid\''
                          ])
        end
        it { is_expected.not_to contain_service('snmptrapd') }
      end
    end

    suseish.each do |os|
      describe "for osfamily Suse, operatingsystem #{os}" do
        let(:params) { {} }
        let :facts do
          {
            os: { 'release' => { 'full' => '11.1', 'major' => '11' }, 'name' => 'SLES', 'family' => 'Suse' },
            networking: { 'fqdn' => 'myhost3.localdomain' }
          }
        end

        it {
          is_expected.to contain_package('snmpd').with(
            ensure: 'present',
            name: 'net-snmp'
          )
        }
        it { is_expected.not_to contain_class('snmp::client') }
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
        # TODO: add more contents for File[snmpd.conf]
        it 'contains File[snmpd.conf] with expected contents' do
          verify_contents(catalogue, 'snmpd.conf', [
                            'agentaddress udp:127.0.0.1:161,udp6:[::1]:161',
                            'rocommunity public 127.0.0.1',
                            'rocommunity6 public ::1',
                            'com2sec notConfigUser  default       public',
                            'com2sec6 notConfigUser  default       public',
                            'group   notConfigGroup v1            notConfigUser',
                            'group   notConfigGroup v2c           notConfigUser',
                            'view    systemview    included   .1.3.6.1.2.1.1',
                            'view    systemview    included   .1.3.6.1.2.1.25.1.1',
                            'access  notConfigGroup ""      any       noauth    exact  systemview none  none',
                            'sysLocation Unknown',
                            'sysContact Unknown',
                            'sysServices 72',
                            'sysName myhost3.localdomain',
                            'dontLogTCPWrappersConnects no'
                          ])
        end
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
          verify_contents(catalogue, 'snmpd.sysconfig', [
                            'SNMPD_LOGLEVEL="d"'
                          ])
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
        # TODO: add more contents for File[snmptrapd.conf]
        it 'contains File[snmptrapd.conf] with correct contents' do
          verify_contents(catalogue, 'snmptrapd.conf', [
                            'doNotLogTraps no',
                            'authCommunity log,execute,net public',
                            'disableAuthorization no'
                          ])
        end
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
      end
    end

    freebsdish.each do |os|
      describe "for osfamily FreeBSD, operatingsystem #{os}" do
        let(:params) { {} }
        let :facts do
          {
            os: { 'release' => { 'full' => '9.2', 'major' => '9' }, 'name' => 'FreeBSD', 'family' => 'FreeBSD' },
            networking: { 'fqdn' => 'myhost4.localdomain' }
          }
        end

        it {
          is_expected.to contain_package('snmpd').with(
            ensure: 'present',
            name: 'net-mgmt/net-snmp'
          )
        }
        it { is_expected.not_to contain_class('snmp::client') }
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
        # TODO: add more contents for File[snmpd.conf]
        it 'contains File[snmpd.conf] with expected contents' do
          verify_contents(catalogue, 'snmpd.conf', [
                            'agentaddress udp:127.0.0.1:161,udp6:[::1]:161',
                            'rocommunity public 127.0.0.1',
                            'rocommunity6 public ::1',
                            'com2sec notConfigUser  default       public',
                            'com2sec6 notConfigUser  default       public',
                            'group   notConfigGroup v1            notConfigUser',
                            'group   notConfigGroup v2c           notConfigUser',
                            'view    systemview    included   .1.3.6.1.2.1.1',
                            'view    systemview    included   .1.3.6.1.2.1.25.1.1',
                            'access  notConfigGroup ""      any       noauth    exact  systemview none  none',
                            'sysLocation Unknown',
                            'sysContact Unknown',
                            'sysServices 72',
                            'sysName myhost4.localdomain',
                            'dontLogTCPWrappersConnects no'
                          ])
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
            mode: '0755',
            owner: 'root',
            group: 'wheel',
            path: '/usr/local/etc/snmp/snmptrapd.conf'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmptrapd]')
        }
        # TODO: add more contents for File[snmptrapd.conf]
        it 'contains File[snmptrapd.conf] with correct contents' do
          verify_contents(catalogue, 'snmptrapd.conf', [
                            'doNotLogTraps no',
                            'authCommunity log,execute,net public',
                            'disableAuthorization no'
                          ])
        end
        it {
          is_expected.to contain_service('snmptrapd').with(
            ensure: 'stopped',
            name: 'snmptrapd',
            enable: false,
            hasstatus: true,
            hasrestart: true
          ).that_requires(['Package[snmpd]', 'File[var-net-snmp]'])
        }
      end
    end

    openbsdish.each do |os|
      describe "for osfamily OpenBSD, operatingsystem #{os}" do
        let(:params) { {} }
        let :facts do
          {
            os: { 'release' => { 'full' => '5.9', 'major' => '5' }, 'name' => 'OpenBSD', 'family' => 'OpenBSD' },
            networking: { 'fqdn' => 'myhost4.localdomain' }
          }
        end

        it {
          is_expected.to contain_package('snmpd').with(
            ensure: 'present',
            name: 'net-snmp'
          )
        }
        it { is_expected.not_to contain_class('snmp::client') }
        it {
          is_expected.to contain_file('var-net-snmp').with(
            ensure: 'directory',
            mode: '0600',
            owner: '_netsnmp',
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
            path: '/etc/snmp/snmpd.conf'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmpd]')
        }
        # TODO: add more contents for File[snmpd.conf]
        it 'contains File[snmpd.conf] with expected contents' do
          verify_contents(catalogue, 'snmpd.conf', [
                            'agentaddress udp:127.0.0.1:161,udp6:[::1]:161',
                            'rocommunity public 127.0.0.1',
                            'rocommunity6 public ::1',
                            'com2sec notConfigUser  default       public',
                            'com2sec6 notConfigUser  default       public',
                            'group   notConfigGroup v1            notConfigUser',
                            'group   notConfigGroup v2c           notConfigUser',
                            'view    systemview    included   .1.3.6.1.2.1.1',
                            'view    systemview    included   .1.3.6.1.2.1.25.1.1',
                            'access  notConfigGroup ""      any       noauth    exact  systemview none  none',
                            'sysLocation Unknown',
                            'sysContact Unknown',
                            'sysServices 72',
                            'sysName myhost4.localdomain',
                            'dontLogTCPWrappersConnects no'
                          ])
        end
        it {
          is_expected.to contain_service('snmpd').with(
            ensure: 'running',
            name: 'netsnmpd',
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
            path: '/etc/snmp/snmptrapd.conf'
          ).that_requires('Package[snmpd]').that_notifies('Service[snmptrapd]')
        }
        # TODO: add more contents for File[snmptrapd.conf]
        it 'contains File[snmptrapd.conf] with correct contents' do
          verify_contents(catalogue, 'snmptrapd.conf', [
                            'doNotLogTraps no',
                            'authCommunity log,execute,net public',
                            'disableAuthorization no'
                          ])
        end
        it {
          is_expected.to contain_service('snmptrapd').with(
            ensure: 'stopped',
            name: 'netsnmptrapd',
            enable: false,
            hasstatus: true,
            hasrestart: true
          ).that_requires(['Package[snmpd]', 'File[var-net-snmp]'])
        }
      end
    end
  end

  context 'on a supported osfamily (RedHat), custom parameters' do
    let :facts do
      {
        os: { 'release' => { 'full' => '6.4', 'major' => '6' }, 'name' => 'CentOS', 'family' => 'RedHat' }
      }
    end

    describe 'ensure => absent' do
      let(:params) { { ensure: 'absent' } }

      it { is_expected.to contain_package('snmpd').with_ensure('absent') }
      it { is_expected.not_to contain_class('snmp::client') }
      it { is_expected.to contain_file('var-net-snmp').with_ensure('directory') }
      it { is_expected.to contain_file('snmpd.conf').with_ensure('absent') }
      it { is_expected.to contain_file('snmpd.sysconfig').with_ensure('absent') }
      it { is_expected.to contain_service('snmpd').with_ensure('stopped') }
      it { is_expected.to contain_file('snmptrapd.conf').with_ensure('absent') }
      it { is_expected.to contain_file('snmptrapd.sysconfig').with_ensure('absent') }
      it { is_expected.to contain_service('snmptrapd').with_ensure('stopped') }
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

      it 'fails' do
        expect do
          is_expected.to raise_error(Puppet::Error, %r{"badvalue" is not a boolean.})
        end
      end
    end

    describe 'service_ensure => badvalue' do
      let(:params) { { service_ensure: 'badvalue' } }

      it 'fails' do
        expect do
          is_expected.to raise_error(Puppet::Error, %r{service_ensure parameter must be running or stopped})
        end
      end
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
          snmp_config: []
        )
      }
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
        verify_contents(catalogue, 'snmpd.sysconfig', [
                          'OPTIONS="blah"'
                        ])
      end
    end

    describe 'snmptrapd_options => bleh' do
      let(:params) { { snmptrapd_options: 'bleh' } }

      it { is_expected.to contain_file('snmptrapd.sysconfig') }
      it 'contains File[snmptrapd.sysconfig] with contents "OPTIONS=\'bleh\'"' do
        verify_contents(catalogue, 'snmptrapd.sysconfig', [
                          'OPTIONS="bleh"'
                        ])
      end
    end

    describe 'com2sec => [ SomeString ]' do
      let(:params) { { com2sec: ['SomeString'] } }

      it 'contains File[snmpd.conf] with contents "com2sec SomeString"' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'com2sec SomeString'
                        ])
      end
    end

    describe 'com2sec6 => [ SomeString ]' do
      let(:params) { { com2sec6: ['SomeString'] } }

      it 'contains File[snmpd.conf] with contents "com2sec6 SomeString"' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'com2sec6 SomeString'
                        ])
      end
    end

    describe 'groups => [ SomeString ]' do
      let(:params) { { groups: ['SomeString'] } }

      it 'contains File[snmpd.conf] with contents "group SomeString"' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'group   SomeString'
                        ])
      end
    end

    describe 'views => [ "SomeArray1", "SomeArray2" ]' do
      let(:params) { { views: %w[SomeArray1 SomeArray2] } }

      it 'contains File[snmpd.conf] with contents from array' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'view    SomeArray1',
                          'view    SomeArray2'
                        ])
      end
    end

    describe 'accesses => [ "SomeArray1", "SomeArray2" ]' do
      let(:params) { { accesses: %w[SomeArray1 SomeArray2] } }

      it 'contains File[snmpd.conf] with contents from array' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'access  SomeArray1',
                          'access  SomeArray2'
                        ])
      end
    end

    describe 'dlmod => [ SomeString ]' do
      let(:params) { { dlmod: ['SomeString'] } }

      it 'contains File[snmpd.conf] with contents "dlmod SomeString"' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'dlmod SomeString'
                        ])
      end
    end

    describe 'extends => [ "SomeArray1", "SomeArray2" ]' do
      let(:params) { { extends: %w[SomeArray1 SomeArray2] } }

      it 'contains File[snmpd.conf] with contents from array' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'extend SomeArray1',
                          'extend SomeArray2'
                        ])
      end
    end

    describe 'openmanage_enable => true' do
      let(:params) { { openmanage_enable: true } }

      it 'contains File[snmpd.conf] with contents "smuxpeer .1.3.6.1.4.1.674.10892.1"' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'smuxpeer .1.3.6.1.4.1.674.10892.1'
                        ])
      end
      it 'contains File[snmpd.conf] with contents "smuxpeer .1.3.6.1.4.1.674.10893.1"' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'smuxpeer .1.3.6.1.4.1.674.10893.1'
                        ])
      end
    end

    describe 'agentaddress => [ "1.2.3.4", "8.6.7.5:222" ]' do
      let(:params) { { agentaddress: ['1.2.3.4', '8.6.7.5:222'] } }

      it 'contains File[snmpd.conf] with contents "agentaddress 1.2.3.4,8.6.7.5:222"' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'agentaddress 1.2.3.4,8.6.7.5:222'
                        ])
      end
    end

    describe 'do_not_log_tcpwrappers => "yes"' do
      let(:params) { { do_not_log_tcpwrappers: 'yes' } }

      it 'contains File[snmpd.conf] with contents "dontLogTCPWrappersConnects yes' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'dontLogTCPWrappersConnects yes'
                        ])
      end
    end

    describe 'snmptrapdaddr => [ "5.6.7.8", "2.3.4.5:3333" ]' do
      let(:params) { { snmptrapdaddr: ['5.6.7.8', '2.3.4.5:3333'] } }

      it 'contains File[snmptrapd.conf] with contents "snmpTrapdAddr 5.6.7.8,2.3.4.5:3333"' do
        verify_contents(catalogue, 'snmptrapd.conf', [
                          'snmpTrapdAddr 5.6.7.8,2.3.4.5:3333'
                        ])
      end
    end

    describe 'snmpd_config => [ "option 1", "option 2", ]' do
      let(:params) { { snmpd_config: ['option 1', 'option 2'] } }

      it 'contains File[snmpd.conf] with contents "option1" and "option 2"' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'option 1',
                          'option 2'
                        ])
      end
    end

    describe 'snmptrapd_config => [ "option 3", "option 4", ]' do
      let(:params) { { snmptrapd_config: ['option 3', 'option 4'] } }

      it 'contains File[snmptrapd.conf] with contents "option 3" and "option 4"' do
        verify_contents(catalogue, 'snmptrapd.conf', [
                          'option 3',
                          'option 4'
                        ])
      end
    end

    describe 'ro_network => [ "127.0.0.1", "192.168.1.1/24", ]' do
      let(:params) { { ro_network: ['127.0.0.1', '192.168.1.1/24'] } }

      it 'contains File[snmpd.conf] with contents "127.0.0.1" and "192.168.1.1/24"' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'rocommunity public 127.0.0.1',
                          'rocommunity public 192.168.1.1/24'
                        ])
      end
    end

    describe 'ro_network => "127.0.0.2"' do
      let(:params) { { ro_network: '127.0.0.2' } }

      it 'contains File[snmpd.conf] with contents "127.0.0.2"' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'rocommunity public 127.0.0.2'
                        ])
      end
    end

    describe 'ro_community => [ "a", "b", ] and ro_network => "127.0.0.2"' do
      let(:params) { { ro_community: %w[a b], ro_network: '127.0.0.2' } }

      it 'contains File[snmpd.conf] with contents "a 127.0.0.2" and "b 127.0.0.2"' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'rocommunity a 127.0.0.2',
                          'rocommunity b 127.0.0.2'
                        ])
      end
      it 'contains File[snmptrapd.conf] with contents "a" and "b"' do
        verify_contents(catalogue, 'snmptrapd.conf', [
                          'authCommunity log,execute,net a',
                          'authCommunity log,execute,net b'
                        ])
      end
    end

    describe 'master => true' do
      let(:params) { { master: true } }

      it 'contains File[snmpd.conf] with contents "master agentx"' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'master agentx'
                        ])
      end
    end

    describe 'master => true, with all agentx options set' do
      let(:params) do
        {
          master: true,
          agentx_perms: '0644',
          agentx_ping_interval: '5',
          agentx_socket: 'unix:/var/agentx/master',
          agentx_timeout: 10,
          agentx_retries: 10
        }
      end

      it 'contains File[snmpd.conf] with correct contents' do
        verify_contents(catalogue, 'snmpd.conf', [
                          'master agentx',
                          'agentXPerms 0644',
                          'agentXPingInterval 5',
                          'agentXSocket unix:/var/agentx/master',
                          'agentXTimeout 10',
                          'agentXRetries 10'
                        ])
      end
    end

    describe 'master => false, with all agentx options set' do
      let(:params) do
        {
          master: false,
          agentx_perms: '0644',
          agentx_ping_interval: '5',
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
  end

  context 'on a supported osfamily (Debian), custom parameters' do
    let :facts do
      {
        os: { 'release' => { 'full' => '7.0', 'major' => '7' }, 'name' => 'Debian', 'family' => 'Debian' }
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
      it { is_expected.not_to contain_service('snmptrapd') }
      it 'contains File[snmpd.sysconfig] with contents "SNMPDRUN=no" and "TRAPDRUN=yes"' do
        verify_contents(catalogue, 'snmpd.sysconfig', [
                          'SNMPDRUN=no',
                          'TRAPDRUN=yes'
                        ])
      end
    end

    describe 'snmpd_options => blah' do
      let(:params) { { snmpd_options: 'blah' } }

      it { is_expected.to contain_file('snmpd.sysconfig') }
      it 'contains File[snmpd.sysconfig] with contents "SNMPDOPTS=\'blah\'"' do
        verify_contents(catalogue, 'snmpd.sysconfig', [
                          'SNMPDOPTS=\'blah\''
                        ])
      end
    end

    describe 'snmptrapd_options => bleh' do
      let(:params) { { snmptrapd_options: 'bleh' } }

      it { is_expected.to contain_file('snmpd.sysconfig') }
      it 'contains File[snmpd.sysconfig] with contents "TRAPDOPTS=\'bleh\'"' do
        verify_contents(catalogue, 'snmpd.sysconfig', [
                          'TRAPDOPTS=\'bleh\''
                        ])
      end
    end
  end

  context 'on a supported osfamily (Debian Stretch), custom parameters' do
    let :facts do
      {
        os: { 'release' => { 'full' => '9.0', 'major' => '9' }, 'name' => 'Debian', 'family' => 'Debian' }
      }
    end

    describe 'Debian-snmp as snmp user' do
      it 'contains File[snmpd.sysconfig] with contents "OPTIONS="-Lsd -Lf /dev/null -u Debian-snmp -g Debian-snmp -I -smux -p /var/run/snmpd.pid""' do
        verify_contents(catalogue, 'snmpd.sysconfig', [
                          'SNMPDOPTS=\'-Lsd -Lf /dev/null -u Debian-snmp -g Debian-snmp -I -smux -p /var/run/snmpd.pid\''
                        ])
      end
    end
  end

  context 'on a supported osfamily (Suse), custom parameters' do
    let :facts do
      {
        os: { 'release' => { 'full' => '11.1', 'major' => '11' }, 'name' => 'SLES', 'family' => 'Suse' }
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
      it 'contains File[snmpd.sysconfig] with contents "SNMPD_LOGLEVEL="blah""' do
        verify_contents(catalogue, 'snmpd.sysconfig', [
                          'SNMPD_LOGLEVEL="blah"'
                        ])
      end
    end
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      describe 'snmpv2_enable => true' do
        let(:params) { { snmpv2_enable: true } }

        it 'contains File[snmpd.conf] with expected contents' do
          verify_contents(catalogue, 'snmpd.conf', [
                            'com2sec notConfigUser  default       public',
                            'com2sec6 notConfigUser  default       public',
                            'group   notConfigGroup v1            notConfigUser',
                            'group   notConfigGroup v2c           notConfigUser',
                            'view    systemview    included   .1.3.6.1.2.1.1',
                            'view    systemview    included   .1.3.6.1.2.1.25.1.1',
                            'access  notConfigGroup ""      any       noauth    exact  systemview none  none'
                          ])
        end
      end
      describe 'snmpv2_enable => badvalue' do
        let(:params) { { snmpv2_enable: 'badvalue' } }

        it 'fails' do
          expect do
            is_expected.to raise_error(Puppet::Error, %r{"badvalue" is not a boolean.})
          end
        end
      end
    end
  end
end
