## Setup postfix

```
#Gmail settings: https://support.google.com/mail/answer/7126229?hl=en#zippy=%2Cstep-change-smtp-other-settings-in-your-email-client
yum install postfix

#configure /etc/postfix/main.cf
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes 
smtp_sasl_security_options = noanonymous 
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_tls_CAfile = /etc/ssl/certs/ca-bundle.crt
smtp_use_tls = yes
inet_protocols = ipv4

#steps to generate app password: https://support.google.com/accounts/answer/185833?sjid=2460604110526822821-AP#zippy=%2Cwhy-you-may-need-an-app-password

#configure /etc/postfix/sasl_passwd
[smtp.gmail.com]:587 service.alerts.noreply@gmail.com:<app-password>

cd /etc/postfix/
sudo postmap sasl_passwd

sudo systemctl restart postfix

echo "This is a test email." | mail -r service.alerts.noreply@gmail.com -s "Test email" meet2vah1d@gmail.com

sendmail meet2vah1d@gmail.com
From: service.alerts.noreply@gmail.com
Subject: Test mail
This is a test email
.

```
