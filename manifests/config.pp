# == Class: telegraf::config
#
# Templated generation of telegraf.conf
#
class telegraf::config inherits telegraf {

  assert_private()

  $config_file_ensure = $telegraf::ensure ? {
    'absent' => absent,
    default  => file,
  }
  $config_folder_ensure = $telegraf::ensure ? {
    'absent' => absent,
    default  => directory,
  }
  file { $telegraf::config_file:
    ensure  => $config_file_ensure,
    content => template('telegraf/telegraf.conf.erb'),
    owner   => $telegraf::config_file_owner,
    group   => $telegraf::config_file_group,
    mode    => $telegraf::config_file_mode,
  }
  file { $telegraf::config_folder:
    ensure  => $config_folder_ensure,
    owner   => $telegraf::config_file_owner,
    group   => $telegraf::config_file_group,
    mode    => $telegraf::config_folder_mode,
    purge   => $telegraf::purge_config_fragments,
    recurse => true,
  }

}
