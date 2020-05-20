#
# Cookbook:: infrastructure_kubeadm
# Recipe:: single_node
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

include_recipe 'infrastructure_kubeadm::default'

execute 'kubeadm init' do
  live_stream true
  action :run
end
