# InSpec test for recipe infrastructure_cockroachdb::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

%w(
  /opt/cockroachdb
  /opt/cockroachdb/certs
).each do |dir|
  describe directory(dir) do
    it { should exist }
    it { should be_directory }
    its('mode') { should cmp '0755' }
    it { should be_owned_by 'root' }
  end
end

describe docker_image('cockroachdb/cockroach:v20.1.1') do
  it { should exist }
  its('repo') { should eq 'cockroachdb/cockroach' }
  its('tag') { should eq 'v20.1.1' }
end

describe docker_container('create-cockroach-ca-certs') do
  it { should exist }
  it { should_not be_running }
  its('image') { should eq 'cockroachdb/cockroach:v20.1.1' }
  its('repo') { should eq 'cockroachdb/cockroach' }
  its('tag') { should eq 'v20.1.1' }
  its('ports') { should eq '' }
  its('command') { should eq '/cockroach/cockroach.sh cert create-ca --certs-dir=/tmp --ca-key=/tmp/ca.key' }
end

describe docker_container('create-cockroach-node-certs') do
  it { should exist }
  it { should_not be_running }
  its('image') { should eq 'cockroachdb/cockroach:v20.1.1' }
  its('repo') { should eq 'cockroachdb/cockroach' }
  its('tag') { should eq 'v20.1.1' }
  its('ports') { should eq '' }
  its('command') { should eq  '/cockroach/cockroach.sh cert create-node default-ubuntu-1804 --certs-dir=/tmp --ca-key=/tmp/ca.key' }
end

describe docker_container('create-cockroach-client-certs') do
  it { should exist }
  it { should_not be_running }
  its('image') { should eq 'cockroachdb/cockroach:v20.1.1' }
  its('repo') { should eq 'cockroachdb/cockroach' }
  its('tag') { should eq 'v20.1.1' }
  its('ports') { should eq '' }
  its('command') { should eq '/cockroach/cockroach.sh cert create-client root --certs-dir=/tmp --ca-key=/tmp/ca.key' }
end

describe docker_container('cockroach-single-node') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'cockroachdb/cockroach:v20.1.1' }
  its('repo') { should eq 'cockroachdb/cockroach' }
  its('tag') { should eq 'v20.1.1' }
  its('ports') { should eq '' }
  its('command') { should eq '/cockroach/cockroach.sh start-single-node --certs-dir=/tmp' }
end

command = 'CREATE USER cockroach WITH PASSWORD \\"cockroach\\";'

describe docker_container('create-cockroach-user') do
  it { should exist }
  it { should_not be_running }
  its('image') { should eq 'cockroachdb/cockroach:v20.1.1' }
  its('repo') { should eq 'cockroachdb/cockroach' }
  its('tag') { should eq 'v20.1.1' }
  its('ports') { should eq '' }
  its('command') { should eq "/cockroach/cockroach.sh sql --user=root --certs-dir=/tmp --host=default-ubuntu-1804 '--execute=#{command}'" }
end
