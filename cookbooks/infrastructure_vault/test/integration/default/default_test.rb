# InSpec test for recipe infrastructure_vault::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe package('vault') do
  it { should be_installed }
  its('version') { should eq '1.5.0' }
end
