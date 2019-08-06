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
              command: 'service snmpd stop ; sleep 5 ; echo "createUser myDEFAULTuser SHA \"myauthpass\"" >>/var/lib/net-snmp/snmpd.conf'
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
              command: 'service snmpd stop ; sleep 5 ; echo "createUser myALLuser MD5 \"myauthpass\" DES \"myprivpass\"" >>/var/lib/net-snmp/snmpd.conf'
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
              command: 'service snmptrapd stop ; sleep 5 ; echo "createUser myTRAPuser SHA \"myauthpass\"" >>/var/lib/net-snmp/snmptrapd.conf'
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
              command: 'service snmpd stop ; sleep 5 ; echo "createUser myDEFAULTuser SHA \"myauthpass\"" >>/var/lib/snmp/snmpd.conf'
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
              command: 'service snmpd stop ; sleep 5 ; echo "createUser myALLuser MD5 \"myauthpass\" DES \"myprivpass\"" >>/var/lib/snmp/snmpd.conf'
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
              command: 'service snmpd stop ; sleep 5 ; echo "createUser myTRAPuser SHA \"myauthpass\"" >>/var/lib/snmp/snmptrapd.conf'
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
              command: 'service snmpd stop ; sleep 5 ; echo "createUser myDEFAULTuser SHA \"myauthpass\"" >>/var/lib/net-snmp/snmpd.conf'
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
              command: 'service snmpd stop ; sleep 5 ; echo "createUser myALLuser MD5 \"myauthpass\" DES \"myprivpass\"" >>/var/lib/net-snmp/snmpd.conf'
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
              command: 'service snmptrapd stop ; sleep 5 ; echo "createUser myTRAPuser SHA \"myauthpass\"" >>/var/lib/net-snmp/snmptrapd.conf'
            ).that_requires(['Package[snmpd]', 'File[var-net-snmp]']).that_comes_before('Service[snmptrapd]')
          }
        end
      end

      describe 'with correct authpass and privpass for md5user' do
        let(:title) { 'md5user' }

        let :params do
          {
            authpass: 'maplesyrup',
            authtype: 'MD5',
            privpass: 'maplesyrup',
            privtype: 'AES'
          }
        end

        it {
          is_expected.not_to contain_exec('create-snmpv3-user-md5user')
        }
      end

      describe 'with correct authpass and wrong privpass for md5user' do
        let(:title) { 'md5user' }

        let :params do
          {
            authpass: 'maplesyrup',
            authtype: 'MD5',
            privpass: 'cornsyrup',
            privtype: 'AES'
          }
        end

        it {
          is_expected.to contain_exec('create-snmpv3-user-md5user')
        }
      end

      describe 'with wrong authpass and correct privpass for md5user' do
        let(:title) { 'md5user' }

        let :params do
          {
            authpass: 'cornsyrup',
            authtype: 'MD5',
            privpass: 'maplesyrup',
            privtype: 'AES'
          }
        end

        it {
          is_expected.to contain_exec('create-snmpv3-user-md5user')
        }
      end

      describe 'with wrong authpass and wrong privpass for md5user' do
        let(:title) { 'md5user' }

        let :params do
          {
            authpass: 'cornsyrup',
            authtype: 'MD5',
            privpass: 'cornsyrup',
            privtype: 'AES'
          }
        end

        it {
          is_expected.to contain_exec('create-snmpv3-user-md5user')
        }
      end

      describe 'with correct authpass and privpass for shauser' do
        let(:title) { 'shauser' }

        let :params do
          {
            authpass: 'maplesyrup',
            authtype: 'SHA',
            privpass: 'maplesyrup',
            privtype: 'AES'
          }
        end

        it {
          is_expected.not_to contain_exec('create-snmpv3-user-shauser')
        }
      end

      describe 'with correct authpass and wrong privpass for shauser' do
        let(:title) { 'shauser' }

        let :params do
          {
            authpass: 'maplesyrup',
            authtype: 'SHA',
            privpass: 'cornsyrup',
            privtype: 'AES'
          }
        end

        it {
          is_expected.to contain_exec('create-snmpv3-user-shauser')
        }
      end

      describe 'with wrong authpass and correct privpass for shauser' do
        let(:title) { 'shauser' }

        let :params do
          {
            authpass: 'cornsyrup',
            authtype: 'SHA',
            privpass: 'maplesyrup',
            privtype: 'AES'
          }
        end

        it {
          is_expected.to contain_exec('create-snmpv3-user-shauser')
        }
      end

      describe 'with wrong authpass and wrong privpass for shauser' do
        let(:title) { 'shauser' }

        let :params do
          {
            authpass: 'cornsyrup',
            authtype: 'SHA',
            privpass: 'cornsyrup',
            privtype: 'AES'
          }
        end

        it {
          is_expected.to contain_exec('create-snmpv3-user-shauser')
        }
      end

      describe 'with correct authpass and empty privpass for nonuser' do
        let(:title) { 'nonuser' }

        let :params do
          {
            authpass: 'maplesyrup',
            authtype: 'SHA'
          }
        end

        it {
          is_expected.not_to contain_exec('create-snmpv3-user-nonuser')
        }
      end

      describe 'with wrong authpass and empty privpass for nonuser' do
        let(:title) { 'nonuser' }

        let :params do
          {
            authpass: 'cornsyrup',
            authtype: 'SHA'
          }
        end

        it {
          is_expected.to contain_exec('create-snmpv3-user-nonuser')
        }
      end

      describe 'with correct authpass and defined privpass for nonuser' do
        let(:title) { 'nonuser' }

        let :params do
          {
            authpass: 'cornsyrup',
            authtype: 'SHA',
            privpass: 'cornsyrup',
            privtype: 'AES'
          }
        end

        it {
          is_expected.to contain_exec('create-snmpv3-user-nonuser')
        }
      end
    end
  end
end
