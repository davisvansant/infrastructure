# InSpec test for recipe infrastructure_kubeadm::pull_images

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

images = {
  'kube-apiserver' => 'v1.18.2',
  'kube-controller-manager' => 'v1.18.2',
  'kube-scheduler' => 'v1.18.2',
  'kube-proxy' => 'v1.18.2',
  'pause' => '3.2',
  'etcd' => '3.4.3-0',
  'coredns' => '1.6.7',
}

images.each do |image, version|
  describe docker_image(repo: 'k8s.gcr.io/' + image, tag: version) do
    it { should exist }
    its('image') { should eq 'k8s.gcr.io/' + "#{image}:#{version}" }
    its('repo') { should eq 'k8s.gcr.io/' + image }
    its('tag') { should eq version }
  end
end
