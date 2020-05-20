#
# Cookbook:: infrastructure_kubeadm
# Spec:: pull_images
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_kubeadm::pull_images' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'pulls the kubernetes images' do
      expect(chef_run).to run_execute('kubeadm config images pull').with(
        live_stream: true
      )
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
