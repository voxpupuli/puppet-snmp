require 'spec_helper_acceptance'

RSpec.describe 'snmpd' do
  context 'defaults' do
    manifest = <<-EOPP
      class {'snmp': }
    EOPP
    it_behaves_like 'apply_manifest_twice', manifest
    it_behaves_like 'has_process', manifest, 'snmpd'
  end
  context 'daemon options' do
    manifest = <<-EOPP
      class {'snmp':
        snmpd_options => '-Lsd -Lf /dev/null -I -smux -a',
      }
    EOPP
    it_behaves_like 'apply_manifest_twice', manifest
    it_behaves_like 'has_process', manifest, 'snmpd', ['-Lsd','-Lf','/dev/null', '-a', '-I', '-smux']
  end
end
