# @summary 
#   Installs the Net-SNMP client package and configuration.
#
# @example
#   class { 'snmp::client':
#     snmp_config => [ 'defVersion 2c', 'defCommunity public', ],
#   }
#
# @param snmp_config
#   Array of lines to add to the client's global snmp.conf file.
#   See http://www.net-snmp.org/docs/man/snmp.conf.html for all options.
#
# @param ensure
#   Ensure if present or absent.
#
# @param autoupgrade
#   Upgrade package automatically, if there is a newer version.
#
# @param package_name
#   Name of the package.
#   Only set this if your platform is not supported or you know what you are
#   doing.
#
class snmp::client (
  $snmp_config         = $snmp::params::snmp_config,
  Enum['present', 'absent'] $ensure = $snmp::params::ensure,
  Boolean $autoupgrade = $snmp::params::autoupgrade,
  $package_name        = $snmp::params::client_package_name
) inherits snmp::params {

  if $ensure == 'present' {
    if $autoupgrade {
      $package_ensure = 'latest'
    } else {
      $package_ensure = 'present'
    }
    $file_ensure = 'present'
  } else {
    $package_ensure = 'absent'
    $file_ensure = 'absent'
  }

  unless $facts['os']['family'] == 'Suse' {
    package { 'snmp-client':
      ensure => $package_ensure,
      name   => $package_name,
      before => File['snmp.conf'],
    }
  }

  if $facts['os']['family'] == 'RedHat' {
    file { '/etc/snmp':
      ensure => directory,
    }
  }

  file { 'snmp.conf':
    ensure  => $file_ensure,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    path    => $snmp::params::client_config,
    content => template('snmp/snmp.conf.erb'),
  }
}
