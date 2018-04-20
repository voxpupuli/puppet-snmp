# == Class: snmp::params
#
# This class handles OS-specific configuration of the snmp module.  It
# looks for variables in top scope (probably from an ENC such as Dashboard).  If
# the variable doesn't exist in top scope, it falls back to a hard coded default
# value.
#
# === Authors:
#
# Mike Arnold <mike@razorsedge.org>
#
# === Copyright:
#
# Copyright (C) 2012 Mike Arnold, unless otherwise noted.
#
class snmp::params {
  # If we have a top scope variable defined, use it, otherwise fall back to a
  # hardcoded value.
  $snmp_agentaddress = getvar('::snmp_agentaddress')
  if $snmp_agentaddress {
    $agentaddress = $::snmp_agentaddress
  } else {
    $agentaddress = [ 'udp:127.0.0.1:161', 'udp6:[::1]:161' ]
  }

  $snmp_master = getvar('::snmp_master')
  if $snmp_master {
    $master = $::snmp_master
  } else {
    $master = false
  }

  $snmp_agentx_perms = getvar('::snmp_agentx_perms')
  if $snmp_agentx_perms {
    $agentx_perms = $::snmp_agentx_perms
  } else {
    $agentx_perms = undef
  }

  $snmp_agentx_ping_interval = getvar('::snmp_agentx_ping_interval')
  if $snmp_agentx_ping_interval {
    $agentx_ping_interval = $::snmp_agentx_ping_interval
  } else {
    $agentx_ping_interval = undef
  }

  $snmp_agentx_socket = getvar('::snmp_agentx_socket')
  if $snmp_agentx_socket {
    $agentx_socket = $::snmp_agentx_socket
  } else {
    $agentx_socket = undef
  }

  $snmp_agentx_timeout = getvar('::snmp_agentx_timeout')
  if $snmp_agentx_timeout {
    $agentx_timeout = $::snmp_agentx_timeout
  } else {
    $agentx_timeout = 1
  }

  $snmp_agentx_retries = getvar('::snmp_agentx_retries')
  if $snmp_agentx_retries {
    $agentx_retries = $::snmp_agentx_retries
  } else {
    $agentx_retries = 5
  }

  $snmp_snmptrapdaddr = getvar('::snmp_snmptrapdaddr')
  if $snmp_snmptrapdaddr {
    $snmptrapdaddr = $::snmp_snmptrapdaddr
  } else {
    $snmptrapdaddr =  [ 'udp:127.0.0.1:162', 'udp6:[::1]:162' ]
  }

  $snmp_ro_community = getvar('::snmp_ro_community')
  if $snmp_ro_community {
    $ro_community = $::snmp_ro_community
  } else {
    $ro_community =  'public'
  }

  $snmp_ro_community6 = getvar('::snmp_ro_community6')
  if $snmp_ro_community6 {
    $ro_community6 = $::snmp_ro_community6
  } else {
    $ro_community6 =  'public'
  }

  $snmp_rw_community = getvar('::snmp_rw_community')
  if $snmp_rw_community {
    $rw_community = $::snmp_rw_community
  } else {
    $rw_community =  undef
  }

  $snmp_rw_community6 = getvar('::snmp_rw_community6')
  if $snmp_rw_community6 {
    $rw_community6 =  $::snmp_rw_community6
  } else {
    $rw_community6 =  undef
  }

  $snmp_ro_network = getvar('::snmp_ro_network')
  if $snmp_ro_network {
    $ro_network =  $::snmp_ro_network
  } else {
    $ro_network =  '127.0.0.1'
  }

  $snmp_ro_network6 = getvar('::snmp_ro_network6')
  if $snmp_ro_network6 {
    $ro_network6 =  $::snmp_ro_network6
  } else {
    $ro_network6 =  '::1'
  }

  $snmp_rw_network = getvar('::snmp_rw_network')
  if $snmp_rw_network {
    $rw_network =  $::snmp_rw_network
  } else {
    $rw_network =  '127.0.0.1'
  }

  $snmp_rw_network6 = getvar('::snmp_rw_network6')
  if $snmp_rw_network6 {
    $rw_network6 =  $::snmp_rw_network6
  } else {
    $rw_network6 =  '::1'
  }

