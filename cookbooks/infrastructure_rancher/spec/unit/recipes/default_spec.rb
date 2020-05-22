#
# Cookbook:: infrastructure_rancher
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_rancher::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'pulls the rancher image down' do
      expect(chef_run).to pull_docker_image('rancher/rancher').with(
        tag: 'v2.4.3'
      )
    end

    it 'runs the rancher container' do
      expect(chef_run).to run_docker_container('rancher').with(
        repo: 'rancher/rancher',
        tag: 'v2.4.3',
        port: ['80:80', '443:443'],
        restart_policy: 'unless-stopped'
      )
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
