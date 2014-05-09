# Requirements
puppetlabs-stdlib

# Example config setup:
Define awscli::config_hash in hiera for your node to setup the default of 'backupuser' (generic service account name I use).  This will attempt to create the home directory for the user if it doesn't exist but it does NOT setup the user/group for you, so you'll want to do that separately prior to running this module, I use profile::backupuser for that in this example:

```
$ grep -B1 aws modules/role/manifests/web_server.pp
  class { 'profile::backupuser': } ->
  class { 'awscli': }

$ grep aws hieradata/nodes/webserver01.domain.com.yaml
awscli::config_hash:
  'your_backup_aws_creds':
    aws_access_key: 'ABCDEFGHIJKLMNOPQRST'
    aws_secret_key: 'UVWXYZabcdefghijklmnopqrstuvwxyz12345789'
    aws_region: 'us-east-1'
```
If you're not using hiera you could still manually create a hash to be used with the awscli::config_hash parameter, or do something like this:

```
include awscli
awscli::config { 'your_user':
  $aws_access_key => "ACCESSKEY123",
  $aws_secret_key => "SECRETKEYABC",
  $owner = 'your_user',
  $group = 'your_group',
)
```