  $snmp_contact = getvar('::snmp_contact')
  if $snmp_contact {
    $contact =  $::snmp_contact
  } else {
    $contact =  'Unknown'
  }

  $snmp_location = getvar('::snmp_location')
  if $snmp_location {
    $location =  $::snmp_location
  } else {
    $location =  'Unknown'
  }

  $snmp_sysname = getvar('::snmp_sysname')
  if $snmp_sysname {
    $sysname =  $::snmp_sysname
  } else {
    $sysname =  $::fqdn
  }

  $snmp_com2sec = getvar('::snmp_com2sec')
  if $snmp_com2sec {
    $com2sec =  $::snmp_com2sec
  } else {
    $com2sec =  [ 'notConfigUser  default       public', ]
  }

  $snmp_com2sec6 = getvar('::snmp_com2sec6')
  if $snmp_com2sec6 {
    $com2sec6 =  $::snmp_com2sec6
  } else {
    $com2sec6 =  [ 'notConfigUser  default       public', ]
  }

  $snmp_groups = getvar('::snmp_groups')
  if $snmp_groups {
    $groups =  $::snmp_groups
  } else {
    $groups =  [
      'notConfigGroup v1            notConfigUser',
      'notConfigGroup v2c           notConfigUser',
    ]
  }

  $snmp_services = getvar('::snmp_services')
  if $snmp_services {
    $services =  $::snmp_services
  } else {
    $services =  72
  }

  $snmp_openmanage_enable = getvar('::openmanage_enable')
  if $snmp_openmanage_enable {
    $openmanage_enable =  $snmp_openmanage_enable
  } else {
    $openmanage_enable =  false
  }

  $snmp_views = getvar('::snmp_views')
  if $snmp_views {
    $views =  $::snmp_views
  } else {
    $views =  [
      'systemview    included   .1.3.6.1.2.1.1',
      'systemview    included   .1.3.6.1.2.1.25.1.1',
    ]
  }

  $snmp_accesses = getvar('::snmp_accesses')
  if $snmp_accesses {
    $accesses =  $::snmp_accesses
  } else {
    $accesses =  [
      'notConfigGroup ""      any       noauth    exact  systemview none  none',
    ]
  }

  $snmp_dlmod = getvar('::snmp_dlmod')
  if $snmp_dlmod {
    $dlmod =  $::snmp_dlmod
  } else {
    $dlmod =  []
  }

  $snmp_extends = getvar('::snmp_extends')
  if $snmp_extends {
    $extemds =  $::snmp_extends
  } else {
    $extends =  []
  }

  $snmp_extends_sh = getvar('::snmp_extends_sh')
  if $snmp_extends_sh {
    $extends_sh =  $::snmp_extends_sh
  } else {
    $extends_sh =  []
  }

  $snmp_disable_authorization = getvar('::snmp_disable_authorization')
  if $snmp_disable_authorization {
    $disable_authorization =  $::snmp_disable_authorization
  } else {
    $disable_authorization =  'no'
  }

  $snmp_do_not_log_traps = getvar('::snmp_do_not_log_traps')
  if $snmp_do_not_log_traps {
    $do_not_log_traps =  $::snmp_do_not_log_traps
  } else {
    $do_not_log_traps =  'no'
  }

  $snmp_do_not_log_tcpwrappers = getvar('::snmp_do_not_log_tcpwrappers')
  if $snmp_do_not_log_tcpwrappers {
    $do_not_log_tcpwrappers =  $::snmp_do_not_log_tcpwrappers
  } else {
    $do_not_log_tcpwrappers =  'no'
  }

  $snmp_trap_handlers = getvar('::snmp_trap_handlers')
  if $snmp_trap_handlers {
    $trap_handlers =  $::snmp_trap_handlers
  } else {
    $trap_handlers =  []
  }

  $snmp_trap_forwards = getvar('::snmp_trap_forwards')
  if $snmp_trap_forwards {
    $trap_forwards =  $::snmp_trap_forwards
  } else {
    $trap_forwards =  []
  }

  $snmp_snmp_config = getvar('::snmp_snmp_config')
  if $snmp_snmp_config {
    $snmp_config =  $::snmp_snmp_config
  } else {
    $snmp_config =  []
  }

