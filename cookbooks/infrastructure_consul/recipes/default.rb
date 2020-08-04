#
# Cookbook:: infrastructure_consul
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

include_recipe 'infrastructure_hashicorp::default'

apt_package 'consul' do
  version '1.8.0'
  action :install
end
