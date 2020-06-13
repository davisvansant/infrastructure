#
# Cookbook:: infrastructure_kong
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_kong::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'includes the infrastructure_docker::default recipe' do
      expect(chef_run).to include_recipe('infrastructure_docker::default')
    end

    it 'pulls the kong image from dockerhub' do
      expect(chef_run).to pull_docker_image('kong').with(
        tag: '2.0.4'
      )
    end

    it 'pulls the postgres image from dockerhub' do
      expect(chef_run).to pull_docker_image('postgres').with(
        tag: '12.3'
      )
    end

    it 'creates the kong docker network' do
      expect(chef_run).to create_docker_network('kong')
    end

    it 'starts the postgres container' do
      expect(chef_run).to run_docker_container('postgres').with(
        repo: 'postgres',
        tag: '12.3',
        port: ['5432:5432'],
        env: [
          'POSTGRES_USER=kong',
          'POSTGRES_DB=kong',
          'POSTGRES_PASSWORD=kong',
        ],
        network_mode: 'kong',
        ipc_mode: 'shareable',
        restart_policy: 'unless-stopped'
      )
    end

    it 'sleeps during the chef run' do
      expect(chef_run).to sleep_chef_sleep('wait for postgres database to initialize').with(
        seconds: 30
      )
    end

    it 'runs the kong migrations' do
      expect(chef_run).to run_docker_container('kong-migrations').with(
        repo: 'kong',
        tag: '2.0.4',
        env: [
          'KONG_DATABASE=postgres',
          'KONG_PG_HOST=postgres',
          'KONG_PG_USER=kong',
          'KONG_PG_PASSWORD=kong',
          'KONG_CASSANDRA_CONTACT_POINTS=postgres',
        ],
        network_mode: 'kong',
        command: ['kong', 'migrations', 'bootstrap', '-v'],
        autoremove: true
      )
    end

    it 'starts the kong container' do
      expect(chef_run).to run_docker_container('kong').with(
        repo: 'kong',
        tag: '2.0.4',
        port: [
          '8000:8000',
          '8001:8001',
          '8443:8443',
          '8444:8444',
        ],
        env: [
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
        ],
        network_mode: 'kong',
        restart_policy: 'unless-stopped'
      )
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
