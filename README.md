# Bug Bounty Tools Installer

## 📌 Overview
This is an automated installation script designed for Kali Linux users to quickly set up essential bug bounty tools. Instead of manually installing tools after every fresh OS installation, this script saves time by automatically installing and configuring everything needed for bug bounty hunting.

## 🚀 Features
- Installs **40+ essential bug bounty tools** automatically
- Ensures dependencies (Go, Python, pipx, snap) are installed
- Checks if a tool is already installed before installing it
- Updates tools to their latest versions
- Installs missing `gf` patterns for enhanced pattern matching
- Handles both apt and snap installations seamlessly
- Creates necessary symlinks for Snap-installed tools

## 🛠️ Included Tools
| Category           | Tools                                                                 |
|--------------------|-----------------------------------------------------------------------|
| Reconnaissance     | subfinder, amass, findomain, metabigor, uncover                      |
| Scanning           | nmap, naabu, nuclei, ffuf, feroxbuster                               |
| Web Analysis       | httpx, dalfox, arjun, paramspider, gospider                          |
| DNS Tools          | dnsx, puredns, shuffledns, massdns, dnsgen                           |
| Utility            | gf, anew, hakcheckurl, interactsh-client, waybackurls                |
| Content Discovery  | katana, hakrawler, dirsearch, meg, gau                               |
| Cloud Security     | subjack, subzy, trufflehog                                           |
| Others             | wpscan, sqlmap, seclists, chromium, gowitness                        |

## 🔧 Installation

### Prerequisites
Ensure you are using **Kali Linux** and have `git` installed:
```bash
sudo apt update && sudo apt install -y git
