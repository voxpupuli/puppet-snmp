# @summary
#   This class handles OS-specific configuration of the snmp module.
#
class snmp::params {
  $agentaddress = [ 'udp:127.0.0.1:161', 'udp6:[::1]:161' ]
  $master = false
  $agentx_perms = undef
  $agentx_ping_interval = undef
  $agentx_socket = undef
  $agentx_timeout = 1
  $agentx_retries = 5
  $snmptrapdaddr = [ 'udp:127.0.0.1:162', 'udp6:[::1]:162' ]
  $ro_community = 'public'
  $ro_community6 = 'public'
  $rw_community = undef
  $rw_community6 = undef
  $ro_network = '127.0.0.1'
  $ro_network6 = '::1'
  $rw_network = '127.0.0.1'
  $rw_network6 = '::1'
  $contact = 'Unknown'
  $location = 'Unknown'
  $sysname = $facts['networking']['fqdn']
  $com2sec = [ 'notConfigUser  default       public', ]
  $com2sec6 = [ 'notConfigUser  default       public', ]
  $groups = [
    'notConfigGroup v1            notConfigUser',
    'notConfigGroup v2c           notConfigUser',
  ]
  $services = 72
  $openmanage_enable = false
  $views = [
    'systemview    included   .1.3.6.1.2.1.1',
    'systemview    included   .1.3.6.1.2.1.25.1.1',
  ]
  $accesses = [
    'notConfigGroup ""      any       noauth    exact  systemview none  none',
  ]
  $dlmod = []
  $extends = []
  $disable_authorization = 'no'
  $do_not_log_traps = 'no'
  $do_not_log_tcpwrappers = 'no'
  $trap_handlers = []
  $trap_forwards = []
  $snmp_config = []
  $snmpd_config = []
  $snmptrapd_config = []

  ### The following parameters should not need to be changed.

  $ensure = 'present'
  $service_ensure = 'running'
  $trap_service_ensure = 'stopped'
  $autoupgrade = false
  $manage_client = false
  $service_enable = true
  $service_hasstatus = true
  $service_hasrestart = true
  $trap_service_enable = false
  $trap_service_hasstatus = true
  $trap_service_hasrestart = true
  $snmpv2_enable = true
  $template_snmpd_conf = 'snmp/snmpd.conf.erb'
  $template_snmpd_sysconfig = "snmp/snmpd.sysconfig-${facts['os']['family']}.erb"
  $template_snmptrapd = 'snmp/snmptrapd.conf.erb'
  $template_snmptrapd_sysconfig = "snmp/snmptrapd.sysconfig-${facts['os']['family']}.erb"

  $majordistrelease = $facts['os']['release']['major']

