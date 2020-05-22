#
# Cookbook:: infrastructure_rancher
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

include_recipe 'infrastructure_docker::default'

docker_image 'rancher/rancher' do
  tag 'v2.4.3'
  action :pull
end

docker_container 'rancher' do
  repo 'rancher/rancher'
  tag 'v2.4.3'
  port ['80:80', '443:443']
  restart_policy 'unless-stopped'
end
