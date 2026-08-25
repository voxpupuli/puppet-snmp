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
#   Authentication password for the user. May be given as Sensitive; the
#   createUser line is then marked Sensitive too (redacted in reports/PuppetDB).
#
# @param authtype
#   Authentication type for the user.  SHA or MD5
#
# @param privpass
#   Encryption password for the user. May be given as Sensitive.
#
# @param privtype
#   Encryption type for the user.  AES or DES
#
# @param daemon
#   Which daemon file in which to write the user.  snmpd or snmptrapd
#
define snmp::snmpv3_user (
  Variant[String[8], Sensitive[String[8]]]           $authpass,
  Enum['SHA','MD5']         $authtype = 'SHA',
  Optional[Variant[String[8], Sensitive[String[8]]]] $privpass = undef,
  Enum['AES','DES']         $privtype = 'AES',
  Enum['snmpd','snmptrapd'] $daemon   = 'snmpd'
) {
  include snmp

  # Unwrap Sensitive passwords for the hash calculation and the createUser
  # line; the line is re-wrapped in Sensitive below if either was Sensitive.
  $_sensitive = ($authpass =~ Sensitive) or ($privpass =~ Sensitive)
  $_authpass = if $authpass =~ Sensitive { $authpass.unwrap } else { $authpass }
  $_privpass = if $privpass =~ Sensitive { $privpass.unwrap } else { $privpass }

  if ($daemon == 'snmptrapd') and ($facts['os']['family'] != 'Debian') {
    $service_name   = 'snmptrapd'
  } else {
    $service_name   = 'snmpd'
  }

  $_cmd = $_privpass ? {
    undef   => "createUser ${title} ${authtype} \"${_authpass}\"",
    default => "createUser ${title} ${authtype} \"${_authpass}\" ${privtype} \"${_privpass}\""
  }
  $cmd = if $_sensitive { Sensitive($_cmd) } else { $_cmd }

  if ($title in $facts['snmpv3_user']) {
    # user details from config are available as fact
    $usm_user = $facts['snmpv3_user'][$title]

    $authhash = snmp::snmpv3_usm_hash($authtype, $usm_user['engine'], $_authpass)

    # privacy protocol key may be empty; truncate to 128 bits if used
    $privhash = empty($_privpass) ? {
      true    => '',
      default => snmp::snmpv3_usm_hash($authtype, $usm_user['engine'], $_privpass, 128)
    }

    # (re)create the user if at least one of the hashes is different
    $create = ($authhash != $usm_user['authhash']) or ($privhash != $usm_user['privhash'])
  }
  else {
    # user is unknown
    $create = true
  }

  if $create {
    unless defined(Exec["stop-${service_name}"]) {
      $command = $facts['service_provider'] ? {
        'systemd' => "systemctl stop ${service_name}; sleep 5",
        default   => "service ${service_name} stop ; sleep 5",
      }

      exec { "stop-${service_name}":
        command => $command,
        user    => 'root',
        cwd     => '/',
        path    => '/bin:/sbin:/usr/bin:/usr/sbin',
        require => File['var-net-snmp'],
      }
      if $snmp::manage_packages {
        Package['snmpd'] -> Exec["stop-${service_name}"]
      }
    }

    unless defined(File["${snmp::var_net_snmp}/${service_name}.conf"]) {
      #
      # For this file there is no content defined since the SNMP daemon
      # rewrites the content on exit. But the file needs to exist or the
      # following file_line resource will fail.
      #
      file { "${snmp::var_net_snmp}/${service_name}.conf":
        ensure => file,
        mode   => '0600',
        owner  => $snmp::varnetsnmp_owner,
        group  => $snmp::varnetsnmp_group,
      }
    }

    file_line { "create-snmpv3-user-${title}":
      path      => "${snmp::var_net_snmp}/${service_name}.conf",
      line      => $cmd,
      match     => "^createUser ${title} ",
      subscribe => Exec["stop-${service_name}"],
      require   => File["${snmp::var_net_snmp}/${service_name}.conf"],
      before    => Service[$service_name],
    }
  }

  # TODO: Add "rwuser ${title}" (or rouser) to /etc/snmp/${daemon}.conf
}
