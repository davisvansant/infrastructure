# InSpec test for recipe infrastructure_redis::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe service('redis@6379') do
  it { should be_enabled }
  it { should be_installed }
  it { should be_running }
end
