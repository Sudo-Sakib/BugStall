#!/bin/bash

set -e

TOOLS=(
    "subfinder"       # Subdomain discovery
    "amass"           # Network mapping and attack surface detection
    "puredns"         # DNS validation tool
    "httpx"           # HTTP toolkit
    "dnsx"            # DNS toolkit
    "assetfinder"     # Find related domains
    "httprobe"        # Probe HTTP services
    "gau"             # Fetch known URLs
    "waybackurls"     # Extract Wayback Machine URLs
    "katana"          # Crawling and spidering
    "hakrawler"       # Fast web crawler
    "anew"            # Add new lines to files
    "gf"              # Pattern matching
    "gospider"        # Web spider
    "paramspider"     # Parameter discovery
    "nuclei"          # Vulnerability scanner
    "arjun"           # HTTP parameter discovery
    "dalfox"          # XSS scanning
    "massdns"         # High-performance DNS stub resolver
    "bbot"            # OSINT automation
    "ffuf"            # Web fuzzing
    "nmap"            # Network scanning
    "sqlmap"          # SQL injection automation
    "wpscan"          # WordPress vulnerability scanner
    "dirsearch"       # Web path scanner
    "feroxbuster"     # Content discovery tool
    "seclists"        # Security testing wordlists
    "findomain"       # Cross-platform subdomain enumerator
    "meg"             # Fetch paths with parallel execution
    "knocker"         # Port Scanner
    "xsser"        # Advanced XSS detection
    "dnsgen"          # DNS wordlist generator
    "hakcheckurl"     # Validate URLs
    "uncover"         # API-based discovery
    "interactsh-client" # OOB interaction client
    "metabigor"       # OSINT intelligence tool
    "shuffledns"      # MassDNS wrapper
    "trufflehog"      # Secrets scanning
    "subjack"         # Subdomain takeover detection
    "naabu"           # Port scanning
    "dnsgen"          # Generate DNS permutations
    "mantra"          # Web application pentesting framework
    "subjs"           # Subdomain enumeration tool
    "subzy"           # Subdomain Takeover tool
    "Subdominator"    # Subdomain Takeover tool
)

INSTALL_DIR="/usr/local/bin"

# Determine user's home directory
if [ -n "$SUDO_USER" ]; then
    USER_HOME=$(getent passwd "$SUDO_USER" | cut -d: -f6)
else
    USER_HOME="$HOME"
