# InSpec test for recipe infrastructure_kubeadm::single_node

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe directory('/var/lib/kubelet/') do
  it { should exist }
  it { should be_directory }
end

describe file('/var/lib/kubelet/kubeadm-flags.env') do
  it { should exist }
  it { should be_file }
end

describe file('/var/lib/kubelet/config.yaml') do
  it { should exist }
  it { should be_file }
end

describe service('kubelet') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

apiserver = %w(
  apiserver.crt
  apiserver-etcd-client.crt
  apiserver-etcd-client.key
  apiserver.key
  apiserver-kubelet-client.crt
  apiserver-kubelet-client.key
)

ca = %w(
  ca.crt
  ca.key
)

etcd = %w(
  ca.crt
  ca.key
  healthcheck-client.crt
  healthcheck-client.key
  peer.crt
  peer.key
  server.crt
  server.key
)

front_proxy = %w(
  front-proxy-ca.crt
  front-proxy-ca.key
  front-proxy-client.crt
  front-proxy-client.key
)

sa = %w(
  sa.key
  sa.pub
)

describe directory('/etc/kubernetes/pki') do
  it { should exist }
  it { should be_directory }
end

apiserver.each do |cert|
  describe file('/etc/kubernetes/pki/' + cert) do
    it { should exist }
    it { should be_file }
  end
end

ca.each do |cert|
  describe file('/etc/kubernetes/pki/' + cert) do
    it { should exist }
    it { should be_file }
  end
end

describe directory('/etc/kubernetes/pki/etcd') do
  it { should exist }
  it { should be_directory }
end

etcd.each do |cert|
  describe file('/etc/kubernetes/pki/etcd/' + cert) do
    it { should exist }
    it { should be_file }
  end
end

front_proxy.each do |cert|
  describe file('/etc/kubernetes/pki/' + cert) do
    it { should exist }
    it { should be_file }
  end
end

sa.each do |cert|
  describe file('/etc/kubernetes/pki/' + cert) do
    it { should exist }
    it { should be_file }
  end
end

kubeconfig = %w(
  admin.conf
  controller-manager.conf
  kubelet.conf
  scheduler.conf
)

kubeconfig.each do |conf|
  describe file('/etc/kubernetes/' + conf) do
    it { should exist }
    it { should be_file }
  end
end

describe directory('/etc/kubernetes/manifests') do
  it { should exist }
  it { should be_directory }
end

manifests = %w(
  etcd.yaml
  kube-apiserver.yaml
  kube-controller-manager.yaml
  kube-scheduler.yaml
)

manifests.each do |yaml|
  describe file('/etc/kubernetes/manifests/' + yaml) do
    it { should exist }
    it { should be_file }
  end
end
