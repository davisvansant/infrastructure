#
# Cookbook:: infrastructure_cockroachdb
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

include_recipe 'infrastructure_docker::default'

%w(
  /opt/cockroachdb
  /opt/cockroachdb/certs
).each do |dir|
  directory dir do
    mode '0755'
    owner 'root'
    group 'root'
    action :create
    recursive true
  end
end

docker_image 'cockroachdb/cockroach' do
  tag 'v20.1.1'
  action :pull
end

chef_sleep 'waiting...' do
  seconds 5
end

docker_container 'create-cockroach-ca-certs' do
  repo 'cockroachdb/cockroach'
  tag 'v20.1.1'
  command 'cert create-ca --certs-dir=/tmp --ca-key=/tmp/ca.key'
  volumes_binds ['/opt/cockroachdb/certs:/tmp']
  action :run_if_missing
end

chef_sleep 'waiting...' do
  seconds 5
end

docker_container 'create-cockroach-node-certs' do
  repo 'cockroachdb/cockroach'
  tag 'v20.1.1'
  command "cert create-node #{node['hostname']} --certs-dir=/tmp --ca-key=/tmp/ca.key"
  volumes_binds ['/opt/cockroachdb/certs:/tmp']
  action :run_if_missing
end

chef_sleep 'waiting...' do
  seconds 5
end

docker_container 'create-cockroach-client-certs' do
  repo 'cockroachdb/cockroach'
  tag 'v20.1.1'
  command 'cert create-client root --certs-dir=/tmp --ca-key=/tmp/ca.key'
  volumes_binds ['/opt/cockroachdb/certs:/tmp']
  action :run_if_missing
end

chef_sleep 'waiting...' do
  seconds 5
end

docker_container 'cockroach-single-node' do
  repo 'cockroachdb/cockroach'
  tag 'v20.1.1'
  command 'start-single-node --certs-dir=/tmp'
  volumes_binds ['/opt/cockroachdb/certs:/tmp']
  working_dir '/cockroach'
  network_mode 'host'
  ipc_mode 'shareable'
  restart_policy 'unless-stopped'
end

chef_sleep 'waiting...' do
  seconds 5
end

command = 'CREATE USER cockroach WITH PASSWORD "cockroach";'

docker_container 'create-cockroach-user' do
  repo 'cockroachdb/cockroach'
  tag 'v20.1.1'
  command "sql --user=root --certs-dir=/tmp --host=#{node['hostname']} --execute='#{command}'"
  network_mode 'host'
  volumes_binds ['/opt/cockroachdb/certs:/tmp']
  action :run_if_missing
end
