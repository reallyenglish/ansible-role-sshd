require 'spec_helper'
require 'serverspec'

package = 'sshd'
service = 'sshd'
config  = '/etc/ssh/sshd_config'
user    = 'sshd'
group   = 'sshd'
ports   = [ 22 ]
sftp_server = '/usr/lib/openssh/sftp-server'

case os[:family]
when 'freebsd'
  sftp_server = '/usr/libexec/sftp-server'
end

case os[:family]
when 'freebsd'
else
  describe package(package) do
    it { should be_installed }
  end 
end

describe file(config) do
  it { should be_file }
  its(:content) { should match /PermitRootLogin without-password/ }
  its(:content) { should match /PasswordAuthentication no/ }
  its(:content) { should match /UseDNS no/ }
  its(:content) { should match /UsePAM no/ }
  its(:content) { should match /Subsystem sftp #{ sftp_server }/ }
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
