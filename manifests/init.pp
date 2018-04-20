# == Class: snmp
#
# This class handles installing the Net-SNMP server and trap server.
#
# === Parameters:
#
# [*agentaddress*]
#   An array of addresses, on which snmpd will listen for queries.
#   Default: [ udp:127.0.0.1:161, udp6:[::1]:161 ]
#
# [*snmptrapdaddr*]
#   An array of addresses, on which snmptrapd will listen to receive incoming
#   SNMP notifications.
#   Default: [ udp:127.0.0.1:162, udp6:[::1]:162 ]
#
# [*ro_community*]
#   Read-only (RO) community string or array for agent and snmptrap daemon.
#   Default: public
#
# [*ro_community6*]
#   Read-only (RO) community string or array for IPv6 agent.
#   Default: public
#
# [*rw_community*]
#   Read-write (RW) community string or array agent.
#   Default: none
#
# [*rw_community6*]
#   Read-write (RW) community string or array for IPv6 agent.
#   Default: none
#
# [*ro_network*]
#   Network that is allowed to RO query the daemon.  Can be string or array.
#   Default: 127.0.0.1
#
# [*ro_network6*]
#   Network that is allowed to RO query the daemon via IPv6.  Can be string or array.
#   Default: ::1/128
#
# [*rw_network*]
#   Network that is allowed to RW query the daemon.  Can be string or array.
#   Default: 127.0.0.1
#
# [*rw_network6*]
#   Network that is allowed to RW query the daemon via IPv6.  Can be string or array.
#   Default: ::1/128
#
# [*contact*]
#   Responsible person for the SNMP system.
#   Default: Unknown
#
# [*location*]
#   Location of the SNMP system.
#   Default: Unknown
#
# [*sysname*]
#   Name of the system (hostname).
#   Default: ${::fqdn}
#
# [*services*]
#   For a host system, a good value is 72 (application + end-to-end layers).
#   Default: 72
#
# [*com2sec*]
#   An array of VACM com2sec mappings.
#   Must provide SECNAME, SOURCE and COMMUNITY.
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.
#   Default: [ "notConfigUser default public" ]
#
# [*com2sec6*]
#   An array of VACM com2sec6 mappings.
#   Must provide SECNAME, SOURCE and COMMUNITY.
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.
#   Default: [ "notConfigUser default ${ro_community}" ]
#
# [*groups*]
#   An array of VACM group mappings.
#   Must provide GROUP, {v1|v2c|usm|tsm|ksm}, SECNAME.
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.
#   Default: [ 'notConfigGroup v1  notConfigUser',
#              'notConfigGroup v2c notConfigUser' ]
#
# [*views*]
#   An array of views that are available to query.
#   Must provide VNAME, TYPE, OID, and [MASK].
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.
#   Default: [ 'systemview included .1.3.6.1.2.1.1',
#              'systemview included .1.3.6.1.2.1.25.1.1' ]
#
# [*accesses*]
#   An array of access controls that are available to query.
#   Must provide GROUP, CONTEXT, {any|v1|v2c|usm|tsm|ksm}, LEVEL, PREFX, READ,
#   WRITE, and NOTIFY.
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.
#   Default: [ 'notConfigGroup "" any noauth exact systemview none none' ]
#
# [*dlmod*]
#   Array of dlmod lines to add to the snmpd.conf file.
#   Must provide NAME and PATH (ex. "cmaX /usr/lib64/libcmaX64.so").
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbBD for details.
#   Default: []
#
# [*extends*]
#   Array of extend lines to add to the snmpd.conf file.
#   Must provide NAME, PROG and ARG.
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbBA for details.
#   Default: []
#
# [*snmpd_config*]
#   Safety valve.  Array of lines to add to the snmpd.conf file.
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html for all options.
#   Default: []
#
#
# [*disable_authorization*]
#   Disable all access control checks. (yes|no)
#   Default: no
#
# [*do_not_log_traps*]
#   Disable the logging of notifications altogether. (yes|no)
#   Default: no
#
# [*do_not_log_tcpwrappers*]
#   Disable the logging of tcpwrappers messages, e.g. "Connection from UDP: "
#   messages in syslog. (yes|no)
#   Default: no
#
# [*trap_handlers*]
#   An array of programs to invoke on receipt of traps.
#   Must provide OID and PROGRAM (ex. "IF-MIB::linkDown /bin/traps down").
#   See http://www.net-snmp.org/docs/man/snmptrapd.conf.html#lbAI for details.
#   Default: []
#
# [*trap_forwards*]
#   An array of destinations to send to on receipt of traps.
#   Must provide OID and DESTINATION (ex. "IF-MIB::linkUp udp:1.2.3.5:162").
#   See http://www.net-snmp.org/docs/man/snmptrapd.conf.html#lbAI for details.
#   Default: []
#
# [*snmptrapd_config*]
#   Safety valve.  Array of lines to add to the snmptrapd.conf file.
#   See http://www.net-snmp.org/docs/man/snmptrapd.conf.html for all options.
#   Default: []
#
#
# [*manage_client*]
#   Whether to install the Net-SNMP client package. (true|false)
#   Default: false
#
# [*snmp_config*]
#   Safety valve.  Array of lines to add to the client's global snmp.conf file.
#   See http://www.net-snmp.org/docs/man/snmp.conf.html for all options.
#   Default: []
#
# [*ensure*]
#   Ensure if present or absent.
#   Default: present
#
# [*autoupgrade*]
#   Upgrade package automatically, if there is a newer version.
#   Default: false
#
# [*package_name*]
#   Name of the package.
#   Only set this if your platform is not supported or you know what you are
#   doing.
#   Default: auto-set, platform specific
#
# [*snmpd_options*]
#   Commandline options passed to snmpd via init script.
#   Default: auto-set, platform specific
#
# [*service_config_perms*]
#   Set permissions for the service configuration file.
#   Default: auto-set, platform specific
#
# [*service_config_dir_group*]
#   Set group ownership for the service configuration file.
#   Default: auto-set, platform specific
#
# [*service_ensure*]
#   Ensure if service is running or stopped.
#   Default: running
#
# [*service_name*]
#   Name of SNMP service
#   Only set this if your platform is not supported or you know what you are
#   doing.
#   Default: auto-set, platform specific
#
# [*service_enable*]
#   Start service at boot.
#   Default: true
#
# [*service_hasstatus*]
#   Service has status command.
#   Default: true
#
# [*service_hasrestart*]
#   Service has restart command.
#   Default: true
#
# [*snmptrapd_options*]
#   Commandline options passed to snmptrapd via init script.
#   Default: auto-set, platform specific
#
# [*trap_service_ensure*]
#   Ensure if service is running or stopped.
#   Default: stopped
#
# [*trap_service_name*]
#   Name of SNMP service
#   Only set this if your platform is not supported or you know what you are
#   doing.
#   Default: auto-set, platform specific
#
# [*trap_service_enable*]
#   Start service at boot.
#   Default: true
#
# [*trap_service_hasstatus*]
#   Service has status command.
#   Default: true
#
# [*trap_service_hasrestart*]
#   Service has restart command.
#   Default: true
#
# [*openmanage_enable*]
#   Adds the smuxpeer directive to the snmpd.conf file to allow net-snmp to
#   talk with Dell's OpenManage
#   Default: false
#
# [*master*]
#   Include the *master* option to enable AgentX registrations.
#   Default: false
#
# [*agentx_perms*]
#   Defines the permissions and ownership of the AgentX Unix Domain socket.
#   Default: none
#
# [*agentx_ping_interval*]
#   This will make the subagent try and reconnect every NUM seconds to the
#   master if it ever becomes (or starts) disconnected.
#   Default: none
#
# [*agentx_socket*]
#   Defines the address the master agent listens at, or the subagent should
#   connect to.
#   Default: none
#
# [*agentx_timeout*]
#   Defines the timeout period (NUM seconds) for an AgentX request.
#   Default: 1
#
# [*agentx_retries*]
#   Defines the number of retries for an AgentX request.
#   Default: 5
#
# === Actions:
#
# Installs the Net-SNMP daemon package, service, and configuration.
# Installs the Net-SNMP trap daemon service and configuration.
#
# === Requires:
#
# Nothing.
#
# === Sample Usage:
#
#   # Configure and run the snmp daemon and install the client:
#   class { 'snmp':
#     com2sec       => [ 'notConfigUser default PassW0rd' ],
#     manage_client => true,
#   }
#
#   # Only configure and run the snmptrap daemon:
#   class { 'snmp':
#     ro_community        => 'SeCrEt',
#     service_ensure      => 'stopped',
#     trap_service_ensure => 'running',
#     trap_handlers       => [
#       'default /usr/bin/perl /usr/bin/traptoemail me@somewhere.local',
#       'IF-MIB::linkDown /home/nba/bin/traps down',
#     ],
#   }
#
# === Authors:
#
# Mike Arnold <mike@razorsedge.org>
#
# === Copyright:
#
# Copyright (C) 2012 Mike Arnold, unless otherwise noted.
#
class snmp (
  $agentaddress                 = $snmp::params::agentaddress,
  $snmptrapdaddr                = $snmp::params::snmptrapdaddr,
  $ro_community                 = $snmp::params::ro_community,
  $ro_community6                = $snmp::params::ro_community6,
  $rw_community                 = $snmp::params::rw_community,
  $rw_community6                = $snmp::params::rw_community6,
  $ro_network                   = $snmp::params::ro_network,
  $ro_network6                  = $snmp::params::ro_network6,
  $rw_network                   = $snmp::params::rw_network,
  $rw_network6                  = $snmp::params::rw_network6,
  $contact                      = $snmp::params::contact,
  $location                     = $snmp::params::location,
  $sysname                      = $snmp::params::sysname,
  $services                     = $snmp::params::services,
  $com2sec                      = $snmp::params::com2sec,
  $com2sec6                     = $snmp::params::com2sec6,
  $groups                       = $snmp::params::groups,
  $views                        = $snmp::params::views,
  $accesses                     = $snmp::params::accesses,
  $dlmod                        = $snmp::params::dlmod,
  $extends                      = $snmp::params::extends,
  $extends_sh                   = $snmp::params::extends_sh,
  $snmpd_config                 = $snmp::params::snmpd_config,
  $disable_authorization        = $snmp::params::disable_authorization,
  $do_not_log_traps             = $snmp::params::do_not_log_traps,
  $do_not_log_tcpwrappers       = $snmp::params::do_not_log_tcpwrappers,
  $trap_handlers                = $snmp::params::trap_handlers,
  $trap_forwards                = $snmp::params::trap_forwards,
  $snmptrapd_config             = $snmp::params::snmptrapd_config,
  $install_client               = $snmp::params::install_client,
  $manage_client                = $snmp::params::safe_manage_client,
  $snmp_config                  = $snmp::params::snmp_config,
  $ensure                       = $snmp::params::ensure,
  $autoupgrade                  = $snmp::params::safe_autoupgrade,
  $package_name                 = $snmp::params::package_name,
  $snmpd_options                = $snmp::params::snmpd_options,
  $service_config_perms         = $snmp::params::service_config_perms,
  $service_config_dir_group     = $snmp::params::service_config_dir_group,
  $service_ensure               = $snmp::params::service_ensure,
  $service_name                 = $snmp::params::service_name,
  $service_enable               = $snmp::params::service_enable,
  $service_hasstatus            = $snmp::params::service_hasstatus,
  $service_hasrestart           = $snmp::params::service_hasrestart,
  $snmptrapd_options            = $snmp::params::snmptrapd_options,
  $trap_service_ensure          = $snmp::params::trap_service_ensure,
  $trap_service_name            = $snmp::params::trap_service_name,
  $trap_service_enable          = $snmp::params::trap_service_enable,
  $trap_service_hasstatus       = $snmp::params::trap_service_hasstatus,
  $trap_service_hasrestart      = $snmp::params::trap_service_hasrestart,
  $template_snmpd_conf          = $snmp::params::template_snmpd_conf,
  $template_snmpd_sysconfig     = $snmp::params::template_snmpd_sysconfig,
  $template_snmptrapd           = $snmp::params::template_snmptrapd,
  $template_snmptrapd_sysconfig = $snmp::params::template_snmptrapd_sysconfig,
  $openmanage_enable            = $snmp::params::openmanage_enable,
  $master                       = $snmp::params::master,
  $agentx_perms                 = $snmp::params::agentx_perms,
  $agentx_ping_interval         = $snmp::params::agentx_ping_interval,
  $agentx_socket                = $snmp::params::agentx_socket,
  $agentx_timeout               = $snmp::params::agentx_timeout,
  $agentx_retries               = $snmp::params::agentx_retries,
) inherits snmp::params {
  # Validate our booleans
  validate_bool($master)
  validate_bool($manage_client)
  validate_bool($autoupgrade)
  validate_bool($service_enable)
  validate_bool($service_hasstatus)
  validate_bool($service_hasrestart)
  validate_bool($openmanage_enable)

  # Validate our arrays
  validate_array($snmptrapdaddr)
  validate_array($trap_handlers)
  validate_array($trap_forwards)
  validate_array($snmp_config)
  validate_array($com2sec)
  validate_array($com2sec6)
  validate_array($groups)
  validate_array($views)
  validate_array($accesses)
  validate_array($dlmod)
  validate_array($extends)
  validate_array($extends_sh)
  validate_array($snmpd_config)
  validate_array($snmptrapd_config)

  # Validate our strings
  validate_string($template_snmpd_conf)
  validate_string($template_snmpd_sysconfig)
  validate_string($template_snmptrapd)
  validate_string($template_snmptrapd_sysconfig)

  # Validate our numbers
  validate_numeric($agentx_retries)
  validate_numeric($agentx_timeout)

  # Validate our regular expressions
  $states = [ '^yes$', '^no$' ]
  validate_re($disable_authorization, $states, '$disable_authorization must be either yes or no.')
  validate_re($do_not_log_traps, $states, '$do_not_log_traps must be either yes or no.')
  validate_re($do_not_log_tcpwrappers, $states, '$do_not_log_tcpwrappers must be either yes or no.')

  # Deprecated backwards-compatibility
  if $install_client != undef {
    validate_bool($install_client)
    warning('snmp: parameter install_client is deprecated; please use manage_client')
    $real_manage_client = $install_client
  } else {
    $real_manage_client = $manage_client
  }

  case $ensure {
    /(present)/: {
      if $autoupgrade == true {
        $package_ensure = 'latest'
      } else {
        $package_ensure = 'present'
      }
      $file_ensure = 'present'
      if $trap_service_ensure in [ running, stopped ] {
        $trap_service_ensure_real = $trap_service_ensure
        $trap_service_enable_real = $trap_service_enable
      } else {
        fail('trap_service_ensure parameter must be running or stopped')
      }
      if $service_ensure in [ running, stopped ] {
        # Make sure that if $trap_service_ensure == 'running' that
        # $service_ensure_real == 'running' on Debian.
        if ($::osfamily == 'Debian') and ($trap_service_ensure_real == 'running') {
          $service_ensure_real = $trap_service_ensure_real
          $service_enable_real = $trap_service_enable_real
        } else {
          $service_ensure_real = $service_ensure
          $service_enable_real = $service_enable
        }
      } else {
        fail('service_ensure parameter must be running or stopped')
      }
    }
    /(absent)/: {
      $package_ensure = 'absent'
      $file_ensure = 'absent'
      $service_ensure_real = 'stopped'
      $service_enable_real = false
      $trap_service_ensure_real = 'stopped'
      $trap_service_enable_real = false
    }
    default: {
      fail('ensure parameter must be present or absent')
    }
  }

  if $service_ensure == 'running' {
    $snmpdrun = 'yes'
  } else {
    $snmpdrun = 'no'
  }
  if $trap_service_ensure == 'running' {
    $trapdrun = 'yes'
  } else {
    $trapdrun = 'no'
  }

  if $::osfamily != 'Debian' {
    $snmptrapd_conf_notify = Service['snmptrapd']
  } else {
    $snmptrapd_conf_notify = Service['snmpd']
  }

  if $real_manage_client {
    class { 'snmp::client':
      ensure      => $ensure,
      autoupgrade => $autoupgrade,
      snmp_config => $snmp_config,
    }
  }

  package { 'snmpd':
    ensure => $package_ensure,
    name   => $package_name,
  }

  file { 'var-net-snmp':
    ensure  => 'directory',
    mode    => $snmp::params::varnetsnmp_perms,
    owner   => $snmp::params::varnetsnmp_owner,
    group   => $snmp::params::varnetsnmp_group,
    path    => $snmp::params::var_net_snmp,
    require => Package['snmpd'],
  }

  if $::osfamily == 'FreeBSD' {
    file { $snmp::params::service_config_dir_path:
      ensure  => 'directory',
      mode    => $snmp::params::service_config_dir_perms,
      owner   => $snmp::params::service_config_dir_owner,
      group   => $snmp::params::service_config_dir_group,
      require => Package['snmpd'],
    }
  }

  file { 'snmpd.conf':
    ensure  => $file_ensure,
    mode    => $service_config_perms,
    owner   => 'root',
    group   => $service_config_dir_group,
    path    => $snmp::params::service_config,
    content => template($template_snmpd_conf),
    require => Package['snmpd'],
    notify  => Service['snmpd'],
  }

  if $::osfamily != 'FreeBSD' and $::osfamily != 'OpenBSD' {
    file { 'snmpd.sysconfig':
      ensure  => $file_ensure,
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      path    => $snmp::params::sysconfig,
      content => template($template_snmpd_sysconfig),
      require => Package['snmpd'],
      notify  => Service['snmpd'],
    }
  }

  file { 'snmptrapd.conf':
    ensure  => $file_ensure,
    mode    => $service_config_perms,
    owner   => 'root',
    group   => $service_config_dir_group,
    path    => $snmp::params::trap_service_config,
    content => template($template_snmptrapd),
    require => Package['snmpd'],
    notify  => $snmptrapd_conf_notify,
  }

  if $::osfamily == 'RedHat' {
    file { 'snmptrapd.sysconfig':
      ensure  => $file_ensure,
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      path    => $snmp::params::trap_sysconfig,
      content => template($template_snmptrapd_sysconfig),
      require => Package['snmpd'],
      notify  => Service['snmptrapd'],
    }

    service { 'snmptrapd':
      ensure     => $trap_service_ensure_real,
      name       => $trap_service_name,
      enable     => $trap_service_enable_real,
      hasstatus  => $trap_service_hasstatus,
      hasrestart => $trap_service_hasrestart,
      require    => [ Package['snmpd'], File['var-net-snmp'], ],
    }
  } elsif $::osfamily == 'Suse' {
    exec { 'install /etc/init.d/snmptrapd':
      command => '/usr/bin/install -o 0 -g 0 -m0755 -p /usr/share/doc/packages/net-snmp/rc.snmptrapd /etc/init.d/snmptrapd',
      creates => '/etc/init.d/snmptrapd',
      require => Package['snmpd'],
    }

    service { 'snmptrapd':
      ensure     => $trap_service_ensure_real,
      name       => $trap_service_name,
      enable     => $trap_service_enable_real,
      hasstatus  => $trap_service_hasstatus,
      hasrestart => $trap_service_hasrestart,
      require    => [
        Package['snmpd'],
        File['var-net-snmp'],
        Exec['install /etc/init.d/snmptrapd'],
      ],
    }
  } elsif $::osfamily == 'FreeBSD'  or $::osfamily == 'OpenBSD' {
    service { 'snmptrapd':
      ensure     => $trap_service_ensure_real,
      name       => $trap_service_name,
      enable     => $trap_service_enable_real,
      hasstatus  => $trap_service_hasstatus,
      hasrestart => $trap_service_hasrestart,
      require    => [
        Package['snmpd'],
        File['var-net-snmp'],
      ],
    }
  }

  service { 'snmpd':
    ensure     => $service_ensure_real,
    name       => $service_name,
    enable     => $service_enable_real,
    hasstatus  => $service_hasstatus,
    hasrestart => $service_hasrestart,
    require    => [ Package['snmpd'], File['var-net-snmp'], ],
  }
}
