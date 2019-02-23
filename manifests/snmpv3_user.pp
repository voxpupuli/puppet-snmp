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
  String[8]                 $authpass,
  Enum['SHA','MD5']         $authtype = 'SHA',
  Optional[String[8]]       $privpass = undef,
  Enum['AES','DES']         $privtype = 'AES',
  Enum['snmpd','snmptrapd'] $daemon   = 'snmpd'
) {

  include snmp

  if ($daemon == 'snmptrapd') and ($facts['os']['family'] != 'Debian') {
    $service_name   = 'snmptrapd'
  } else {
    $service_name   = 'snmpd'
  }

  $cmd = $privpass ? {
    undef   => "createUser ${title} ${authtype} \\\"${authpass}\\\"",
    default => "createUser ${title} ${authtype} \\\"${authpass}\\\" ${privtype} \\\"${privpass}\\\""
  }

  if ($title in $facts['snmpv3_user']) {
    # user details from config are available as fact
    $usm_user = $facts['snmpv3_user'][$title]

    $authhash = snmp::snmpv3_usm_hash($authtype, $usm_user['engine'], $authpass)

    # privacy protocol key may be empty; truncate to 128 bits if used
    $privhash = empty($privpass) ? {
      true    => '',
      default => snmp::snmpv3_usm_hash($authtype, $usm_user['engine'], $privpass, 128)
    }

    # (re)create the user if at least one of the hashes is different
    $create = ($authhash != $usm_user['authhash']) or ($privhash != $usm_user['privhash'])
  }
  else {
    # user is unknown
    $create = true
  }

  if $create {
    exec { "create-snmpv3-user-${title}":
      path    => '/bin:/sbin:/usr/bin:/usr/sbin',
      # TODO: Add "rwuser ${title}" (or rouser) to /etc/snmp/${daemon}.conf
      command => "service ${service_name} stop ; sleep 5 ; \
echo \"${cmd}\" >>${snmp::var_net_snmp}/${daemon}.conf",
      user    => 'root',
      require => [ Package['snmpd'], File['var-net-snmp'], ],
      before  => Service[$service_name],
    }
  }
}
