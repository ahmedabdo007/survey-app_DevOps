#Install Python
echo "--------------------Installing Python--------------------"
sudo apt-get update -y
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update -y
sudo apt-get install python3.8 -y 
#Install Pip
echo "--------------------Installing Pip--------------------"
sudo apt-get update -y
sudo apt-get install python3-pip -y 
#Install docker
echo "--------------------Installing Docker--------------------"
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update -y 
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
#Add docker to sudo group
echo "--------------------Add Docker to Sudo group--------------------"
sudo groupadd docker && sudo usermod -aG docker $USER && newgrp docker && sudo chmod 777 /var/run/docker.sock
#run the countainer 
echo "--------------------run the countainer --------------------"
sudo docker run  -p 8081:80 -d  ahmedabdoahmed/survey-app-img:1.1
