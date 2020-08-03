#
# Cookbook:: infrastructure_nomad
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_nomad::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'adds the hashcorp apt_repository' do
      expect(chef_run).to add_apt_repository('nomad').with(
        arch: 'amd64',
        uri: 'https://apt.releases.hashicorp.com',
        key: ['https://apt.releases.hashicorp.com/gpg'],
        components: ['main'],
        distribution: 'xenial'
      )
    end

    it 'installs nomad' do
      expect(chef_run).to install_apt_package('nomad').with(
        version: '0.12.1'
      )
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
