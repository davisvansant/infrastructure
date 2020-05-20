#
# Cookbook:: infrastructure_kubeadm
# Recipe:: pull_images
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

include_recipe 'infrastructure_kubeadm::default'

execute 'kubeadm config images pull' do
  live_stream true
  action :run
end
