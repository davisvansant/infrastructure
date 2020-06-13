# InSpec test for recipe infrastructure_kong::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe docker_image('postgres:12.3') do
  it { should exist }
  its('repo') { should eq 'postgres' }
  its('tag') { should eq '12.3' }
end

describe docker_image('kong:2.0.4') do
  it { should exist }
  its('repo') { should eq 'kong' }
  its('tag') { should eq '2.0.4' }
end

describe docker_container('postgres') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'postgres:12.3' }
  its('repo') { should eq 'postgres' }
  its('tag') { should eq '12.3' }
  its('ports') { should eq '0.0.0.0:5432->5432/tcp' }
  its('command') { should eq 'docker-entrypoint.sh postgres' }
end

describe docker_container('kong') do
  it { should exist }
  it { should be_running }
  its('image') { should eq 'kong:2.0.4' }
  its('repo') { should eq 'kong' }
  its('tag') { should eq '2.0.4' }
  its('ports') { should eq '0.0.0.0:8000-8001->8000-8001/tcp, 0.0.0.0:8443-8444->8443-8444/tcp' }
  its('command') { should eq '/docker-entrypoint.sh kong docker-start' }
end
