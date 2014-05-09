define awscli::config (
  $aws_access_key,
  $aws_secret_key,
  $aws_region = 'UNSET',
  $owner = 'UNSET',
  $group = 'UNSET',
  $mode = 'UNSET',
  $home = 'UNSET',
  $file = 'UNSET',
) {
  include awscli::params

  $_aws_access_key = $aws_access_key
  $_aws_secret_key = $aws_secret_key
  $_aws_region = $aws_region ? {
    'UNSET'   => $awscli::params::aws_region,
    default => $aws_region,
  }

  $_owner = $owner ? {
    'UNSET'   => $awscli::params::owner,
    default => $owner,
  }
  $_group = $group ? {
    'UNSET'   => $awscli::params::group,
    default => $group,
  }
  $_mode = $mode ? {
    'UNSET'   => $awscli::params::mode,
    default => $mode,
  }
  if $home != 'UNSET' {
    $_home = $home
  } else {
    $_home = $owner ? {
      root    => '/root',
      default => "/home/${owner}",
    }
  }
  $_awshome = "${_home}/.aws"
  $_file = $file ? {
    'UNSET'   => "${_awshome}/config",
    default => $file,
  }

  # Home directories are often defined else where, ensure prevents duplicated resource
  ensure_resource('file', $_home, {
    ensure => directory,
  })

  File[$_home]
  ->
  file { $_awshome:
    ensure => directory,
    mode   => '0700',
    owner  => $_owner,
    group  => $_group,
  }
  ->
  file { $_file:
    ensure  => file,
    path    => $_file,
    mode    => $_mode,
    owner   => $_owner,
    group   => $_group,
    content => template("awscli/awscli-config.erb"),
  }
}
