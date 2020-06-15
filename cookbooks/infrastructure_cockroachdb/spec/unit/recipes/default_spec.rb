#
# Cookbook:: infrastructure_cockroachdb
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_cockroachdb::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'includes the infrastructure_docker::default recipe' do
      expect(chef_run).to include_recipe('infrastructure_docker::default')
    end

    %w(
      /opt/cockroachdb
      /opt/cockroachdb/certs
    ).each do |dir|
      it "creates the cockroach db #{dir}" do
        expect(chef_run).to create_directory(dir).with(
          mode: '0755',
          owner: 'root',
          group: 'root',
          recursive: true
        )
      end
    end

    it 'pulls the cockroachdb docker image' do
      expect(chef_run).to pull_docker_image('cockroachdb/cockroach').with(
        tag: 'v20.1.1'
      )
    end

    it 'creates the cockroach ca certs' do
      expect(chef_run).to run_if_missing_docker_container('create-cockroach-ca-certs').with(
        repo: 'cockroachdb/cockroach',
        tag: 'v20.1.1',
        command: ['cert', 'create-ca', '--certs-dir=/tmp', '--ca-key=/tmp/ca.key'],
        volumes_binds: ['/opt/cockroachdb/certs:/tmp']
      )
    end

    it 'creates the cockroach node certs' do
      # chef_run.node.automatic['hostname'] = 'hello'
      expect(chef_run).to run_if_missing_docker_container('create-cockroach-node-certs').with(
        repo: 'cockroachdb/cockroach',
        tag: 'v20.1.1',
        command: ['cert', 'create-node', 'Fauxhai', '--certs-dir=/tmp', '--ca-key=/tmp/ca.key'],
        volumes_binds: ['/opt/cockroachdb/certs:/tmp']
      )
    end

    it 'creates the cockroach client certs' do
      expect(chef_run).to run_if_missing_docker_container('create-cockroach-client-certs').with(
        repo: 'cockroachdb/cockroach',
        tag: 'v20.1.1',
        command: ['cert', 'create-client', 'root', '--certs-dir=/tmp', '--ca-key=/tmp/ca.key'],
        volumes_binds: ['/opt/cockroachdb/certs:/tmp']
      )
    end

    it 'starts cockroachdb' do
      expect(chef_run).to run_docker_container('cockroach-single-node').with(
        repo: 'cockroachdb/cockroach',
        tag: 'v20.1.1',
        command: ['start-single-node', '--certs-dir=/tmp'],
        volumes_binds: ['/opt/cockroachdb/certs:/tmp'],
        working_dir: '/cockroach',
        network_mode: 'host',
        ipc_mode: 'shareable',
        restart_policy: 'unless-stopped'
      )
    end

    command = 'CREATE USER cockroach WITH PASSWORD "cockroach";'

    it 'creates a cockroach user for UI access' do
      # chef_run.node.automatic['hostname'] = 'hello'
      expect(chef_run).to run_if_missing_docker_container('create-cockroach-user').with(
        repo: 'cockroachdb/cockroach',
        tag: 'v20.1.1',
        command: ['sql', '--user=root', '--certs-dir=/tmp', '--host=Fauxhai', "--execute=#{command}"],
        network_mode: 'host',
        volumes_binds: ['/opt/cockroachdb/certs:/tmp']
      )
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