  case $facts['os']['family'] {
    'RedHat': {
      if $majordistrelease == '6' {
        $snmpd_options        = '-LS0-6d -Lf /dev/null -p /var/run/snmpd.pid'
        $sysconfig            = '/etc/sysconfig/snmpd'
        $trap_sysconfig       = '/etc/sysconfig/snmptrapd'
        $var_net_snmp         = '/var/lib/net-snmp'
        $varnetsnmp_perms     = '0755'
        $snmptrapd_options    = '-Lsd -p /var/run/snmptrapd.pid'
        $service_config_perms = '0600'
      } else {
        $snmpd_options        = '-LS0-6d'
        $sysconfig            = '/etc/sysconfig/snmpd'
        $trap_sysconfig       = '/etc/sysconfig/snmptrapd'
        $var_net_snmp         = '/var/lib/net-snmp'
        $varnetsnmp_perms     = '0755'
        $snmptrapd_options    = '-Lsd'
        $service_config_perms = '0600'
      }
      $snmptrapd_package_name   = undef
      $package_name             = 'net-snmp'
      $service_config           = '/etc/snmp/snmpd.conf'
      $service_config_dir_group = 'root'
      $service_name             = 'snmpd'
      $varnetsnmp_owner         = 'root'
      $varnetsnmp_group         = 'root'

      $client_package_name      = 'net-snmp-utils'
      $client_config            = '/etc/snmp/snmp.conf'

      $trap_service_config      = '/etc/snmp/snmptrapd.conf'
      $trap_service_name        = 'snmptrapd'
    }
    'Debian': {
      if $facts['os']['name'] == 'Debian' and versioncmp($majordistrelease, '9') >= 0 {
        $varnetsnmp_owner = 'Debian-snmp'
        $varnetsnmp_group = 'Debian-snmp'
      } elsif $facts['os']['name'] == 'Ubuntu' and versioncmp($majordistrelease, '18.04') >= 0 {
        $varnetsnmp_owner = 'Debian-snmp'
        $varnetsnmp_group = 'Debian-snmp'
      } else {
        $varnetsnmp_owner       = 'snmp'
        $varnetsnmp_group       = 'snmp'
      }

      $sysconfig      = '/etc/default/snmpd'
      $trap_sysconfig = '/etc/default/snmptrapd'

      $package_name             = 'snmpd'
      $snmptrapd_package_name   = 'snmptrapd'
      $service_config           = '/etc/snmp/snmpd.conf'
      $service_config_perms     = '0600'
      $service_config_dir_group = 'root'
      $service_name             = 'snmpd'
      $snmpd_options            = "-Lsd -Lf /dev/null -u ${varnetsnmp_owner} -g ${varnetsnmp_group} -I -smux -p /var/run/snmpd.pid"
      $snmptrapd_options        = '-Lsd -p /var/run/snmptrapd.pid'
      $var_net_snmp             = '/var/lib/snmp'
      $varnetsnmp_perms         = '0755'

      $client_package_name      = 'snmp'
      $client_config            = '/etc/snmp/snmp.conf'

      $trap_service_config      = '/etc/snmp/snmptrapd.conf'
      $trap_service_name        = 'snmptrapd'
    }
    'Suse': {
      $package_name             = 'net-snmp'
      $snmptrapd_package_name   = undef
      $service_config           = '/etc/snmp/snmpd.conf'
      $service_config_perms     = '0600'
      $service_config_dir_group = 'root'
      $service_name             = 'snmpd'
      $snmpd_options            = 'd'
      $sysconfig                = '/etc/sysconfig/net-snmp'
      $trap_sysconfig           = undef
      $var_net_snmp             = '/var/lib/net-snmp'
      $varnetsnmp_perms         = '0755'
      $varnetsnmp_owner         = 'root'
      $varnetsnmp_group         = 'root'

      $client_package_name      = 'net-snmp'
      $client_config            = '/etc/snmp/snmp.conf'

      $trap_service_config      = '/etc/snmp/snmptrapd.conf'
      $trap_service_name        = 'snmptrapd'
      $snmptrapd_options        = undef
    }
    'FreeBSD': {
      $package_name             = 'net-mgmt/net-snmp'
      $snmptrapd_package_name   = undef
      $service_config_dir_path  = '/usr/local/etc/snmp'
      $service_config_dir_perms = '0755'
      $service_config_dir_owner = 'root'
      $service_config_dir_group = 'wheel'
      $service_config           = '/usr/local/etc/snmp/snmpd.conf'
      $service_config_perms     = '0755'
      $service_name             = 'snmpd'
      $snmpd_options            = 'd'
      $var_net_snmp             = '/var/net-snmp'
      $varnetsnmp_perms         = '0600'
      $varnetsnmp_owner         = 'root'
      $varnetsnmp_group         = 'wheel'

      $client_package_name      = 'net-mgmt/net-snmp'
      $client_config            = '/usr/local/etc/snmp/snmp.conf'

      $trap_service_config      = '/usr/local/etc/snmp/snmptrapd.conf'
      $trap_service_name        = 'snmptrapd'
      $sysconfig                = undef
      $trap_sysconfig           = undef
      $snmptrapd_options        = undef
    }
    'OpenBSD': {
      $package_name             = 'net-snmp'
      $snmptrapd_package_name   = undef
      $service_config_dir_path  = '/etc/snmp'
      $service_config_dir_perms = '0755'
      $service_config_dir_owner = 'root'
      $service_config_dir_group = 'wheel'
      $service_config           = '/etc/snmp/snmpd.conf'
      $service_config_perms     = '0755'
      $service_name             = 'netsnmpd'
      $snmpd_options            = undef
      $var_net_snmp             = '/var/net-snmp'
      $varnetsnmp_perms         = '0600'
      $varnetsnmp_owner         = '_netsnmp'
      $varnetsnmp_group         = 'wheel'

      $client_package_name      = 'net-snmp'
      $client_config            = '/etc/snmp/snmp.conf'

      $trap_service_config      = '/etc/snmp/snmptrapd.conf'
      $trap_service_name        = 'netsnmptrapd'
      $sysconfig                = undef
      $trap_sysconfig           = undef
      $snmptrapd_options        = undef
    }
    default: {
      fail("Module does not support ${facts['os']['family']}.")
    }
  }
}
