# InSpec test for recipe infrastructure_artifactory::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe group('artifactory') do
  it { should exist }
  its('gid') { should eq 1030 }
end

describe user('artifactory') do
  it { should exist }
  its('uid') { should eq 1030 }
  its('gid') { should eq 1030 }
end

%w(
  /opt/artifactory
  /opt/artifactory/var
  /opt/artifactory/var/etc
).each do |dir|
  describe directory(dir) do
    it { should exist }
    it { should be_directory }
    its('mode') { should cmp '0755' }
    it { should be_owned_by 'artifactory' }
  end
end

describe docker_image('docker.bintray.io/jfrog/artifactory-oss:7.4.3') do
  it { should exist }
  its('repo') { should eq 'docker.bintray.io/jfrog/artifactory-oss' }
  its('tag') { should eq '7.4.3' }
end

describe docker_container('artifactory') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'docker.bintray.io/jfrog/artifactory-oss:7.4.3' }
  its('repo') { should eq 'docker.bintray.io/jfrog/artifactory-oss' }
  its('tag') { should eq '7.4.3' }
  its('ports') { should eq '0.0.0.0:8081-8082->8081-8082/tcp' }
  its('command') { should eq '/entrypoint-artifactory.sh' }
end
