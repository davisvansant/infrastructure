#
# Cookbook:: infrastructure_vault
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_vault::default' do
  context 'When all attributes are default, on Ubuntu 20.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '20.04'

    it 'includes the infrastructure_hashicorp::default recipe' do
      expect(chef_run).to include_recipe('infrastructure_hashicorp::default')
    end

    it 'installs hashicorp vault' do
      expect(chef_run).to install_apt_package('vault').with(
        version: '1.5.0'
      )
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on Ubuntu 20.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'includes the infrastructure_hashicorp::default recipe' do
      expect(chef_run).to include_recipe('infrastructure_hashicorp::default')
    end

    it 'installs hashicorp vault' do
      expect(chef_run).to install_apt_package('vault').with(
        version: '1.5.0'
      )
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
