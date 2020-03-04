#
# Cookbook:: infrastructure_java
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_java::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'includes the java::default recipe' do
      expect(chef_run).to include_recipe('java::default')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
