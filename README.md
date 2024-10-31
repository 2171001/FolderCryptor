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
1. **Open PowerShell** and navigate to the directory containing the script:
   ```powershell
   cd path\to\FolderCryptor
   ```
2. Run the script:
   ```powershell
   .\FolderCryptor.ps1
   ```
3. Enter Password: Provide a password that will be used for both encryption and decryption.
4. Choose an Action:
- Type 1 to encrypt the folder contents.
- Type 2 to decrypt the folder contents.

## Examples
**First-time Encryption**
When running the script for the first time and selecting encryption:
- `file.txt → file.txt.enc`
**Multi-layer Encryption**
Running the script and selecting encryption again:
- `file.txt.enc → file.txt.enc.enc`
**Decryption Steps**
Each decryption removes one .enc layer until the file is restored:
- `file.txt.enc.enc → file.txt.enc`
- `file.txt.enc → file.txt`

## Notes
- The encryption key is derived from the provided password using SHA-256 hashing.
- Make sure to use the same password for encryption and decryption to avoid errors.
- Avoid re-encrypting decrypted files without a backup, as decryption with an incorrect password will fail.

## Troubleshooting
- Invalid Key Size: Ensure your PowerShell environment supports AES-256.
- Padding Error: If you see a "Padding is invalid" error, the password may not match the one used for encryption.

## Contributing
- Contributions are welcome! Feel free to open an issue or submit a pull request with improvements, bug fixes, or new features.
