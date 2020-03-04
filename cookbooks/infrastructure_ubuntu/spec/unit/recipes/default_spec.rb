#
# Cookbook:: infrastructure_ubuntu
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_ubuntu::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'includes the ubuntu::default recipe' do
      expect(chef_run).to include_recipe('ubuntu::default')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
