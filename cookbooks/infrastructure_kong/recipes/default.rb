#
# Cookbook:: infrastructure_kong
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

include_recipe 'infrastructure_docker::default'

docker_image 'kong' do
  tag '2.0.4'
  action :pull
end

docker_image 'postgres' do
  tag '12.3'
  action :pull
end

docker_network 'kong' do
  action :create
end

docker_container 'postgres' do
  repo 'postgres'
  tag '12.3'
  port ['5432:5432']
  env [
    'POSTGRES_USER=kong',
    'POSTGRES_DB=kong',
    'POSTGRES_PASSWORD=kong',
  ]
  network_mode 'kong'
  ipc_mode 'shareable'
  restart_policy 'unless-stopped'
end

chef_sleep 'wait for postgres database to initialize' do
  seconds 30
  action :sleep
end

docker_container 'kong-migrations' do
  repo 'kong'
  tag '2.0.4'
  env [
    'KONG_DATABASE=postgres',
    'KONG_PG_HOST=postgres',
    'KONG_PG_USER=kong',
    'KONG_PG_PASSWORD=kong',
    'KONG_CASSANDRA_CONTACT_POINTS=postgres',
  ]
  network_mode 'kong'
  command 'kong migrations bootstrap -v'
  autoremove true
end

docker_container 'kong' do
  repo 'kong'
  tag '2.0.4'
  port [
    '8000:8000',
    '8001:8001',
    '8443:8443',
    '8444:8444',
  ]
  env [
    'KONG_DATABASE=postgres',
    'KONG_PG_HOST=postgres',
    'KONG_PG_USER=kong',
    'KONG_PG_PASSWORD=kong',
    'KONG_CASSANDRA_CONTACT_POINTS=postgres',
    'KONG_PROXY_ACCESS_LOG=/dev/stdout',
    'KONG_ADMIN_ACCESS_LOG=/dev/stdout',
    'KONG_PROXY_ERROR_LOG=/dev/stderr',
    'KONG_ADMIN_ERROR_LOG=/dev/stderr',
    'KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl',
  ]
  network_mode 'kong'
  restart_policy 'unless-stopped'
end
