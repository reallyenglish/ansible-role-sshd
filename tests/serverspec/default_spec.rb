require 'spec_helper'

package = 'openssh-server'
service = 'sshd'
config  = '/etc/ssh/sshd_config'
user    = 'sshd'
group   = 'sshd'
ports   = [ 22 ]
sftp_server = '/usr/lib/sftp-server'

case os[:family]
when 'freebsd', 'openbsd'
  sftp_server = '/usr/libexec/sftp-server'
when 'ubuntu'
  service = 'ssh'
when 'centos'
  service = 'sshd.service'
end

case os[:family]
when 'freebsd', 'openbsd'
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
  its(:content) { should match /Subsystem sftp #{ sftp_server }/ }
  case os[:family]
  when 'openbsd'
    its(:content) { should_not match /UsePAM no/ }
  else
    its(:content) { should match /UsePAM no/ }
  end
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