  $snmp_snmpd_config = getvar('::snmp_snmpd_config')
  if $snmp_snmpd_config {
    $snmpd_config =  $::snmp_snmpd_config
  } else {
    $snmpd_config =  []
  }

  $snmp_snmptrapd_config = getvar('::snmp_snmptrapd_config')
  if $snmp_snmptrapd_config {
    $snmptrapd_config =  $::snmp_snmptrapd_config
  } else {
    $snmptrapd_config =  []
  }

### The following parameters should not need to be changed.

  $snmp_ensure = getvar('::snmp_ensure')
  if $snmp_ensure {
    $ensure =  $::snmp_ensure
  } else {
    $ensure =  'present'
  }

  $snmp_service_ensure = getvar('::snmp_service_ensure')
  if $snmp_service_ensure {
    $service_ensure =  $::snmp_service_ensure
  } else {
    $service_ensure =  'running'
  }

  $snmp_trap_service_ensure = getvar('::snmp_trap_service_ensure')
  if $snmp_trap_service_ensure {
    $trap_service_ensure =  $::snmp_trap_service_ensure
  } else {
    $trap_service_ensure =  'stopped'
  }

  # Since the top scope variable could be a string (if from an ENC), we might
  # need to convert it to a boolean.
  $snmp_autoupgrade = getvar('::snmp_autoupgrade')
  if $snmp_autoupgrade {
    $autoupgrade =  $::snmp_autoupgrade
  } else {
    $autoupgrade =  false
  }
  if is_string($autoupgrade) {
    $safe_autoupgrade = str2bool($autoupgrade)
  } else {
    $safe_autoupgrade = $autoupgrade
  }

  $snmp_install_client = getvar('::snmp_install_client')
  if $snmp_install_client {
    $install_client =  $::snmp_install_client
  } else {
    $install_client =  undef
  }

  $snmp_manage_client = getvar('::snmp_manage_client')
  if $snmp_manage_client {
    $manage_client =  $::snmp_manage_client
  } else {
    $manage_client =  false
  }
  if is_string($manage_client) {
    $safe_manage_client = str2bool($manage_client)
  } else {
    $safe_manage_client = $manage_client
  }

  $snmp_service_enable = getvar('::snmp_service_enable')
  if $snmp_service_enable {
    $service_enable =  $::snmp_service_enable
  } else {
    $service_enable =  true
  }
  if is_string($service_enable) {
    $safe_service_enable = str2bool($service_enable)
  } else {
    $safe_service_enable = $service_enable
  }

  $snmp_service_hasstatus = getvar('::snmp_service_hasstatus')
  if $snmp_service_hasstatus {
    $service_hasstatus =  $::snmp_service_hasstatus
  } else {
    $service_hasstatus =  true
  }
  if is_string($service_hasstatus) {
    $safe_service_hasstatus = str2bool($service_hasstatus)
  } else {
    $safe_service_hasstatus = $service_hasstatus
  }

  $snmp_service_hasrestart = getvar('::snmp_service_hasrestart')
  if $snmp_service_hasrestart {
    $service_hasrestart =  $::snmp_service_hasrestart
  } else {
    $service_hasrestart =  true
  }
  if is_string($service_hasrestart) {
    $safe_service_hasrestart = str2bool($service_hasrestart)
  } else {
    $safe_service_hasrestart = $service_hasrestart
  }

  $snmp_trap_service_enable = getvar('::snmp_trap_service_enable')
  if $snmp_trap_service_enable {
    $trap_service_enable =  $::snmp_trap_service_enable
  } else {
    $trap_service_enable =  false
  }
  if is_string($trap_service_enable) {
    $safe_trap_service_enable = str2bool($trap_service_enable)
  } else {
    $safe_trap_service_enable = $trap_service_enable
  }

  $snmp_trap_service_hasstatus = getvar('::snmp_trap_service_hasstatus')
  if $snmp_trap_service_hasstatus {
    $trap_service_hasstatus =  $::snmp_trap_service_hasstatus
  } else {
    $trap_service_hasstatus =  true
  }
  if is_string($trap_service_hasstatus) {
    $safe_trap_service_hasstatus = str2bool($trap_service_hasstatus)
  } else {
    $safe_trap_service_hasstatus = $trap_service_hasstatus
  }

