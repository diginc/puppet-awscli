class awscli::install (
  $pip_package_name = $awscli::params::pip_package_name,
  $awscli_package_name = $awscli::params::awscli_package_name,
  $awscli_provider = $awscli::params::awscli_provider,
) inherits awscli::params {
  package { "${modulename}_python-pip":
    name     => $pip_package_name,
    ensure   => latest,
  }
  ->
  package { "${modulename}_awscli":
    name     => $awscli_package_name,
    ensure   => latest,
    provider => $awscli_provider,
  }
}
