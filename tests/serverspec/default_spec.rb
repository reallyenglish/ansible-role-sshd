require "spec_helper"

package = "openssh-server"
service = "sshd"
config  = "/etc/ssh/sshd_config"
ports   = [22]
sftp_server = "/usr/lib/sftp-server"
default_user = "root"
default_group = "root"

case os[:family]
when "freebsd", "openbsd"
  sftp_server = "/usr/libexec/sftp-server"
  default_group = "wheel"
when "ubuntu"
  service = "ssh"
when "redhat"
  service = "sshd.service"
end

if os[:family] != "freebsd" && os[:family] != "openbsd"
  describe package(package) do
    it { should be_installed }
  end
end

describe file(config) do
  it { should exist }
  it { should be_file }
  it { should be_mode os[:family] == "redhat" ? 600 : 644 }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  its(:content) { should match(/^PermitRootLogin without-password$/) }
  its(:content) { should match(/^PasswordAuthentication no$/) }
  its(:content) { should match(/^UseDNS no$/) }
  its(:content) { should match(/^Subsystem sftp #{ sftp_server }$/) }
  case os[:family]
  when "openbsd"
    its(:content) { should_not match(/^UsePAM no$/) }
  else
    its(:content) { should match(/^UsePAM no$/) }
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