fi

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
            go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
            sudo mv "$USER_HOME/go/bin/subfinder" "$INSTALL_DIR/"
            ;;
        "amass")
            go install github.com/owasp-amass/amass/v4@latest
            sudo mv "$USER_HOME/go/bin/amass" "$INSTALL_DIR/"
            ;;
        "puredns")
            go install github.com/d3mondev/puredns/v2@latest
            sudo mv "$USER_HOME/go/bin/puredns" "$INSTALL_DIR/"
            ;;
        "httpx")
            if check_tool "httpx"; then
                echo "[!] Removing existing httpx installation..."
                sudo rm -f "$INSTALL_DIR/httpx"
            fi
            go install github.com/projectdiscovery/httpx/cmd/httpx@latest
            sudo mv "$USER_HOME/go/bin/httpx" "$INSTALL_DIR/"
            ;;
        "dnsx")
            go install github.com/projectdiscovery/dnsx/cmd/dnsx@latest
            sudo mv "$USER_HOME/go/bin/dnsx" "$INSTALL_DIR/"
            ;;
        "assetfinder")
            go install github.com/tomnomnom/assetfinder@latest
            sudo mv "$USER_HOME/go/bin/assetfinder" "$INSTALL_DIR/"
            ;;
        "httprobe")
            go install github.com/tomnomnom/httprobe@latest
            sudo mv "$USER_HOME/go/bin/httprobe" "$INSTALL_DIR/"
            ;;
        "gau")
            go install github.com/lc/gau/v2/cmd/gau@latest
            sudo mv "$USER_HOME/go/bin/gau" "$INSTALL_DIR/"
            ;;
        "waybackurls")
            go install github.com/tomnomnom/waybackurls@latest
            sudo mv "$USER_HOME/go/bin/waybackurls" "$INSTALL_DIR/"
            ;;
        "katana")
            go install github.com/projectdiscovery/katana/cmd/katana@latest
            sudo mv "$USER_HOME/go/bin/katana" "$INSTALL_DIR/"
            ;;
        "hakrawler")
            go install github.com/hakluke/hakrawler@latest
            sudo mv "$USER_HOME/go/bin/hakrawler" "$INSTALL_DIR/"
            ;;
        "anew")
            go install github.com/tomnomnom/anew@latest
            sudo mv "$USER_HOME/go/bin/anew" "$INSTALL_DIR/"
            ;;
        "gf")
            go install github.com/tomnomnom/gf@latest
            sudo mv "$USER_HOME/go/bin/gf" "$INSTALL_DIR/"
            ;;
        "gospider")
            go install github.com/jaeles-project/gospider@latest
            sudo mv "$USER_HOME/go/bin/gospider" "$INSTALL_DIR/"
            ;;
        "paramspider")
            sudo apt-get install -y paramspider
            ;;
        "nuclei")
            go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
            sudo mv "$USER_HOME/go/bin/nuclei" "$INSTALL_DIR/"
            nuclei -update-templates
            ;;
        "arjun")
            sudo apt-get install -y arjun
            ;;
        "dalfox")
            go install github.com/hahwul/dalfox/v2@latest
            sudo mv "$USER_HOME/go/bin/dalfox" "$INSTALL_DIR/"
            ;;
        "massdns")
            sudo apt-get install -y massdns
            ;;
        "bbot")
            pipx install bbot
            ;;
        "ffuf")
            go install github.com/ffuf/ffuf@latest
            sudo mv "$USER_HOME/go/bin/ffuf" "$INSTALL_DIR/"
            ;;
        "nmap")
            sudo apt-get install -y nmap
            ;;
        "sqlmap")
            sudo apt install sqlmap -y
            ;;
        "wpscan")
            sudo apt install wpscan -y
            ;;
        "dirsearch")
            sudo apt install dirsearch -y
            ;;
        "feroxbuster")
            if ! command -v cargo &> /dev/null; then
                echo "[+] Installing Rust..."
                curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
                export PATH="$HOME/.cargo/bin:$PATH"
            fi
            cargo install feroxbuster
            sudo mv "$HOME/.cargo/bin/feroxbuster" "$INSTALL_DIR/"
            ;;
        "seclists")
            sudo apt-get install -y seclists
            ;;
        "findomain")
            curl -LO https://github.com/findomain/findomain/releases/latest/download/findomain-linux
            chmod +x findomain-linux
            sudo mv findomain-linux "$INSTALL_DIR/findomain"
            ;;
        "meg")
            go install github.com/tomnomnom/meg@latest
            sudo mv "$USER_HOME/go/bin/meg" "$INSTALL_DIR/"
            ;;
        "knocker")
            sudo apt install knocker -y
            ;;
        "xsser")
            sudo apt install xsser -y
            ;;
        "dnsgen")
            sudo apt install dnsgen -y
            ;;
        "hakcheckurl")
            go install github.com/hakluke/hakcheckurl@latest
            sudo mv "$USER_HOME/go/bin/hakcheckurl" "$INSTALL_DIR/"
            ;;
        "uncover")
            go install -v github.com/projectdiscovery/uncover/cmd/uncover@latest
            sudo mv "$USER_HOME/go/bin/uncover" "$INSTALL_DIR/"
            ;;
        "interactsh-client")
            go install github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest
            sudo mv "$USER_HOME/go/bin/interactsh-client" "$INSTALL_DIR/"
            ;;
        "metabigor")
            go install github.com/j3ssie/metabigor@latest
            sudo mv "$USER_HOME/go/bin/metabigor" "$INSTALL_DIR/"
            ;;
        "shuffledns")
            go install github.com/projectdiscovery/shuffledns/cmd/shuffledns@latest
            sudo mv "$USER_HOME/go/bin/shuffledns" "$INSTALL_DIR/"
            ;;
        "trufflehog")
            sudo apt install -y trufflehog
            ;;
        "subjack")
            go install github.com/haccer/subjack@latest
            sudo mv "$USER_HOME/go/bin/subjack" "$INSTALL_DIR/"
            ;;
        "naabu")
            sudo apt install -y naabu
            ;;
        "mantra")
            go install github.com/Brosck/mantra@latest
            sudo mv "$USER_HOME/go/bin/mantra" "$INSTALL_DIR/"
            ;;
        "subjs")
            go install github.com/lc/subjs@latest
            sudo mv "$USER_HOME/go/bin/subjs" "$INSTALL_DIR/"
            ;;
        "subzy")
            go install -v github.com/PentestPad/subzy@latest
            sudo mv "$USER_HOME/go/bin/subzy" "$INSTALL_DIR/"
            ;;
        "Subdominator")
            sudo snap install subdominator
            # Create symlink for snap installation
            if [ -f "/snap/bin/subdominator" ]; then
                echo "[+] Creating symlink for Subdominator"
                sudo ln -sf /snap/bin/subdominator /usr/local/bin/subdominator
            else
                echo "[!] Subdominator binary not found in /snap/bin"
            fi
            ;;
        *)
            echo "[!] Unknown tool: $tool"
            ;;
    esac
}

# Ensure required package managers are installed
sudo apt-get update
sudo apt-get install -y git golang pipx snapd

# Ensure snapd service is running
if ! systemctl is-active --quiet snapd; then
    echo "[+] Starting snapd service..."
    sudo systemctl enable --now snapd
    sudo systemctl start snapd
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
if [ -d "$USER_HOME/.gf" ]; then
    echo "[✔] GF patterns directory found."
else
    echo "[+] Installing GF patterns..."
    git clone https://github.com/1ndianl33t/Gf-Patterns "$USER_HOME/.gf"
fi

echo "[+] All tools installed successfully."
