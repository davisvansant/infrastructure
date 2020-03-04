#
# Cookbook:: infrastructure_elasticsearch
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_elasticsearch::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'creates the elasticsearch systemd override directory' do
      expect(chef_run).to create_directory(
        '/etc/systemd/system/elasticsearch.service.d/').with(
        owner: 'root',
        group: 'root',
        mode: '0755',
        recursive: true
      )
    end

    it 'creates the elasticsearch systemd override file' do
      expect(chef_run).to create_template(
        '/etc/systemd/system/elasticsearch.service.d/override.conf').with(
        source: 'override.conf.erb',
        owner: 'root',
        group: 'root',
        mode: '0644'
      )
    end

    it 'creates the elasticsearch user' do
      expect(chef_run).to create_elasticsearch_user('elasticsearch')
    end

    it 'installs elasticsearch' do
      expect(chef_run).to install_elasticsearch('elasticsearch')
    end

    it 'configures elasticsearch' do
      expect(chef_run).to configure_elasticsearch_service('elasticsearch')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
