## SSL certificates
```
mkdir certs
cd certs
openssl genrsa -des3 -out myCA.key 2048
passphrase: password
openssl req -x509 -new -nodes -key myCA.key -sha256 -days 1825 -out myCA.pem
enter: password
sudo apt-get install -y ca-certificates
sudo cp myCA.pem /usr/local/share/ca-certificates/myCA.crt
sudo update-ca-certificates
awk -v cmd='openssl x509 -noout -subject' '/BEGIN/{close(cmd)};{print | cmd}' < /etc/ssl/certs/ca-certificates.crt | grep VS

openssl genrsa -out hellfish.test.key 2048
openssl req -new -key hellfish.test.key -out hellfish.test.csr
vi hellfish.test.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
IP.0 = 192.168.31.209
DNS.0 = localhost

openssl x509 -req -in hellfish.test.csr -CA myCA.pem -CAkey myCA.key \
-CAcreateserial -out hellfish.test.crt -days 825 -sha256 -extfile hellfish.test.ext

cp hellfish.test.crt /home/vahid/git/mytubeweb_zio/src/main/resources/
cp hellfish.test.key /home/vahid/git/mytubeweb_zio/src/main/resources/
```