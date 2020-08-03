# InSpec test for recipe infrastructure_hashicorp::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

if os.release == '18.04'
  describe file('/etc/apt/sources.list.d/hashicorp.list') do
    it { should exist }
    its('content') { should match(%r{deb      \[arch=amd64] https:\/\/apt.releases.hashicorp.com\/ bionic main}) }
  end
end

if os.release == '20.04'
  describe file('/etc/apt/sources.list.d/hashicorp.list') do
    it { should exist }
    its('content') { should match(%r{deb      \[arch=amd64] https:\/\/apt.releases.hashicorp.com\/ focal main}) }
  end
end
