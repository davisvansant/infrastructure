#
# Cookbook:: infrastructure_kubeadm
# Spec:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

require 'spec_helper'

describe 'infrastructure_kubeadm::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    kubernetes_version = '1.18.2-00'
    kubernetes = {
      'kubelet' => kubernetes_version,
      'kubeadm' => kubernetes_version,
      'kubectl' => kubernetes_version,
    }

    it 'adds the kubernetes apt repository' do
      expect(chef_run).to add_apt_repository('infrastructure_kubeadm').with(
        components: ['main'],
        distribution: 'kubernetes-xenial',
        key: ['https://packages.cloud.google.com/apt/doc/apt-key.gpg'],
        uri: 'https://apt.kubernetes.io/'
      )
    end

    kubernetes.each do |package, version|
      it "installs the kubernetes #{package} package" do
        expect(chef_run).to install_package(package).with(
          version: version
        )
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
