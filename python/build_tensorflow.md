# build tensorflow
```shell
sudo apt update
sudo apt install -y python3-dev python3-pip git zip unzip \
                    build-essential cmake libcupti-dev wget \
                    libfreetype6-dev libhdf5-dev libssl-dev \
                    openjdk-11-jdk

# For TF 2.15
sudo apt install apt-transport-https curl gnupg
curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
sudo mv bazel-archive-keyring.gpg /usr/share/keyrings
echo "deb [signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
sudo apt update
sudo apt install bazel-6.4.0  # or latest compatible with TF version
sudo apt install bazel-bootstrap

cd ~/git
git clone https://github.com/tensorflow/tensorflow.git
cd ~/git/tensorflow
git checkout r2.16  # or desired version

./configure

```
