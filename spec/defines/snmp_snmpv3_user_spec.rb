require 'spec_helper'

describe 'snmp::snmpv3_user' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      case facts[:osfamily]
      when 'RedHat'
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
      when 'Debian'
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
      when 'Suse'
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
  end
end
