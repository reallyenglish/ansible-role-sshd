# ansible-role-sshd

Configure sshd.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| sshd\_user | user | sshd |
| sshd\_group | group | {{ \_\_sshd\_group }} |
| sshd\_service | service name | {{ \_\_sshd\_service }} |
| sshd\_conf\_dir | path to config dir | {{ \_\_sshd\_conf\_dir }} |
| sshd\_conf | path to `sshd_config(5)` | {{ sshd\_conf\_dir }}/sshd\_config |
| sshd\_sftp\_server | path to sftp binary | {{ \_\_sshd\_sftp\_server }} |
| sshd\_config | default `ssh_config(5)` | {"PermitRootLogin"=>"without-password", "PasswordAuthentication"=>"no", "UseDNS"=>"no", "UsePAM"=>"no", "Subsystem"=>"sftp {{ sshd\_sftp\_server }}"} |

| Variable | Description | Default |
|----------|-------------|---------|
| `sshd_user` | user name of `sshd` | `sshd` |
| `sshd_group` | group name of `sshd` | `{{ __sshd_group }}` |
| `sshd_service` | service name of `sshd` | `{{ __sshd_service }}` |
| `sshd_conf_dir` | path to directory where `sshd` configuration files are kept | `{{ __sshd_conf_dir }}` |
| `sshd_conf` | path to `sshd_config` | `{{ sshd_conf_dir }}/sshd_config` |
| `sshd_sftp_server` | path to `stfp-server(8)` | `{{ __sshd_sftp_server }}` |
| `sshd_config` | dict of `sshd_config` | `{"PermitRootLogin"=>"without-password", "PasswordAuthentication"=>"no", "UseDNS"=>"no", "UsePAM"=>"no", "Subsystem"=>"sftp {{ sshd_sftp_server }}"}` |

## Debian

| Variable | Default |
|----------|---------|
| `__sshd_group` | `ssh` |
| `__sshd_conf_dir` | `/etc/ssh` |
| `__sshd_sftp_server` | `/usr/lib/sftp-server` |
| `__sshd_service` | `ssh` |

## FreeBSD

| Variable | Default |
|----------|---------|
| `__sshd_group` | `sshd` |
| `__sshd_conf_dir` | `/etc/ssh` |
| `__sshd_sftp_server` | `/usr/libexec/sftp-server` |
| `__sshd_service` | `sshd` |

## OpenBSD

| Variable | Default |
|----------|---------|
| `__sshd_group` | `sshd` |
| `__sshd_conf_dir` | `/etc/ssh` |
| `__sshd_sftp_server` | `/usr/libexec/sftp-server` |
| `__sshd_service` | `sshd` |

## RedHat

| Variable | Default |
|----------|---------|
| `__sshd_group` | `ssh` |
| `__sshd_conf_dir` | `/etc/ssh` |
| `__sshd_sftp_server` | `/usr/lib/sftp-server` |
| `__sshd_service` | `sshd.service` |

# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-sshd
  vars:
    sshd_config:
      PermitRootLogin: without-password
      PasswordAuthentication: "no"
      UseDNS: "no"
      UsePAM: "no"
      Subsystem: "sftp {{ sshd_sftp_server }}"
```

# License

Copyright (c) 2016 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [ansible-role-init](https://gist.github.com/trombik/d01e280f02c78618429e334d8e4995c0)
