#
# Cookbook:: infrastructure_nomad
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

apt_repository 'nomad' do
  arch 'amd64'
  uri 'https://apt.releases.hashicorp.com'
  key 'https://apt.releases.hashicorp.com/gpg'
  components ['main']
  distribution 'xenial'
end

apt_package 'nomad' do
  version '0.12.1'
  action :install
end
