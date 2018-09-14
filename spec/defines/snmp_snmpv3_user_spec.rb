require 'spec_helper'

describe 'snmp::snmpv3_user', type: 'define' do
  context 'on a supported osfamily' do
    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystem: 'CentOS',
        operatingsystemrelease: '6.4',
        lsbmajdistrelease: '6',
        operatingsystemmajrelease: '6'
      }
    end

    describe 'authtype => badString' do
      let(:title) { 'authtype' }

      let :params do
        {
          authpass: 'myauthpass',
          authtype: 'badString'
        }
      end

      it 'fails' do
        expect do
          is_expected.to raise_error(Puppet::Error, %r{$authtype must be either SHA or MD5.})
        end
      end
    end

    describe 'privtype => badString' do
      let(:title) { 'privtype' }

      let :params do
        {
          authpass: 'myauthpass',
          privtype: 'badString'
        }
      end

      it 'fails' do
        expect do
          is_expected.to raise_error(Puppet::Error, %r{$privtype must be either AES or DES.})
        end
      end
    end

    describe 'daemon => badString' do
      let(:title) { 'daemon' }

      let :params do
        {
          authpass: 'myauthpass',
          daemon: 'badString'
        }
      end

      it 'fails' do
        expect do
          is_expected.to raise_error(Puppet::Error, %r{$daemon must be either snmpd or snmptrapd.})
        end
      end
    end
  end

  context 'on a supported osfamily, RedHat' do
    let :facts do
      {
        osfamily: 'RedHat',
        operatingsystem: 'CentOS',
        operatingsystemrelease: '6.4',
        lsbmajdistrelease: '6',
        operatingsystemmajrelease: '6'
      }
    end

    describe 'with default settings' do
      let(:title) { 'myDEFAULTuser' }

      let :params do
        {
          authpass: 'myauthpass'
        }
      end

      it {
        is_expected.to contain_exec('create-snmpv3-user-myDEFAULTuser').with(
          command: 'service snmpd stop ; sleep 5 ; echo "createUser myDEFAULTuser SHA \"myauthpass\"" >>/var/lib/net-snmp/snmpd.conf && touch /var/lib/net-snmp/myDEFAULTuser-snmpd',
          creates: '/var/lib/net-snmp/myDEFAULTuser-snmpd',
          require: ['Package[snmpd]', 'File[var-net-snmp]'],
          before: 'Service[snmpd]'
        )
      }
    end

    describe 'with all settings' do
      let(:title) { 'myALLuser' }

      let :params do
        {
          authpass: 'myauthpass',
          authtype: 'MD5',
          privpass: 'myprivpass',
          privtype: 'DES'
        }
      end

      it {
        is_expected.to contain_exec('create-snmpv3-user-myALLuser').with(
          command: 'service snmpd stop ; sleep 5 ; echo "createUser myALLuser MD5 \"myauthpass\" DES \"myprivpass\"" >>/var/lib/net-snmp/snmpd.conf && touch /var/lib/net-snmp/myALLuser-snmpd',
          creates: '/var/lib/net-snmp/myALLuser-snmpd',
          require: ['Package[snmpd]', 'File[var-net-snmp]'],
          before: 'Service[snmpd]'
        )
      }
    end

    describe 'with snmptrapd settings' do
      let(:title) { 'myTRAPuser' }

      let :params do
        {
          authpass: 'myauthpass',
          daemon: 'snmptrapd'
        }
      end

      it {
        is_expected.to contain_exec('create-snmpv3-user-myTRAPuser').with(
          command: 'service snmptrapd stop ; sleep 5 ; echo "createUser myTRAPuser SHA \"myauthpass\"" >>/var/lib/net-snmp/snmptrapd.conf && touch /var/lib/net-snmp/myTRAPuser-snmptrapd',
          creates: '/var/lib/net-snmp/myTRAPuser-snmptrapd',
          require: ['Package[snmpd]', 'File[var-net-snmp]'],
          before: 'Service[snmptrapd]'
        )
      }
    end
  end

  context 'on a supported osfamily, Debian' do
    let :facts do
      {
        osfamily: 'Debian',
        operatingsystem: 'Ubuntu',
        operatingsystemrelease: '12.04',
        lsbmajdistrelease: '12',
        operatingsystemmajrelease: '12'
      }
    end

    describe 'with default settings' do
      let(:title) { 'myDEFAULTuser' }

      let :params do
        {
          authpass: 'myauthpass'
        }
      end

      it {
        is_expected.to contain_exec('create-snmpv3-user-myDEFAULTuser').with(
          command: 'service snmpd stop ; sleep 5 ; echo "createUser myDEFAULTuser SHA \"myauthpass\"" >>/var/lib/snmp/snmpd.conf && touch /var/lib/snmp/myDEFAULTuser-snmpd',
          creates: '/var/lib/snmp/myDEFAULTuser-snmpd',
          require: ['Package[snmpd]', 'File[var-net-snmp]'],
          before: 'Service[snmpd]'
        )
      }
    end

    describe 'with all settings' do
      let(:title) { 'myALLuser' }

      let :params do
        {
          authpass: 'myauthpass',
          authtype: 'MD5',
          privpass: 'myprivpass',
          privtype: 'DES'
        }
      end

      it {
        is_expected.to contain_exec('create-snmpv3-user-myALLuser').with(
          command: 'service snmpd stop ; sleep 5 ; echo "createUser myALLuser MD5 \"myauthpass\" DES \"myprivpass\"" >>/var/lib/snmp/snmpd.conf && touch /var/lib/snmp/myALLuser-snmpd',
          creates: '/var/lib/snmp/myALLuser-snmpd',
          require: ['Package[snmpd]', 'File[var-net-snmp]'],
          before: 'Service[snmpd]'
        )
      }
    end

    describe 'with snmptrapd settings' do
      let(:title) { 'myTRAPuser' }

      let :params do
        {
          authpass: 'myauthpass',
          daemon: 'snmptrapd'
        }
      end

      it {
        is_expected.to contain_exec('create-snmpv3-user-myTRAPuser').with(
          command: 'service snmpd stop ; sleep 5 ; echo "createUser myTRAPuser SHA \"myauthpass\"" >>/var/lib/snmp/snmptrapd.conf && touch /var/lib/snmp/myTRAPuser-snmptrapd',
          creates: '/var/lib/snmp/myTRAPuser-snmptrapd',
          require: ['Package[snmpd]', 'File[var-net-snmp]'],
          before: 'Service[snmpd]'
        )
      }
    end
  end

  context 'on a supported osfamily, Suse' do
    let :facts do
      {
        osfamily: 'Suse',
        operatingsystem: 'SLES',
        operatingsystemrelease: '11.1',
        lsbmajdistrelease: '11',
        operatingsystemmajrelease: '11'
      }
    end

    describe 'with default settings' do
      let(:title) { 'myDEFAULTuser' }

      let :params do
        {
          authpass: 'myauthpass'
        }
      end

      it {
        is_expected.to contain_exec('create-snmpv3-user-myDEFAULTuser').with(
          command: 'service snmpd stop ; sleep 5 ; echo "createUser myDEFAULTuser SHA \"myauthpass\"" >>/var/lib/net-snmp/snmpd.conf && touch /var/lib/net-snmp/myDEFAULTuser-snmpd',
          creates: '/var/lib/net-snmp/myDEFAULTuser-snmpd',
          require: ['Package[snmpd]', 'File[var-net-snmp]'],
          before: 'Service[snmpd]'
        )
      }
    end

    describe 'with all settings' do
      let(:title) { 'myALLuser' }

      let :params do
        {
          authpass: 'myauthpass',
          authtype: 'MD5',
          privpass: 'myprivpass',
          privtype: 'DES'
        }
      end

      it {
        is_expected.to contain_exec('create-snmpv3-user-myALLuser').with(
          command: 'service snmpd stop ; sleep 5 ; echo "createUser myALLuser MD5 \"myauthpass\" DES \"myprivpass\"" >>/var/lib/net-snmp/snmpd.conf && touch /var/lib/net-snmp/myALLuser-snmpd',
          creates: '/var/lib/net-snmp/myALLuser-snmpd',
          require: ['Package[snmpd]', 'File[var-net-snmp]'],
          before: 'Service[snmpd]'
        )
      }
    end

    describe 'with snmptrapd settings' do
      let(:title) { 'myTRAPuser' }

      let :params do
        {
          authpass: 'myauthpass',
          daemon: 'snmptrapd'
        }
      end

      it {
        is_expected.to contain_exec('create-snmpv3-user-myTRAPuser').with(
          command: 'service snmptrapd stop ; sleep 5 ; echo "createUser myTRAPuser SHA \"myauthpass\"" >>/var/lib/net-snmp/snmptrapd.conf && touch /var/lib/net-snmp/myTRAPuser-snmptrapd',
          creates: '/var/lib/net-snmp/myTRAPuser-snmptrapd',
          require: ['Package[snmpd]', 'File[var-net-snmp]'],
          before: 'Service[snmptrapd]'
        )
      }
    end
  end
end
