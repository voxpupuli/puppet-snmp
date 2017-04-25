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
# [*packages*]
#   List of packages to install.
#
# [*services*]
#   List of services to manage.
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
# [*snmpv2_enable*]
#   Disable com2sec, group, and access in snmpd.conf
#
#   Default: true
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

class snmp (
    Enum['present','absent'] $ensure = $snmp::params::ensure,
    Array[String] $agentaddress = ['udp:127.0.0.1:161', 'udp6:[::1]:161'],
    Array[String] $snmptrapdaddr = [ 'udp:127.0.0.1:162', 'udp6:[::1]:162' ],
    Array[String[1]] $com2sec = [ 'notConfigUser default public' ],
    Array[String[1]] $com2sec6 = [ "notConfigUser default ${ro_community}" ],
    Array[String[1]] $groups = ['notConfigGroup v1  notConfigUser', 'notConfigGroup v2c notConfigUser'],
    Array[String[1]] $views = [ 'systemview included .1.3.6.1.2.1.1', 'systemview included .1.3.6.1.2.1.25.1.1' ],
    Array[String[1]] $accesses = [ 'notConfigGroup "" any noauth exact systemview none none' ],
    Array[String[1]] $dlmod = [],
    Array[String[1]] $extends = [],
    Array[String[1]] $snmpd_config = [],
    Variant[String, Enum['yes', 'no']] $disable_authorization = 'no',
    Variant[String, Enum['yes', 'no']] $do_not_log_traps = 'no',
    Variant[String, Enum['yes', 'no']] $do_not_log_tcpwrappers = 'yes',
    Array[String] $trap_handlers = [],
    Array[String] $trap_forwards = [],
    Array[String] $snmptrapd_config = [],
    Boolean $manage_client = false,
    Boolean $autoupgrade = true,
    String $snmpd_options = '-LS0-6d',
    String $service_config = '/etc/snmp/snmpd.conf',
    String $service_config_perms = '0600',
    String $service_config_dir_group = 'root',
    String $trap_service_config = '/etc/snmp/snmptrapd.conf',
    Stdlib::Ensure::Service $service_ensure = 'running',
    Boolean $service_enable = true,
    Boolean $service_hasstatus = true,
    Boolean $service_hasrestart = true,
    String $snmptrapd_options = '-Lsd',
    Stdlib::Ensure::Service $trap_service_ensure = 'stopped',
    String $trap_service_name = 'snmptrapd',
    Boolean $trap_service_enable = false,
    Boolean $trap_service_hasstatus = true,
    Boolean $trap_service_hasrestart = true,
    String[1] $template_snmpd_conf          = $snmp::params::template_snmpd_conf,
    String[1] $template_snmpd_sysconfig     = $snmp::params::template_snmpd_sysconfig,
    String[1] $template_snmptrapd           = $snmp::params::template_snmptrapd,
    String[1] $template_snmptrapd_sysconfig = $snmp::params::template_snmptrapd_sysconfig, 
    Boolean $openmanage_enable = false,
    Boolean $master               = $snmp::params::master,
    $agentx_perms                 = $snmp::params::agentx_perms,
    $agentx_ping_interval         = $snmp::params::agentx_ping_interval,
    $agentx_socket                = $snmp::params::agentx_socket,
    Integer[0] $agentx_timeout    = $snmp::params::agentx_timeout,
    Integer[0] $agentx_retries    = $snmp::params::agentx_retries,
    Boolean $snmpv2_enable        = $snmp::params::snmpv2_enable,
    String $sysconfig_path = '/etc/sysconfig/snmpd',
    String $sysname = $facts['fqdn'],
    Array[String] $packages = ['net-snmp'],
    Array[String] $services = ['snmpd'],
    Optional[String] $ro_community = undef,
    Optional[String] $ro_community6 = undef,
    Optional[String] $rw_community = undef,
    Optional[String] $rw_community6 = undef,
    Optional[String] $ro_network = undef,
    Optional[String] $ro_network6 = undef,
    Optional[String] $rw_network = undef,
    Optional[String] $rw_network6 = undef,
    Optional[String] $contact = undef,
    Optional[String] $location = undef,
    ) {

    case $ensure {
      /(present)/: {
        if $autoupgrade == true {
            $package_ensure = 'latest'
        }
        else {
            $package_ensure = 'installed'
        }

        $file_ensure = 'file'
      }

      /(absent)/: {
        $package_ensure = 'absent'
        $file_ensure = 'absent'
        $service_ensure = 'stopped'
        $service_enable = false
        $trap_service_ensure = 'stopped'
        $trap_service_enable = false
      }

      default: {
        fail('ensure parameter must be present or absent')
      }
    }
  } else {
    $package_ensure = 'absent'
    $file_ensure = 'absent'
    $service_ensure_real = 'stopped'
    $service_enable_real = false
    $trap_service_ensure_real = 'stopped'
    $trap_service_enable_real = false
  }

    if $service_ensure == 'running' {
        $snmpdrun = 'yes'
    }
    else {
        $snmpdrun = 'no'
    }
  }

    if $trap_service_ensure == 'running' {
        $trapdrun = 'yes'
    }
    else {
        $trapdrun = 'no'
    }

    if $::osfamily != 'Debian' {
      $snmptrapd_conf_notify = Service['snmptrapd']
    }
    else {
      $snmptrapd_conf_notify = Service['snmpd']
    }

    if $manage_client == true {
        class { 'snmp::client':
            ensure      => $ensure,
            autoupgrade => $autoupgrade,
        }
    }
  }

    package { $packages:
        ensure => $package_ensure,
    }

    file { 'var-net-snmp':
        ensure  => 'directory',
        mode    => '0755',
        owner   => 'root',
        group   => 'root',
        path    => $var_net_snmp,
        require => Package[$packages],
    }

    file { $service_config:
        ensure  => $file_ensure,
        mode    => $service_config_perms,
        owner   => 'root',
        group   => $service_config_dir_group,
        content => template('snmp/snmpd.conf.erb'),
        require => Package[$packages],
        notify  => Service[$services],
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

  file { 'snmptrapd.conf':
    ensure  => $file_ensure,
    mode    => $service_config_perms,
    owner   => 'root',
    group   => $service_config_dir_group,
    path    => $snmp::params::trap_service_config,
    content => template($template_snmptrapd),
    require => Package['snmpd'],
  }


  unless $facts['os']['family'] == 'FreeBSD' or $facts['os']['family'] == 'OpenBSD' {
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

  if $facts['os']['family'] == 'RedHat' {
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
  }

  # Services
  unless $facts['os']['family'] == 'Debian' {
    service { 'snmptrapd':
      ensure     => $trap_service_ensure_real,
      name       => $trap_service_name,
      enable     => $trap_service_enable_real,
      hasstatus  => $trap_service_hasstatus,
      hasrestart => $trap_service_hasrestart,
      require    => File['var-net-snmp'],
      subscribe  => File['snmptrapd.conf'],
    }
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

  if $facts['os']['family'] == 'Debian' {
    File['snmptrapd.conf'] ~> Service['snmpd']
  }
}
