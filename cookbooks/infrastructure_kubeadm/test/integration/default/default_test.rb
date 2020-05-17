# InSpec test for recipe infrastructure_kubeadm::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

kubernetes_version = '1.18.2-00'
kubernetes = {
  'kubelet' => kubernetes_version,
  'kubeadm' => kubernetes_version,
  'kubectl' => kubernetes_version,
}

kubernetes.each do |package, version|
  describe package(package) do
    it { should be_installed }
    its('version') { should eq version }
  end
end
