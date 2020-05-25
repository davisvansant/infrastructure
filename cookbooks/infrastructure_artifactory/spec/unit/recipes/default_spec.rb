#
# Cookbook:: infrastructure_artifactory
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_artifactory::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'includes the infrastructure_docker::default recipe' do
      expect(chef_run).to include_recipe('infrastructure_docker::default')
    end

    it 'creates the artifactory/1030 group' do
      expect(chef_run).to create_group('artifactory').with(
        gid: 1030
      )
    end

    it 'creates the artifactory/1030 user' do
      expect(chef_run).to create_user('artifactory').with(
        uid: 1030,
        gid: 1030
      )
    end

    %w(
      /opt/artifactory
      /opt/artifactory/var
      /opt/artifactory/var/etc
    ).each do |dir|
      it "creates the artifactory #{dir} directory" do
        expect(chef_run).to create_directory(dir).with(
          owner: 1030,
          group: 1030,
          mode: '0755'
        )
      end
    end

    it 'pulls the artifactory docker image' do
      expect(chef_run).to pull_docker_image('docker.bintray.io/jfrog/artifactory-oss').with(
        tag: '7.4.3'
      )
    end

    it 'runs the artifactory container' do
      expect(chef_run).to run_docker_container('artifactory').with(
        repo: 'docker.bintray.io/jfrog/artifactory-oss',
        tag: '7.4.3',
        port: ['8081:8081', '8082:8082'],
        volumes_binds: ['/opt/artifactory/var/:/var/opt/jfrog/artifactory'],
        ipc_mode: 'shareable',
        user: 'artifactory',
        working_dir: '/opt/jfrog/artifactory'
      )
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
