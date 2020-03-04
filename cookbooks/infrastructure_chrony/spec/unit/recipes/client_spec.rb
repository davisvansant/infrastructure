#
# Cookbook:: infrastructure_chrony
# Spec:: client
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_chrony::client' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'includes the chrony::client recipe' do
      stub_search(:node, 'recipes:chrony\\:\\:master').and_return([])
      expect(chef_run).to include_recipe('chrony::client')
    end

    it 'converges successfully' do
      stub_search(:node, 'recipes:chrony\\:\\:master').and_return([])
      expect { chef_run }.to_not raise_error
    end
  end
end
