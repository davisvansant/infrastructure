#
# Cookbook:: infrastructure_artifactory
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

include_recipe 'infrastructure_docker::default'

group 'artifactory' do
  gid 1030
end

user 'artifactory' do
  uid 1030
  gid 1030
end

%w(
  /opt/artifactory
  /opt/artifactory/var
  /opt/artifactory/var/etc
).each do |dir|
  directory dir do
    owner 1030
    group 1030
    mode '0755'
    action :create
  end
end

docker_image 'docker.bintray.io/jfrog/artifactory-oss' do
  tag '7.4.3'
  action :pull
end

docker_container 'artifactory' do
  repo 'docker.bintray.io/jfrog/artifactory-oss'
  tag '7.4.3'
  port ['8081:8081', '8082:8082']
  volumes ['/opt/artifactory/var/:/var/opt/jfrog/artifactory']
  ipc_mode 'shareable'
  user 'artifactory'
  working_dir '/opt/jfrog/artifactory'
  action :run
end
