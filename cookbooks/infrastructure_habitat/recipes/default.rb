#
# Cookbook:: infrastructure_habitat
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

hab_install 'infrastructure_habitat' do
  license 'accept'
  hab_version '1.6.0'
end