  $snmp_trap_service_hasrestart = getvar('::snmp_trap_service_hasrestart')
  if $snmp_trap_service_hasrestart {
    $trap_service_hasrestart =  $::snmp_trap_service_hasrestart
  } else {
    $trap_service_hasrestart =  true
  }
  if is_string($trap_service_hasrestart) {
    $safe_trap_service_hasrestart = str2bool($trap_service_hasrestart)
  } else {
    $safe_trap_service_hasrestart = $trap_service_hasrestart
  }

  $template_snmpd_conf = 'snmp/snmpd.conf.erb'
  $template_snmpd_sysconfig = "snmp/snmpd.sysconfig-${::osfamily}.erb"
  $template_snmptrapd = 'snmp/snmptrapd.conf.erb'
  $template_snmptrapd_sysconfig = "snmp/snmptrapd.sysconfig-${::osfamily}.erb"

  case $::osfamily {
    'RedHat': {
      if $::operatingsystemmajrelease { # facter 1.7+
        $majdistrelease = $::operatingsystemmajrelease
      } elsif $::lsbmajdistrelease {    # requires LSB to already be installed
        $majdistrelease = $::lsbmajdistrelease
      } else {
        $majdistrelease = regsubst($::operatingsystemrelease,'^(\d+)\.(\d+)','\1')
      }
      case $::operatingsystem {
        'Fedora': {
          $snmpd_options        = '-LS0-6d'
          $snmptrapd_options    = '-Lsd'
          $sysconfig            = '/etc/sysconfig/snmpd'
          $trap_sysconfig       = '/etc/sysconfig/snmptrapd'
          $var_net_snmp         = '/var/lib/net-snmp'
          $varnetsnmp_perms     = '0755'
          $service_config_perms = '0600'
        }
        default: {
          if versioncmp($majdistrelease, '5') <= 0 {
            $snmpd_options        = '-Lsd -Lf /dev/null -p /var/run/snmpd.pid -a'
            $sysconfig            = '/etc/sysconfig/snmpd.options'
            $trap_sysconfig       = '/etc/sysconfig/snmptrapd.options'
            $var_net_snmp         = '/var/net-snmp'
            $varnetsnmp_perms     = '0700'
            $snmptrapd_options    = '-Lsd -p /var/run/snmptrapd.pid'
            $service_config_perms = '0644'
          } elsif $majdistrelease == '6' {
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
        }
      }
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
      if $::operatingsystem == 'Debian' and $::operatingsystemmajrelease >= '9' {
        $varnetsnmp_owner = 'Debian-snmp'
        $varnetsnmp_group = 'Debian-snmp'
      } else {
        $varnetsnmp_owner       = 'snmp'
        $varnetsnmp_group       = 'snmp'
      }
      $package_name             = 'snmpd'
      $service_config           = '/etc/snmp/snmpd.conf'
      $service_config_perms     = '0600'
      $service_config_dir_group = 'root'
      $service_name             = 'snmpd'
      $snmpd_options            = "-Lsd -Lf /dev/null -u ${varnetsnmp_owner} -g ${varnetsnmp_group} -I -smux -p /var/run/snmpd.pid"
      $sysconfig                = '/etc/default/snmpd'
      $var_net_snmp             = '/var/lib/snmp'
      $varnetsnmp_perms         = '0755'

      $client_package_name      = 'snmp'
      $client_config            = '/etc/snmp/snmp.conf'

      $trap_service_config      = '/etc/snmp/snmptrapd.conf'
      $trap_service_name        = undef
      $snmptrapd_options        = '-Lsd -p /var/run/snmptrapd.pid'
    }
    'Suse': {
      $package_name             = 'net-snmp'
      $service_config           = '/etc/snmp/snmpd.conf'
      $service_config_perms     = '0600'
      $service_config_dir_group = 'root'
      $service_name             = 'snmpd'
      $snmpd_options            = 'd'
      $sysconfig                = '/etc/sysconfig/net-snmp'
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
      $snmptrapd_options        = undef
    }
    'OpenBSD': {
      $package_name             = 'net-snmp'
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
      $snmptrapd_options        = undef
    }
    default: {
      fail("Module ${::module} is not supported on ${::operatingsystem}")
    }
  }
}
