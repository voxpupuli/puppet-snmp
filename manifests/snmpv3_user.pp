# @summary
#   Creates a SNMPv3 user with authentication and encryption paswords.
#
# @example
#   snmp::snmpv3_user { 'myuser':
#     authtype => 'MD5',
#     authpass => '1234auth',
#     privpass => '5678priv',
#   }
#
# @param authpass
#   Authentication password for the user.
#
# @param authtype
#   Authentication type for the user.  SHA or MD5
#
# @param privpass
#   Encryption password for the user.
#
# @param privtype
#   Encryption type for the user.  AES or DES
#
# @param daemon
#   Which daemon file in which to write the user.  snmpd or snmptrapd
#
define snmp::snmpv3_user (
  $authpass,
  Enum['SHA','MD5'] $authtype = 'SHA',

  $privpass = undef,
  Enum['AES','DES'] $privtype = 'AES',

  Enum['snmpd','snmptrapd'] $daemon = 'snmpd'
) {
  include snmp

  if ($daemon == 'snmptrapd') and ($facts['os']['family'] != 'Debian') {
    $service_name   = 'snmptrapd'
    $service_before = Service['snmptrapd']
  } else {
    $service_name   = 'snmpd'
    $service_before = Service['snmpd']
  }

  if $privpass {
    $cmd = "createUser ${title} ${authtype} \\\"${authpass}\\\" ${privtype} \\\"${privpass}\\\""
  } else {
    $cmd = "createUser ${title} ${authtype} \\\"${authpass}\\\""
  }
  exec { "create-snmpv3-user-${title}":
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    # TODO: Add "rwuser ${title}" (or rouser) to /etc/snmp/${daemon}.conf
    command => "service ${service_name} stop ; sleep 5 ; \
echo \"${cmd}\" >>${snmp::params::var_net_snmp}/${daemon}.conf \
&& touch ${snmp::params::var_net_snmp}/${title}-${daemon}",
    creates => "${snmp::params::var_net_snmp}/${title}-${daemon}",
    user    => 'root',
    require => [ Package['snmpd'], File['var-net-snmp'], ],
    before  => $service_before,
  }
}
