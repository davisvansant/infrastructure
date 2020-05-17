#
# Cookbook:: infrastructure_kubeadm
# Recipe:: default
#
# Copyright:: 2020, Davis Van Sant, All Rights Reserved.

kubernetes_version = '1.18.2-00'
kubernetes = {
  'kubelet' => kubernetes_version,
  'kubeadm' => kubernetes_version,
  'kubectl' => kubernetes_version,
}

apt_repository 'infrastructure_kubeadm' do
  components ['main']
  distribution 'kubernetes-xenial'
  key 'https://packages.cloud.google.com/apt/doc/apt-key.gpg'
  uri 'https://apt.kubernetes.io/'
end

kubernetes.each do |package, version|
  package package do
    version version
  end
end
