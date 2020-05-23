#
# Cookbook:: infrastructure_redis
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

node.default['redisio']['version'] = '6.0.3'

include_recipe 'redisio::default'
include_recipe 'redisio::enable'
