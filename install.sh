#!/bin/bash

set -e

TOOLS=(
    "subfinder"
    "amass"
    "puredns"
    "httpx"
    "dnsx"
    "assetfinder"
    "httprobe"
    "gau"
    "waybackurls"
    "katana"
    "hakrawler"
    "anew"
    "gf"
    "gospider"
    "paramspider"
    "nuclei"
    "arjun"
    "dalfox"
    "massdns"
    "bbot"
)

INSTALL_DIR="/usr/local/bin"

# Function to check if a tool is installed
check_tool() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install a tool
install_tool() {
    tool=$1
    echo "[+] Installing $tool..."
    case $tool in
        "subfinder")
            go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && mv ~/go/bin/subfinder $INSTALL_DIR/
            ;;
        "amass")
            go install github.com/owasp-amass/amass/v4@latest && mv ~/go/bin/amass $INSTALL_DIR/
            ;;
        "puredns")
            go install github.com/d3mondev/puredns/v2@latest && mv ~/go/bin/puredns $INSTALL_DIR/
            ;;
        "httpx")
            if check_tool "httpx"; then
                echo "[!] Removing existing httpx installation..."
                sudo rm -f "$(which httpx)"
            fi
            go install github.com/projectdiscovery/httpx/cmd/httpx@latest && mv ~/go/bin/httpx $INSTALL_DIR/
            ;;
        "dnsx")
            go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest && mv ~/go/bin/dnsx $INSTALL_DIR/
            ;;
        "assetfinder")
            go install github.com/tomnomnom/assetfinder@latest && mv ~/go/bin/assetfinder $INSTALL_DIR/
            ;;
        "httprobe")
            go install github.com/tomnomnom/httprobe@latest && mv ~/go/bin/httprobe $INSTALL_DIR/
            ;;
        "gau")
            go install github.com/lc/gau/v2/cmd/gau@latest && mv ~/go/bin/gau $INSTALL_DIR/
            ;;
        "waybackurls")
            go install github.com/tomnomnom/waybackurls@latest && mv ~/go/bin/waybackurls $INSTALL_DIR/
            ;;
        "katana")
            go install github.com/projectdiscovery/katana/cmd/katana@latest && mv ~/go/bin/katana $INSTALL_DIR/
            ;;
        "hakrawler")
            go install github.com/hakluke/hakrawler@latest && mv ~/go/bin/hakrawler $INSTALL_DIR/
            ;;
        "anew")
            go install github.com/tomnomnom/anew@latest && mv ~/go/bin/anew $INSTALL_DIR/
            ;;
        "gf")
            go install github.com/tomnomnom/gf@latest && mv ~/go/bin/gf $INSTALL_DIR/
            ;;
        "gospider")
            go install github.com/jaeles-project/gospider@latest && mv ~/go/bin/gospider $INSTALL_DIR/
            ;;
        "paramspider")
            sudo apt update && sudo apt install -y paramspider
            ;;
        "nuclei")
            go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest && mv ~/go/bin/nuclei $INSTALL_DIR/
            ;;
        "arjun")
            sudo apt update && sudo apt install -y arjun
            ;;
        "dalfox")
            go install github.com/hahwul/dalfox/v2@latest && mv ~/go/bin/dalfox $INSTALL_DIR/
            ;;
        "massdns")
            echo "[+] Installing MassDNS..."
            sudo apt install massdns 
            ;;
        "bbot")
            echo "[+] Installing bbot using pipx..."
            sudo apt update && sudo apt install -y pipx
            pipx install bbot
            ;;
        *)
            echo "[!] Unknown tool: $tool"
            ;;
    esac
}

# Ensure Go is installed
if ! check_tool go; then
    echo "[!] Go is not installed. Installing..."
    sudo apt update && sudo apt install -y golang
fi

# Install missing tools
for tool in "${TOOLS[@]}"; do
    if ! check_tool "$tool"; then
        install_tool "$tool"
    else
        echo "[✔] $tool is already installed."
    fi
done

# Install GF patterns
if [ -d "$HOME/.gf" ]; then
    echo "[✔] GF patterns directory found."
else
    echo "[+] Installing GF patterns..."
    mkdir -p "$HOME/.gf"
    git clone https://github.com/1ndianl33t/Gf-Patterns "$HOME/.gf"
fi

echo "[+] All tools installed successfully."
