#
# Cookbook:: infrastructure_docker
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

docker_installation_package 'default' do
  version '19.03.4'
  action :create
end

docker_service 'default' do
  exec_opts 'native.cgroupdriver=systemd'
  log_driver 'json-file'
  log_opts 'max-size=100m'
  storage_driver 'overlay2'
  action [:create, :start]
end
