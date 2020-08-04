# InSpec test for recipe infrastructure_consul::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe package('consul') do
  it { should be_installed }
  its('version') { should eq '1.8.0' }
end
