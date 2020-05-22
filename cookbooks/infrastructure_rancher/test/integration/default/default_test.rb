# InSpec test for recipe infrastructure_rancher::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe docker_image('rancher/rancher:v2.4.3') do
  it { should exist }
  its('repo') { should eq 'rancher/rancher' }
  its('tag') { should eq 'v2.4.3' }
end

describe docker_container('rancher') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'rancher/rancher:v2.4.3' }
  its('repo') { should eq 'rancher/rancher' }
  its('tag') { should eq 'v2.4.3' }
  its('ports') { should eq '0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp' }
  its('command') { should eq 'entrypoint.sh' }
end
