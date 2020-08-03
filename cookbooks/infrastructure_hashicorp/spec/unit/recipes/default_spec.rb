#
# Cookbook:: infrastructure_hashicorp
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_hashicorp::default' do
  context 'When all attributes are default, on Ubuntu 20.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '20.04'

    it 'adds the hashcorp apt_repository' do
      expect(chef_run).to add_apt_repository('hashicorp').with(
        arch: 'amd64',
        uri: 'https://apt.releases.hashicorp.com',
        key: ['https://apt.releases.hashicorp.com/gpg'],
        components: ['main'],
        distribution: 'focal'
      )
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'adds the hashcorp apt_repository' do
      expect(chef_run).to add_apt_repository('hashicorp').with(
        arch: 'amd64',
        uri: 'https://apt.releases.hashicorp.com',
        key: ['https://apt.releases.hashicorp.com/gpg'],
        components: ['main'],
        distribution: 'bionic'
      )
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
