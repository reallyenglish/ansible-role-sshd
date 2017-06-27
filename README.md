# ansible-role-sshd

Configure sshd.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `sshd_user` | user name of `sshd` | `sshd` |
| `sshd_group` | group name of `sshd` | `{{ __sshd_group }}` |
| `sshd_service` | service name of `sshd` | `{{ __sshd_service }}` |
| `sshd_conf_dir` | path to directory where `sshd` configuration files are kept | `{{ __sshd_conf_dir }}` |
| `sshd_conf` | path to `sshd_config` | `{{ sshd_conf_dir }}/sshd_config` |
| `sshd_sftp_server` | path to `stfp-server(8)` | `{{ __sshd_sftp_server }}` |
| `sshd_config` | dict of `sshd_config` | `{"PermitRootLogin"=>"without-password", "PasswordAuthentication"=>"no", "UseDNS"=>"no", "UsePAM"=>"no", "Subsystem"=>"sftp {{ sshd_sftp_server }}"}` |
| `sshd_config_pre` | string of `sshd_config(5)` before `sshd_config` | `""` |
| `sshd_config_post` | string of `sshd_config(5)` after `sshd_config` | `""` |
| `sshd_config_match` | list of `Match` keyword. see below | `[]` |

## `ssh_config_match`

This variable is a list of dict, creates `Match` blocks.

| Key | value |
|-----|-------|
| `condition` | condition of the `Match` |
| `keyword` | dict of directives and values pair |

An example:

```yaml
sshd_config_match:
  - condition: User foo
    keyword:
      X11Forwarding: "yes"
```

Which generates a block:

```yaml
Match User foo
  X11Forwarding yes
```

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
      Port: 22
      UseDNS: "no"
      UsePAM: "no"
      Subsystem: "sftp {{ sshd_sftp_server }}"
    sshd_config_match:
      - condition: User foo
        keyword:
          X11Forwarding: "yes"
      - condition: User bar
        keyword:
          X11Forwarding: "no"
    sshd_config_pre: |
      Port 2022
    sshd_config_post: |
      Match Address 192.168.1.1
        PasswordAuthentication yes
```

# License

```
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
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [ansible-role-init](https://gist.github.com/trombik/d01e280f02c78618429e334d8e4995c0)
