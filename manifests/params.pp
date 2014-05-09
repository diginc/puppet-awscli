class awscli::params {
  # Install:
  ## Yum & Apt pip package name
  $pip_package_name = 'python-pip'
  $awscli_package_name = 'awscli'
  $awscli_provider = 'pip'

  $aws_region = 'us-east-1'

  # Config:
  $owner = 'backupuser'
  $group = 'backupuser'
  $mode = '600'
}
