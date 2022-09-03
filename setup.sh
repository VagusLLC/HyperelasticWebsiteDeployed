#!/bin/bash
# Update and Upgrade
sudo apt update
sudo apt upgrade -y
# Install Github CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg 
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null 
sudo apt update 
sudo apt install gh -y
gh auth login
# Install Julia
wget https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.0-linux-x86_64.tar.gz
tar -xvf julia-1.8.0-linux-x86_64.tar.gz
sudo ln -s ~/julia-1.8.0/bin/julia /usr/local/bin/julia
rm julia-1.8.0-linux-x86_64.tar.gz
julia -e ''
mkdir .julia/dev
cd .julia/dev
gh repo clone TRACER-LULab/Hyperelastics.jl Hyperelastics
gh repo clone TRACER-LULab/InverseLangevinApproximations.jl InverseLangevinApproximations
cd
gh repo clone cfarm6/HyperelasticWebsiteDeployed
# Create Temp Service
TEMPFILE=$(mktemp)
cat > $TEMPFILE << __EOF__
[Unit]
After=network.service

StartLimitIntervalSec=500
StartLimitBurst=5

[Service]
ExecStart=/usr/local/bin/pluto-slider-server.sh
Restart=always
RestartSec=5

[Install]
WantedBy=default.target
__EOF__

sudo mv $TEMPFILE /etc/systemd/system/pluto-server.service
# Create the startup script
TEMPFILE=$(mktemp)
cat > $TEMPFILE << __EOF__
#!/bin/bash
cd /root/HyperelasticWebsiteDeployed  # Make sure to change to the absolute path to your repository. Don't use ~.
julia --project="pluto-slider-server-environment" -e "import Pkg; Pkg.instantiate(); import PlutoSliderServer; PlutoSliderServer.run_git_directory(\".\")"
__EOF__

sudo mv $TEMPFILE /usr/local/bin/pluto-slider-server.sh

sudo chmod 744 /usr/local/bin/pluto-slider-server.sh
sudo chmod 664 /etc/systemd/system/pluto-server.service

sudo systemctl daemon-reload
sudo systemctl start pluto-server
sudo systemctl enable pluto-server