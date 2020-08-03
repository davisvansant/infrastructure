#
# Cookbook:: infrastructure_vault
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

include_recipe 'infrastructure_hashicorp::default'

apt_package 'vault' do
  version '1.5.0'
  action :install
end
