#
# Cookbook:: infrastructure_elasticsearch
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

directory '/etc/systemd/system/elasticsearch.service.d/' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

template '/etc/systemd/system/elasticsearch.service.d/override.conf' do
  source 'override.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

elasticsearch_user 'elasticsearch'
elasticsearch_install 'elasticsearch'
elasticsearch_configure 'elasticsearch' do
  configuration(
    'bootstrap.memory_lock' => true,
    'cluster.name' => 'production',
    'http.host' => node['ipaddress'],
    'transport.host' => node['ipaddress'],
    'discovery.type' => 'single-node'
  )
end
elasticsearch_service 'elasticsearch'
# elasticsearch_plugin 'x-pack'
