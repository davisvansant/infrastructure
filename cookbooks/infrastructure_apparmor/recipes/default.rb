#
# Cookbook:: infrastructure_apparmor
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

node.default['apparmor']['disable'] = true

include_recipe 'apparmor::default'
