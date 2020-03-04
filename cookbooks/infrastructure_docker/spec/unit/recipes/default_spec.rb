#
# Cookbook:: infrastructure_docker
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_docker::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'should install Docker with specific version' do
      expect(chef_run).to create_docker_installation_package('default').with(version: '19.03.4')
    end

    it 'should configure dockerd' do
      expect(chef_run).to create_docker_service('default').with(
        exec_opts: ['native.cgroupdriver=systemd'],
        log_driver: 'json-file',
        log_opts: ['max-size=100m'],
        storage_driver: ['overlay2']
      )
    end

    it 'should start dockerd' do
      expect(chef_run).to start_docker_service('default')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
