#
# Cookbook:: infrastructure_hashicorp
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

apt_repository 'hashicorp' do
  arch 'amd64'
  uri 'https://apt.releases.hashicorp.com'
  key 'https://apt.releases.hashicorp.com/gpg'
  components ['main']
end
