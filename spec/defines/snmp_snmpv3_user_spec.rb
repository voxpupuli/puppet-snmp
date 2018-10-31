require 'spec_helper'

describe 'snmp::snmpv3_user', type: 'define' do
  context 'on a supported osfamily' do
    let :facts do
      {
        os: { 'release' => { 'full' => '6.4', 'major' => '6' }, 'name' => 'CentOS', 'family' => 'RedHat' }
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
        os: { 'release' => { 'full' => '6.4', 'major' => '6' }, 'name' => 'CentOS', 'family' => 'RedHat' }
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
          creates: '/var/lib/net-snmp/myDEFAULTuser-snmpd'
        ).that_requires(['Package[snmpd]', 'File[var-net-snmp]']).that_comes_before('Service[snmpd]')
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
          creates: '/var/lib/net-snmp/myALLuser-snmpd'
        ).that_requires(['Package[snmpd]', 'File[var-net-snmp]']).that_comes_before('Service[snmpd]')
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
          creates: '/var/lib/net-snmp/myTRAPuser-snmptrapd'
        ).that_requires(['Package[snmpd]', 'File[var-net-snmp]']).that_comes_before('Service[snmptrapd]')
      }
    end
  end

  context 'on a supported osfamily, Debian' do
    let :facts do
      {
        os: { 'release' => { 'full' => '14.01.1', 'major' => '14.04' }, 'name' => 'Ubuntu', 'family' => 'Debian' }
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
          creates: '/var/lib/snmp/myDEFAULTuser-snmpd'
        ).that_requires(['Package[snmpd]', 'File[var-net-snmp]']).that_comes_before('Service[snmpd]')
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
          creates: '/var/lib/snmp/myALLuser-snmpd'
        ).that_requires(['Package[snmpd]', 'File[var-net-snmp]']).that_comes_before('Service[snmpd]')
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
          creates: '/var/lib/snmp/myTRAPuser-snmptrapd'
        ).that_requires(['Package[snmpd]', 'File[var-net-snmp]']).that_comes_before('Service[snmpd]')
      }
    end
  end

  context 'on a supported osfamily, Suse' do
    let :facts do
      {
        os: { 'release' => { 'full' => '11.1', 'major' => '11' }, 'name' => 'SLES', 'family' => 'Suse' }
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
          creates: '/var/lib/net-snmp/myDEFAULTuser-snmpd'
        ).that_requires(['Package[snmpd]', 'File[var-net-snmp]']).that_comes_before('Service[snmpd]')
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
          creates: '/var/lib/net-snmp/myALLuser-snmpd'
        ).that_requires(['Package[snmpd]', 'File[var-net-snmp]']).that_comes_before('Service[snmpd]')
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
          creates: '/var/lib/net-snmp/myTRAPuser-snmptrapd'
        ).that_requires(['Package[snmpd]', 'File[var-net-snmp]']).that_comes_before('Service[snmptrapd]')
      }
    end
  end
end
