#
# Cookbook:: infrastructure_swap
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

execute 'disable swap' do
  command 'sudo swapoff -a'
end
