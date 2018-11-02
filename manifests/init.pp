# @summary 
#   Installs the Net-SNMP daemon package, service, and configuration. Installs the Net-SNMP trap daemon service and configuration.
#
# @example
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
# @param agentaddress
#   An array of addresses, on which snmpd will listen for queries.
#
# @param snmptrapdaddr
#   An array of addresses, on which snmptrapd will listen to receive incoming
#   SNMP notifications.
#
# @param ro_community
#   Read-only (RO) community string or array for agent and snmptrap daemon.
#
# @param ro_community6
#   Read-only (RO) community string or array for IPv6 agent.
#
# @param rw_community
#   Read-write (RW) community string or array agent.
#
# @param rw_community6
#   Read-write (RW) community string or array for IPv6 agent.
#
# @param ro_network
#   Network that is allowed to RO query the daemon.  Can be string or array.
#
# @param ro_network6
#   Network that is allowed to RO query the daemon via IPv6.  Can be string or array.
#
# @param rw_network
#   Network that is allowed to RW query the daemon.  Can be string or array.
#
# @param rw_network6
#   Network that is allowed to RW query the daemon via IPv6.  Can be string or array.
#
# @param contact
#   Responsible person for the SNMP system.
#
# @param location
#   Location of the SNMP system.
#
# @param sysname
#   Name of the system (hostname).
#
# @param services
#   For a host system, a good value is 72 (application + end-to-end layers).
#
# @param com2sec
#   An array of VACM com2sec mappings.
#   Must provide SECNAME, SOURCE and COMMUNITY.
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.
#
# @param com2sec6
#   An array of VACM com2sec6 mappings.
#   Must provide SECNAME, SOURCE and COMMUNITY.
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.
#
# @param groups
#   An array of VACM group mappings.
#   Must provide GROUP, <v1|v2c|usm|tsm|ksm>, SECNAME.
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.
#
# @param views
#   An array of views that are available to query.
#   Must provide VNAME, TYPE, OID, and [MASK].
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.
#
# @param accesses
#   An array of access controls that are available to query.
#   Must provide GROUP, CONTEXT, <any|v1|v2c|usm|tsm|ksm>, LEVEL, PREFX, READ, WRITE, and NOTIFY.
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.
#
# @param dlmod
#   Array of dlmod lines to add to the snmpd.conf file.
#   Must provide NAME and PATH (ex. "cmaX /usr/lib64/libcmaX64.so").
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbBD for details.
#
# @param extends
#   Array of extend lines to add to the snmpd.conf file.
#   Must provide NAME, PROG and ARG.
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbBA for details.
#
# @param snmpd_config
#   Safety valve.  Array of lines to add to the snmpd.conf file.
#   See http://www.net-snmp.org/docs/man/snmpd.conf.html for all options.
#
# @param disable_authorization
#   Disable all access control checks.
#
# @param do_not_log_traps
#   Disable the logging of notifications altogether. 
#
# @param do_not_log_tcpwrappers
#   Disable the logging of tcpwrappers messages, e.g. "Connection from UDP: " messages in syslog.
#
# @param trap_handlers
#   An array of programs to invoke on receipt of traps.
#   Must provide OID and PROGRAM (ex. "IF-MIB::linkDown /bin/traps down").
#   See http://www.net-snmp.org/docs/man/snmptrapd.conf.html#lbAI for details.
#
# @param trap_forwards
#   An array of destinations to send to on receipt of traps.
#   Must provide OID and DESTINATION (ex. "IF-MIB::linkUp udp:1.2.3.5:162").
#   See http://www.net-snmp.org/docs/man/snmptrapd.conf.html#lbAI for details.
#
# @param snmptrapd_config
#   Safety valve.  Array of lines to add to the snmptrapd.conf file.
#   See http://www.net-snmp.org/docs/man/snmptrapd.conf.html for all options.
#
# @param manage_client
#   Whether to install the Net-SNMP client package.
#
# @param snmp_config
#   Safety valve.  Array of lines to add to the client's global snmp.conf file.
#   See http://www.net-snmp.org/docs/man/snmp.conf.html for all options.
#
# @param ensure
#   Ensure if present or absent.
#
# @param autoupgrade
#   Upgrade package automatically, if there is a newer version.
#
# @param package_name
#   Name of the package. Only set this if your platform is not supported or you know what you are doing.
#
# @param snmptrapd_package_name
#   Name of the snmptrapd package, if there is one.
#   Only set thi sif your platform is not supported or you know what you are doing.
#   Default: auto-set, platform specific
#
# @param snmpd_options
#   Commandline options passed to snmpd via init script.
#
# @param service_config_perms
#   Set permissions for the service configuration file.
#
# @param service_config_dir_group
#   Set group ownership for the service configuration file.
#
# @param service_ensure
#   Ensure if service is running or stopped.
#
# @param service_name
#   Name of SNMP service. Only set this if your platform is not supported or you know what you are doing.
#
# @param service_enable
#   Start service at boot.
#
# @param service_hasstatus
#   Service has status command.
#
# @param service_hasrestart
#   Service has restart command.
#
# @param snmptrapd_options
#   Commandline options passed to snmptrapd via init script.
#
# @param trap_service_ensure
#   Ensure if service is running or stopped.
#
# @param trap_service_name
#   Name of SNMP service
#   Only set this if your platform is not supported or you know what you are doing.
#
# @param trap_service_enable
#   Start service at boot.
#
# @param trap_service_hasstatus
#   Service has status command.
#
# @param trap_service_hasrestart
#   Service has restart command.
#
# @param openmanage_enable
#   Adds the smuxpeer directive to the snmpd.conf file to allow net-snmp to talk with Dell's OpenManage
#
# @param master
#   Include the *master* option to enable AgentX registrations.
#
# @param agentx_perms
#   Defines the permissions and ownership of the AgentX Unix Domain socket.
#
# @param agentx_ping_interval
#   This will make the subagent try and reconnect every NUM seconds to the
#   master if it ever becomes (or starts) disconnected.
#
# @param agentx_socket
#   Defines the address the master agent listens at, or the subagent should connect to.
#
# @param agentx_timeout
#   Defines the timeout period (NUM seconds) for an AgentX request.
#
# @param agentx_retries
#   Defines the number of retries for an AgentX request.
#
# @param snmpv2_enable
#   Disable com2sec, group, and access in snmpd.conf
#
class snmp (
  # Usage
  Enum['present','absent'] $ensure    = $snmp::params::ensure,
  Boolean $autoupgrade                = $snmp::params::autoupgrade,
  Boolean $manage_client              = $snmp::params::manage_client,
  Optional[String] $snmpd_options     = $snmp::params::snmpd_options,
  Optional[String] $snmptrapd_options = $snmp::params::snmptrapd_options,

  # Configuration
  $agentaddress                            = $snmp::params::agentaddress,
  Array[String[1]] $snmptrapdaddr          = $snmp::params::snmptrapdaddr,
  $ro_community                            = $snmp::params::ro_community,
  $ro_community6                           = $snmp::params::ro_community6,
  $rw_community                            = $snmp::params::rw_community,
  $rw_community6                           = $snmp::params::rw_community6,
  $ro_network                              = $snmp::params::ro_network,
  $ro_network6                             = $snmp::params::ro_network6,
  $rw_network                              = $snmp::params::rw_network,
  $rw_network6                             = $snmp::params::rw_network6,
  $contact                                 = $snmp::params::contact,
  $location                                = $snmp::params::location,
  $sysname                                 = $snmp::params::sysname,
  $services                                = $snmp::params::services,
  Array[String[1]] $com2sec                = $snmp::params::com2sec,
  Array[String[1]] $com2sec6               = $snmp::params::com2sec6,
  Array[String[1]] $groups                 = $snmp::params::groups,
  Array[String[1]] $views                  = $snmp::params::views,
  Array[String[1]] $accesses               = $snmp::params::accesses,
  Array[String[1]] $dlmod                  = $snmp::params::dlmod,
  Array[String[1]] $extends                = $snmp::params::extends,
  Boolean $openmanage_enable               = $snmp::params::openmanage_enable,
  Boolean $master                          = $snmp::params::master,
  $agentx_perms                            = $snmp::params::agentx_perms,
  $agentx_ping_interval                    = $snmp::params::agentx_ping_interval,
  $agentx_socket                           = $snmp::params::agentx_socket,
  Integer[0] $agentx_timeout               = $snmp::params::agentx_timeout,
  Integer[0] $agentx_retries               = $snmp::params::agentx_retries,
  Boolean $snmpv2_enable                   = $snmp::params::snmpv2_enable,
  Enum['yes','no'] $disable_authorization  = $snmp::params::disable_authorization,
  Enum['yes','no'] $do_not_log_traps       = $snmp::params::do_not_log_traps,
  Enum['yes','no'] $do_not_log_tcpwrappers = $snmp::params::do_not_log_tcpwrappers,
  Array[String[1]] $trap_handlers          = $snmp::params::trap_handlers,
  Array[String[1]] $trap_forwards          = $snmp::params::trap_forwards,
  # manual config overrides. Added to templates as is.
  Array[String] $snmp_config               = $snmp::params::snmp_config,
  Array[String] $snmpd_config              = $snmp::params::snmpd_config,
  Array[String] $snmptrapd_config          = $snmp::params::snmptrapd_config,

  # (Advanced) System configuration
  Stdlib::Filemode $service_config_perms       = $snmp::params::service_config_perms,
  String[1] $service_config_dir_group          = $snmp::params::service_config_dir_group,
  # snmpd
  String[1] $package_name                      = $snmp::params::package_name,
  Stdlib::Ensure::Service $service_ensure      = $snmp::params::service_ensure,
  String[1] $service_name                      = $snmp::params::service_name,
  Boolean $service_enable                      = $snmp::params::service_enable,
  Boolean $service_hasstatus                   = $snmp::params::service_hasstatus,
  Boolean $service_hasrestart                  = $snmp::params::service_hasrestart,
  # snmptrapd
  Optional[String[1]] $snmptrapd_package_name  = $snmp::params::snmptrapd_package_name,
  Stdlib::Ensure::Service $trap_service_ensure = $snmp::params::trap_service_ensure,
  String[1] $trap_service_name                 = $snmp::params::trap_service_name,
  Boolean $trap_service_enable                 = $snmp::params::trap_service_enable,
  Boolean $trap_service_hasstatus              = $snmp::params::trap_service_hasstatus,
  Boolean $trap_service_hasrestart             = $snmp::params::trap_service_hasrestart,
  # (Super Advanced) template overrides
  String[1] $template_snmpd_conf               = $snmp::params::template_snmpd_conf,
  String[1] $template_snmpd_sysconfig          = $snmp::params::template_snmpd_sysconfig,
  String[1] $template_snmpd_systemd_dropin     = $snmp::params::template_snmpd_systemd_dropin,
  String[1] $template_snmptrapd                = $snmp::params::template_snmptrapd,
  String[1] $template_snmptrapd_sysconfig      = $snmp::params::template_snmptrapd_sysconfig,
  String[1] $template_snmptrapd_systemd_dropin = $snmp::params::template_snmptrapd_systemd_dropin,
) inherits snmp::params {

  if $ensure == 'present' {
    if $autoupgrade {
      $package_ensure = 'latest'
    } else {
      $package_ensure = 'present'
    }
    $file_ensure = 'present'
    $trap_service_ensure_real = $trap_service_ensure
    $trap_service_enable_real = $trap_service_enable
    $service_ensure_real = $service_ensure
    $service_enable_real = $service_enable
  } else {
    $package_ensure = 'absent'
    $file_ensure = 'absent'
    $service_ensure_real = 'stopped'
    $service_enable_real = false
    $trap_service_ensure_real = 'stopped'
    $trap_service_enable_real = false
  }

  if $manage_client {
    class { 'snmp::client':
      ensure      => $ensure,
      autoupgrade => $autoupgrade,
      snmp_config => $snmp_config,
    }
  }

  # Install
  package { 'snmpd':
    ensure => $package_ensure,
    name   => $package_name,
  }

  if $snmptrapd_package_name {
    package {'snmptrapd':
      ensure => $package_ensure,
      name   => $snmptrapd_package_name,
      notify => Service['snmptrapd'],
    }
  }

  file { 'var-net-snmp':
    ensure  => 'directory',
    mode    => $snmp::params::varnetsnmp_perms,
    owner   => $snmp::params::varnetsnmp_owner,
    group   => $snmp::params::varnetsnmp_group,
    path    => $snmp::params::var_net_snmp,
    require => Package['snmpd'],
  }

  if $facts['os']['family'] == 'FreeBSD' {
    file { $snmp::params::service_config_dir_path:
      ensure  => 'directory',
      mode    => $snmp::params::service_config_dir_perms,
      owner   => $snmp::params::service_config_dir_owner,
      group   => $snmp::params::service_config_dir_group,
      require => Package['snmpd'],
    }
  }

  if $facts['os']['family'] == 'Suse' {
    file { '/etc/init.d/snmptrapd':
      source  => '/usr/share/doc/packages/net-snmp/rc.snmptrapd',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Package['snmpd'],
      before  => Service['snmptrapd'],
    }
  }

  if $facts['os']['family'] == 'Debian' and $facts['service_provider'] == 'systemd' {
    systemd::dropin_file { 'snmpd.conf':
      unit    => 'snmpd.service',
      content => epp($template_snmpd_systemd_dropin, { 'snmpd_options' => $snmpd_options, }),
      require => Package['snmpd'],
      notify  => Service['snmpd'],
    }
    systemd::dropin_file {'snmptrapd.conf':
      unit    => 'snmptrapd.service',
      content => epp($template_snmptrapd_systemd_dropin, { 'snmptrapd_options' => $snmptrapd_options, }),
      require => Package['snmptrapd'],
      notify  => Service['snmptrapd'],
    }
  }

  # Config
  file { 'snmpd.conf':
    ensure  => $file_ensure,
    mode    => $service_config_perms,
    owner   => 'root',
    group   => $service_config_dir_group,
    path    => $snmp::params::service_config,
    content => template($template_snmpd_conf),
    require => Package['snmpd'],
  }

  $require_snmptrapd_package = $snmptrapd_package_name ? {
    undef   => 'snmpd',
    default => 'snmptrapd',
  }

  file { 'snmptrapd.conf':
    ensure  => $file_ensure,
    mode    => $service_config_perms,
    owner   => 'root',
    group   => $service_config_dir_group,
    path    => $snmp::params::trap_service_config,
    content => template($template_snmptrapd),
    require => Package[$require_snmptrapd_package],
  }

  if $snmp::sysconfig {
    file { 'snmpd.sysconfig':
      ensure  => $file_ensure,
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      path    => $snmp::sysconfig,
      content => template($template_snmpd_sysconfig),
      require => Package['snmpd'],
      notify  => Service['snmpd'],
    }
  }

  # If your os has a sysconfig style config for trap, it will be
  # created here (if there is a separate package for snmptrapd, we'll
  # depend on that!)
  if $snmp::trap_sysconfig {
    if $snmp::snmptrapd_package_name {
      $snmptrapd_sysconfig_require = Package['snmptrapd']
    } else {
      $snmptrapd_sysconfig_require = Package['snmpd']
    }

    file { 'snmptrapd.sysconfig':
      ensure  => $file_ensure,
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      path    => $snmp::trap_sysconfig,
      content => template($template_snmptrapd_sysconfig),
      require => $snmptrapd_sysconfig_require,
      notify  => Service['snmptrapd'],
    }
  }

  # If options change on debian with systemd, we need to reload the systemd daemon
  # before restarting the service.
  if $facts['service_provider'] == 'systemd' and $snmp::sysconfig == undef {
    Exec['systemctl-daemon-reload'] -> Service['snmpd', 'snmptrapd']
  }

  # Services
  service { 'snmptrapd':
    ensure     => $trap_service_ensure_real,
    name       => $trap_service_name,
    enable     => $trap_service_enable_real,
    hasstatus  => $trap_service_hasstatus,
    hasrestart => $trap_service_hasrestart,
    require    => File['var-net-snmp'],
    subscribe  => File['snmptrapd.conf'],
  }

  service { 'snmpd':
    ensure     => $service_ensure_real,
    name       => $service_name,
    enable     => $service_enable_real,
    hasstatus  => $service_hasstatus,
    hasrestart => $service_hasrestart,
    require    => File['var-net-snmp'],
    subscribe  => File['snmpd.conf'],
  }

}
