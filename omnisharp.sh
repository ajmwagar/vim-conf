# Download tar
curl -LO https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.29.1/omnisharp.http-linux-x64.tar.gz

# Extract
tar -gz omnisharp.http-linux-x64.tar.gz

# Move omni executable into folder
mkdir omni
mv omnisharp.http-linux-x64 ./omni/

yaourt -S dotnet-sdk
