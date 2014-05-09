class awscli (
  $config_hash = false
) inherits awscli::params {
  include ::awscli::install

  if ! $config_hash == false {
    validate_hash($config_hash)
    create_resources('awscli::config', $config_hash)
  }
}
