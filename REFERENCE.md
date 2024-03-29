# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`snmp`](#snmp): Manage the Net-SNMP and Net-SNMP trap daemon package, service, and
configuration.
* [`snmp::client`](#snmp--client): Manage the Net-SNMP client package and configuration.

### Defined types

* [`snmp::snmpv3_user`](#snmp--snmpv3_user): Creates a SNMPv3 user with authentication and encryption paswords.

### Functions

#### Private Functions

* `snmp::snmpv3_usm_hash`: snmpv3_usm_hash.rb --- Calculate SNMPv3 USM hash for a passphrase

## Classes

### <a name="snmp"></a>`snmp`

Manage the Net-SNMP and Net-SNMP trap daemon package, service, and
configuration.

#### Examples

##### 

```puppet
class { 'snmp':
  com2sec       => [ 'notConfigUser default PassW0rd' ],
  manage_client => true,
}

# Only configure and run the snmptrap daemon:
class { 'snmp':
  ro_community        => 'SeCrEt',
  service_ensure      => 'stopped',
  trap_service_ensure => 'running',
  trap_handlers       => [
    'default /usr/bin/perl /usr/bin/traptoemail me@somewhere.local',
    'IF-MIB::linkDown /home/nba/bin/traps down',
  ],
}
```

#### Parameters

The following parameters are available in the `snmp` class:

* [`agentaddress`](#-snmp--agentaddress)
* [`snmptrapdaddr`](#-snmp--snmptrapdaddr)
* [`ro_community`](#-snmp--ro_community)
* [`ro_community6`](#-snmp--ro_community6)
* [`rw_community`](#-snmp--rw_community)
* [`rw_community6`](#-snmp--rw_community6)
* [`ro_network`](#-snmp--ro_network)
* [`ro_network6`](#-snmp--ro_network6)
* [`rw_network`](#-snmp--rw_network)
* [`rw_network6`](#-snmp--rw_network6)
* [`contact`](#-snmp--contact)
* [`location`](#-snmp--location)
* [`sysname`](#-snmp--sysname)
* [`services`](#-snmp--services)
* [`com2sec`](#-snmp--com2sec)
* [`com2sec6`](#-snmp--com2sec6)
* [`groups`](#-snmp--groups)
* [`views`](#-snmp--views)
* [`accesses`](#-snmp--accesses)
* [`dlmod`](#-snmp--dlmod)
* [`extends`](#-snmp--extends)
* [`pass`](#-snmp--pass)
* [`pass_persist`](#-snmp--pass_persist)
* [`snmpd_config`](#-snmp--snmpd_config)
* [`disable_authorization`](#-snmp--disable_authorization)
* [`do_not_log_traps`](#-snmp--do_not_log_traps)
* [`do_not_log_tcpwrappers`](#-snmp--do_not_log_tcpwrappers)
* [`trap_handlers`](#-snmp--trap_handlers)
* [`trap_forwards`](#-snmp--trap_forwards)
* [`snmptrapd_config`](#-snmp--snmptrapd_config)
* [`manage_client`](#-snmp--manage_client)
* [`manage_snmptrapd`](#-snmp--manage_snmptrapd)
* [`snmp_config`](#-snmp--snmp_config)
* [`ensure`](#-snmp--ensure)
* [`autoupgrade`](#-snmp--autoupgrade)
* [`manage_packages`](#-snmp--manage_packages)
* [`package_name`](#-snmp--package_name)
* [`snmptrapd_package_name`](#-snmp--snmptrapd_package_name)
* [`snmpd_options`](#-snmp--snmpd_options)
* [`sysconfig`](#-snmp--sysconfig)
* [`trap_sysconfig`](#-snmp--trap_sysconfig)
* [`trap_service_config`](#-snmp--trap_service_config)
* [`service_config`](#-snmp--service_config)
* [`service_config_perms`](#-snmp--service_config_perms)
* [`service_config_dir_path`](#-snmp--service_config_dir_path)
* [`service_config_dir_owner`](#-snmp--service_config_dir_owner)
* [`service_config_dir_group`](#-snmp--service_config_dir_group)
* [`service_config_dir_perms`](#-snmp--service_config_dir_perms)
* [`service_ensure`](#-snmp--service_ensure)
* [`service_name`](#-snmp--service_name)
* [`service_enable`](#-snmp--service_enable)
* [`service_hasstatus`](#-snmp--service_hasstatus)
* [`service_hasrestart`](#-snmp--service_hasrestart)
* [`snmptrapd_options`](#-snmp--snmptrapd_options)
* [`trap_service_ensure`](#-snmp--trap_service_ensure)
* [`trap_service_name`](#-snmp--trap_service_name)
* [`trap_service_enable`](#-snmp--trap_service_enable)
* [`trap_service_hasstatus`](#-snmp--trap_service_hasstatus)
* [`trap_service_hasrestart`](#-snmp--trap_service_hasrestart)
* [`openmanage_enable`](#-snmp--openmanage_enable)
* [`master`](#-snmp--master)
* [`agentx_perms`](#-snmp--agentx_perms)
* [`agentx_ping_interval`](#-snmp--agentx_ping_interval)
* [`agentx_socket`](#-snmp--agentx_socket)
* [`agentx_timeout`](#-snmp--agentx_timeout)
* [`agentx_retries`](#-snmp--agentx_retries)
* [`snmpv2_enable`](#-snmp--snmpv2_enable)
* [`var_net_snmp`](#-snmp--var_net_snmp)
* [`varnetsnmp_perms`](#-snmp--varnetsnmp_perms)
* [`varnetsnmp_owner`](#-snmp--varnetsnmp_owner)
* [`varnetsnmp_group`](#-snmp--varnetsnmp_group)

##### <a name="-snmp--agentaddress"></a>`agentaddress`

Data type: `Array[String[1]]`

An array of addresses, on which snmpd will listen for queries.

Default value: `['udp:127.0.0.1:161', 'udp6:[::1]:161']`

##### <a name="-snmp--snmptrapdaddr"></a>`snmptrapdaddr`

Data type: `Array[String[1]]`

An array of addresses, on which snmptrapd will listen to receive incoming
SNMP notifications.

Default value: `['udp:127.0.0.1:162', 'udp6:[::1]:162']`

##### <a name="-snmp--ro_community"></a>`ro_community`

Data type: `Variant[Undef, String[1], Array[String[1]]]`

Read-only (RO) community string or array for agent and snmptrap daemon.

Default value: `'public'`

##### <a name="-snmp--ro_community6"></a>`ro_community6`

Data type: `Variant[Undef, String[1], Array[String[1]]]`

Read-only (RO) community string or array for IPv6 agent.

Default value: `'public'`

##### <a name="-snmp--rw_community"></a>`rw_community`

Data type: `Variant[Undef, String[1], Array[String[1]]]`

Read-write (RW) community string or array agent.

Default value: `undef`

##### <a name="-snmp--rw_community6"></a>`rw_community6`

Data type: `Variant[Undef, String[1], Array[String[1]]]`

Read-write (RW) community string or array for IPv6 agent.

Default value: `undef`

##### <a name="-snmp--ro_network"></a>`ro_network`

Data type: `Variant[Array, Stdlib::IP::Address::V4, Stdlib::IP::Address::V4::CIDR]`

Network that is allowed to RO query the daemon.  Can be string or array.

Default value: `'127.0.0.1'`

##### <a name="-snmp--ro_network6"></a>`ro_network6`

Data type: `Variant[Array, Stdlib::IP::Address::V6, Stdlib::IP::Address::V6::CIDR]`

Network that is allowed to RO query the daemon via IPv6.  Can be string or array.

Default value: `'::1'`

##### <a name="-snmp--rw_network"></a>`rw_network`

Data type: `Variant[Array, Stdlib::IP::Address::V4, Stdlib::IP::Address::V4::CIDR]`

Network that is allowed to RW query the daemon.  Can be string or array.

Default value: `'127.0.0.1'`

##### <a name="-snmp--rw_network6"></a>`rw_network6`

Data type: `Variant[Array, Stdlib::IP::Address::V6, Stdlib::IP::Address::V6::CIDR]`

Network that is allowed to RW query the daemon via IPv6.  Can be string or array.

Default value: `'::1'`

##### <a name="-snmp--contact"></a>`contact`

Data type: `String[1]`

Responsible person for the SNMP system.

Default value: `'Unknown'`

##### <a name="-snmp--location"></a>`location`

Data type: `String[1]`

Location of the SNMP system.

Default value: `'Unknown'`

##### <a name="-snmp--sysname"></a>`sysname`

Data type: `String[1]`

Name of the system (hostname).

Default value: `$facts['networking']['fqdn']`

##### <a name="-snmp--services"></a>`services`

Data type: `Integer`

For a host system, a good value is 72 (application + end-to-end layers).

Default value: `72`

##### <a name="-snmp--com2sec"></a>`com2sec`

Data type: `Array[String[1]]`

An array of VACM com2sec mappings.
Must provide SECNAME, SOURCE and COMMUNITY.
See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.

Default value: `['notConfigUser  default       public']`

##### <a name="-snmp--com2sec6"></a>`com2sec6`

Data type: `Array[String[1]]`

An array of VACM com2sec6 mappings.
Must provide SECNAME, SOURCE and COMMUNITY.
See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.

Default value: `['notConfigUser  default       public']`

##### <a name="-snmp--groups"></a>`groups`

Data type: `Array[String[1]]`

An array of VACM group mappings.
Must provide GROUP, <v1|v2c|usm|tsm|ksm>, SECNAME.
See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.

Default value:

```puppet
[
    'notConfigGroup v1            notConfigUser',
    'notConfigGroup v2c           notConfigUser',
  ]
```

##### <a name="-snmp--views"></a>`views`

Data type: `Array[String[1]]`

An array of views that are available to query.
Must provide VNAME, TYPE, OID, and [MASK].
See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.

Default value:

```puppet
[
    'systemview    included   .1.3.6.1.2.1.1',
    'systemview    included   .1.3.6.1.2.1.25.1.1',
  ]
```

##### <a name="-snmp--accesses"></a>`accesses`

Data type: `Array[String[1]]`

An array of access controls that are available to query.
Must provide GROUP, CONTEXT, <any|v1|v2c|usm|tsm|ksm>, LEVEL, PREFX, READ, WRITE, and NOTIFY.
See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbAL for details.

Default value:

```puppet
[
    'notConfigGroup ""      any       noauth    exact  systemview none  none',
  ]
```

##### <a name="-snmp--dlmod"></a>`dlmod`

Data type: `Optional[Array[String[1]]]`

Array of dlmod lines to add to the snmpd.conf file.
Must provide NAME and PATH (ex. "cmaX /usr/lib64/libcmaX64.so").
See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbBD for details.

Default value: `undef`

##### <a name="-snmp--extends"></a>`extends`

Data type: `Optional[Array[String[1]]]`

Array of extend lines to add to the snmpd.conf file.
Must provide NAME, PROG and ARG.
See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbBA for details.

Default value: `undef`

##### <a name="-snmp--pass"></a>`pass`

Data type: `Optional[Array[String[1]]]`

Array of pass lines to add to the snmpd.conf file.
Must provide MIBOID and PROG.
See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbBB for details.

Default value: `undef`

##### <a name="-snmp--pass_persist"></a>`pass_persist`

Data type: `Optional[Array[String[1]]]`

Array of pass_persist lines to add to the snmpd.conf file.
Must provide MIBOID and PROG.
See http://www.net-snmp.org/docs/man/snmpd.conf.html#lbBB for details.

Default value: `undef`

##### <a name="-snmp--snmpd_config"></a>`snmpd_config`

Data type: `Optional[Array[String[1]]]`

Safety valve.  Array of lines to add to the snmpd.conf file.
See http://www.net-snmp.org/docs/man/snmpd.conf.html for all options.

Default value: `undef`

##### <a name="-snmp--disable_authorization"></a>`disable_authorization`

Data type: `Enum['yes','no']`

Disable all access control checks.

Default value: `'no'`

##### <a name="-snmp--do_not_log_traps"></a>`do_not_log_traps`

Data type: `Enum['yes','no']`

Disable the logging of notifications altogether.

Default value: `'no'`

##### <a name="-snmp--do_not_log_tcpwrappers"></a>`do_not_log_tcpwrappers`

Data type: `Enum['yes','no']`

Disable the logging of tcpwrappers messages, e.g. "Connection from UDP: " messages in syslog.

Default value: `'no'`

##### <a name="-snmp--trap_handlers"></a>`trap_handlers`

Data type: `Optional[Array[String[1]]]`

An array of programs to invoke on receipt of traps.
Must provide OID and PROGRAM (ex. "IF-MIB::linkDown /bin/traps down").
See http://www.net-snmp.org/docs/man/snmptrapd.conf.html#lbAI for details.

Default value: `undef`

##### <a name="-snmp--trap_forwards"></a>`trap_forwards`

Data type: `Optional[Array[String[1]]]`

An array of destinations to send to on receipt of traps.
Must provide OID and DESTINATION (ex. "IF-MIB::linkUp udp:1.2.3.5:162").
See http://www.net-snmp.org/docs/man/snmptrapd.conf.html#lbAI for details.

Default value: `undef`

##### <a name="-snmp--snmptrapd_config"></a>`snmptrapd_config`

Data type: `Optional[Array[String[1]]]`

Safety valve.  Array of lines to add to the snmptrapd.conf file.
See http://www.net-snmp.org/docs/man/snmptrapd.conf.html for all options.

Default value: `undef`

##### <a name="-snmp--manage_client"></a>`manage_client`

Data type: `Boolean`

Whether to install the Net-SNMP client package.

Default value: `false`

##### <a name="-snmp--manage_snmptrapd"></a>`manage_snmptrapd`

Data type: `Boolean`

Whether to install the Net-SNMP snmptrapd package. True by default, except on Darwin where there is no service available.

Default value: `true`

##### <a name="-snmp--snmp_config"></a>`snmp_config`

Data type: `Optional[Array[String[1]]]`

Safety valve.  Array of lines to add to the client's global snmp.conf file.
See http://www.net-snmp.org/docs/man/snmp.conf.html for all options.

Default value: `undef`

##### <a name="-snmp--ensure"></a>`ensure`

Data type: `Enum['present','absent']`

Ensure if present or absent.

Default value: `'present'`

##### <a name="-snmp--autoupgrade"></a>`autoupgrade`

Data type: `Boolean`

Upgrade package automatically, if there is a newer version.

Default value: `false`

##### <a name="-snmp--manage_packages"></a>`manage_packages`

Data type: `Boolean`

Controls whether module attempts to manage the packages for SNMPD. On by default, except on Darwin where it ships with the OS.

Default value: `true`

##### <a name="-snmp--package_name"></a>`package_name`

Data type: `String[1]`

Name of the package. Only set this if your platform is not supported or you know what you are doing.

Default value: `'net-snmp'`

##### <a name="-snmp--snmptrapd_package_name"></a>`snmptrapd_package_name`

Data type: `Optional[String[1]]`

Name of the package provinding snmptrapd. Only set this if your platform is not supported or you know what you are doing.

Default value: `undef`

##### <a name="-snmp--snmpd_options"></a>`snmpd_options`

Data type: `Optional[String[1]]`

Commandline options passed to snmpd via init script.

Default value: `undef`

##### <a name="-snmp--sysconfig"></a>`sysconfig`

Data type: `Stdlib::Absolutepath`

Path to sysconfig file for snmpd.

Default value: `'/etc/sysconfig/snmpd'`

##### <a name="-snmp--trap_sysconfig"></a>`trap_sysconfig`

Data type: `Stdlib::Absolutepath`

Path to sysconfig file for snmptrapd.

Default value: `'/etc/sysconfig/snmptrapd'`

##### <a name="-snmp--trap_service_config"></a>`trap_service_config`

Data type: `Stdlib::Absolutepath`

Path to snmptrapd.conf.

Default value: `'/etc/snmp/snmptrapd.conf'`

##### <a name="-snmp--service_config"></a>`service_config`

Data type: `Stdlib::Absolutepath`

Path to snmpd.conf.

Default value: `'/etc/snmp/snmpd.conf'`

##### <a name="-snmp--service_config_perms"></a>`service_config_perms`

Data type: `Stdlib::Filemode`

Set permissions for the service configuration file.

Default value: `'0600'`

##### <a name="-snmp--service_config_dir_path"></a>`service_config_dir_path`

Data type: `Stdlib::Absolutepath`

Path to services configuration directory.

Default value: `'/usr/local/etc/snmp'`

##### <a name="-snmp--service_config_dir_owner"></a>`service_config_dir_owner`

Data type: `String[1]`

Owner for the service configuration directory.

Default value: `'root'`

##### <a name="-snmp--service_config_dir_group"></a>`service_config_dir_group`

Data type: `String[1]`

Set group ownership for the service configuration directory.

Default value: `'root'`

##### <a name="-snmp--service_config_dir_perms"></a>`service_config_dir_perms`

Data type: `String[1]`

Mode of the service configuration directory.

Default value: `'0755'`

##### <a name="-snmp--service_ensure"></a>`service_ensure`

Data type: `Stdlib::Ensure::Service`

Ensure if service is running or stopped.

Default value: `'running'`

##### <a name="-snmp--service_name"></a>`service_name`

Data type: `String[1]`

Name of SNMP service. Only set this if your platform is not supported or you know what you are doing.

Default value: `'snmpd'`

##### <a name="-snmp--service_enable"></a>`service_enable`

Data type: `Boolean`

Start service at boot.

Default value: `true`

##### <a name="-snmp--service_hasstatus"></a>`service_hasstatus`

Data type: `Boolean`

Service has status command.

Default value: `true`

##### <a name="-snmp--service_hasrestart"></a>`service_hasrestart`

Data type: `Boolean`

Service has restart command.

Default value: `true`

##### <a name="-snmp--snmptrapd_options"></a>`snmptrapd_options`

Data type: `Optional[String[1]]`

Commandline options passed to snmptrapd via init script.

Default value: `undef`

##### <a name="-snmp--trap_service_ensure"></a>`trap_service_ensure`

Data type: `Stdlib::Ensure::Service`

Ensure if service is running or stopped.

Default value: `'stopped'`

##### <a name="-snmp--trap_service_name"></a>`trap_service_name`

Data type: `String[1]`

Name of SNMP service
Only set this if your platform is not supported or you know what you are doing.

Default value: `'snmptrapd'`

##### <a name="-snmp--trap_service_enable"></a>`trap_service_enable`

Data type: `Boolean`

Start service at boot.

Default value: `false`

##### <a name="-snmp--trap_service_hasstatus"></a>`trap_service_hasstatus`

Data type: `Boolean`

Service has status command.

Default value: `true`

##### <a name="-snmp--trap_service_hasrestart"></a>`trap_service_hasrestart`

Data type: `Boolean`

Service has restart command.

Default value: `true`

##### <a name="-snmp--openmanage_enable"></a>`openmanage_enable`

Data type: `Boolean`

Adds the smuxpeer directive to the snmpd.conf file to allow net-snmp to talk with Dell's OpenManage

Default value: `false`

##### <a name="-snmp--master"></a>`master`

Data type: `Boolean`

Include the *master* option to enable AgentX registrations.

Default value: `false`

##### <a name="-snmp--agentx_perms"></a>`agentx_perms`

Data type: `Optional[Stdlib::Filemode]`

Defines the permissions and ownership of the AgentX Unix Domain socket.

Default value: `undef`

##### <a name="-snmp--agentx_ping_interval"></a>`agentx_ping_interval`

Data type: `Optional[Integer]`

This will make the subagent try and reconnect every NUM seconds to the
master if it ever becomes (or starts) disconnected.

Default value: `undef`

##### <a name="-snmp--agentx_socket"></a>`agentx_socket`

Data type: `Optional[String[1]]`

Defines the address the master agent listens at, or the subagent should connect to.

Default value: `undef`

##### <a name="-snmp--agentx_timeout"></a>`agentx_timeout`

Data type: `Integer[0]`

Defines the timeout period (NUM seconds) for an AgentX request.

Default value: `1`

##### <a name="-snmp--agentx_retries"></a>`agentx_retries`

Data type: `Integer[0]`

Defines the number of retries for an AgentX request.

Default value: `5`

##### <a name="-snmp--snmpv2_enable"></a>`snmpv2_enable`

Data type: `Boolean`

Disable com2sec, group, and access in snmpd.conf

Default value: `true`

##### <a name="-snmp--var_net_snmp"></a>`var_net_snmp`

Data type: `Stdlib::Absolutepath`

Path to snmp's var directory.

Default value: `'/var/lib/net-snmp'`

##### <a name="-snmp--varnetsnmp_perms"></a>`varnetsnmp_perms`

Data type: `Stdlib::Filemode`

Mode of `var_net_snmp` directory.

Default value: `'0755'`

##### <a name="-snmp--varnetsnmp_owner"></a>`varnetsnmp_owner`

Data type: `String[1]`

Owner of `var_net_snmp` directory.

Default value: `'root'`

##### <a name="-snmp--varnetsnmp_group"></a>`varnetsnmp_group`

Data type: `String[1]`

Group of `var_net_snmp` directory.

Default value: `'root'`

### <a name="snmp--client"></a>`snmp::client`

Manage the Net-SNMP client package and configuration.

#### Examples

##### 

```puppet
class { 'snmp::client':
  snmp_config => [
    'defVersion 2c',
    'defCommunity public',
  ],
}
```

#### Parameters

The following parameters are available in the `snmp::client` class:

* [`ensure`](#-snmp--client--ensure)
* [`snmp_config`](#-snmp--client--snmp_config)
* [`autoupgrade`](#-snmp--client--autoupgrade)
* [`package_name`](#-snmp--client--package_name)
* [`client_config`](#-snmp--client--client_config)

##### <a name="-snmp--client--ensure"></a>`ensure`

Data type: `Enum['present', 'absent']`

Ensure if present or absent.

Default value: `'present'`

##### <a name="-snmp--client--snmp_config"></a>`snmp_config`

Data type: `Optional[Array[String[1]]]`

Array of lines to add to the client's global snmp.conf file.
See http://www.net-snmp.org/docs/man/snmp.conf.html for all options.

Default value: `undef`

##### <a name="-snmp--client--autoupgrade"></a>`autoupgrade`

Data type: `Boolean`

Upgrade package automatically, if there is a newer version.

Default value: `false`

##### <a name="-snmp--client--package_name"></a>`package_name`

Data type: `Optional[String[1]]`

Name of the package.
Only set this if your platform is not supported or you know what you are
doing.

Default value: `undef`

##### <a name="-snmp--client--client_config"></a>`client_config`

Data type: `Stdlib::Absolutepath`

Path to `snmp.conf`.

Default value: `'/etc/snmp/snmp.conf'`

## Defined types

### <a name="snmp--snmpv3_user"></a>`snmp::snmpv3_user`

Creates a SNMPv3 user with authentication and encryption paswords.

#### Examples

##### 

```puppet
snmp::snmpv3_user { 'myuser':
  authtype => 'MD5',
  authpass => '1234auth',
  privpass => '5678priv',
}
```

#### Parameters

The following parameters are available in the `snmp::snmpv3_user` defined type:

* [`authpass`](#-snmp--snmpv3_user--authpass)
* [`authtype`](#-snmp--snmpv3_user--authtype)
* [`privpass`](#-snmp--snmpv3_user--privpass)
* [`privtype`](#-snmp--snmpv3_user--privtype)
* [`daemon`](#-snmp--snmpv3_user--daemon)

##### <a name="-snmp--snmpv3_user--authpass"></a>`authpass`

Data type: `String[8]`

Authentication password for the user.

##### <a name="-snmp--snmpv3_user--authtype"></a>`authtype`

Data type: `Enum['SHA','MD5']`

Authentication type for the user.  SHA or MD5

Default value: `'SHA'`

##### <a name="-snmp--snmpv3_user--privpass"></a>`privpass`

Data type: `Optional[String[8]]`

Encryption password for the user.

Default value: `undef`

##### <a name="-snmp--snmpv3_user--privtype"></a>`privtype`

Data type: `Enum['AES','DES']`

Encryption type for the user.  AES or DES

Default value: `'AES'`

##### <a name="-snmp--snmpv3_user--daemon"></a>`daemon`

Data type: `Enum['snmpd','snmptrapd']`

Which daemon file in which to write the user.  snmpd or snmptrapd

Default value: `'snmpd'`

