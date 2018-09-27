require 'rspec-puppet-facts'
include RspecPuppetFacts

require 'rspec/support/ruby_features'
require 'spec_helper'

RSpec.configure do |c|
  c.enable_pathname_stubbing = true
end
WINDOWS = defined?(RSpec::Support) ? RSpec::Support::OS.windows? : !File::ALT_SEPARATOR.nil?

add_custom_fact :puppet_vardir, ->(os, _facts) do
  if os =~ %r{windows.*}
    'C:/ProgramData/PuppetLabs/puppet/var'
  else
    '/var/lib/puppet'
  end
end
add_custom_fact :identity, ->(os, _facts) do
  if os =~ %r{windows.*}
    user = 'MYDOMAIN\\Administrator'
    group = nil
    privileged = true
  else
    user = 'root'
    group = 'root'
    privileged = true
  end
  {
    'user' => user,
    'group' => group,
    'privileged' => privileged,
  }
end