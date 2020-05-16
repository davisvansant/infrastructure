#
# Cookbook:: infrastructure_habitat
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_habitat::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs habitat' do
      expect(chef_run).to install_hab_install('infrastructure_habitat').with(
        license: 'accept',
        hab_version: '1.6.0'
      )
    end
  end
end
