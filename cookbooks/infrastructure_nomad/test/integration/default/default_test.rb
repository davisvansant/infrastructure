# InSpec test for recipe infrastructure_nomad::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe package('nomad') do
  it { should be_installed }
  its('version') { should eq '0.12.1' }
end
