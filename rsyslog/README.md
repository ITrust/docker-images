# Rsyslog Image

Docker image of Rsyslog v8.23.0 based on a Debian Jessie image whos main purpose is to be a network log relay.

This image comes with a basic configuration not logging container internal events and loading any additionnal configuration files within `/etc/rsyslog.d/` ending by the `.conf` extension.

rsyslog is installed with the following additionnal packets :

- `rsyslog-gnutls`
- `rsyslog-mysql`
- `rsyslog-pgsql`
- `rsyslog-elasticsearch`
- `rsyslog-mongodb`
- `rsyslog-relp`
- `rsyslog-kafka`
- `rsyslog-hiredis`

Rsyslog configuration will load any additionnal configuration files within `/etc/rsyslog.d/` ending by the `.conf` extension.