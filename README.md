# FolderCryptor
FolderCryptor is a PowerShell-based tool for encrypting and decrypting folder contents. It supports multi-layer encryption, allowing users to apply multiple levels of encryption to a file and decrypt in reverse order. This tool uses AES-256 encryption to ensure data security, making it ideal for sensitive information storage.

## Features
- **AES-256 Encryption**: Ensures robust security using a password-based AES key.
- **Multi-layer Encryption**: Supports multiple encryption layers, allowing flexibility in file security.
- **Simple Interface**: Easy-to-use script with straightforward prompts for encryption and decryption.
- **Filename Modification**: Automatically manages `.enc` extensions to reflect encryption level.

## Requirements
- PowerShell 5.1 or newer
- Windows OS (tested on Windows 10 and 11)

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/2171001/FolderCryptor.git
   ```
2. Navigate to the project directory:
   ```bash
   cd FolderCryptor
   ```

## Usage
