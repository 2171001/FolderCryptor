# AES Encryption/Decryption Script
# Define the folder to encrypt or decrypt
$folderPath = "D:\PowershellScripts\Folder Encryption_Decryption\test"

# Prompt for password and convert it to a secure AES key
$password = Read-Host -AsSecureString -Prompt "Enter password for encryption/decryption"
$plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
$AESKey = (New-Object Security.Cryptography.SHA256Managed).ComputeHash([System.Text.Encoding]::UTF8.GetBytes($plainPassword))

# Initialize AES encryption parameters
$aes = [System.Security.Cryptography.Aes]::Create()
$aes.KeySize = 256
$aes.BlockSize = 128
$aes.Padding = "PKCS7"
$aes.Mode = "CBC"

# Generate or load Initialization Vector (IV)
$IVFilePath = "$folderPath\.iv"
if (!(Test-Path $IVFilePath)) {
    $IV = New-Object byte[] (16)
    [System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($IV)
    [System.IO.File]::WriteAllBytes($IVFilePath, $IV)
} else {
    $IV = [System.IO.File]::ReadAllBytes($IVFilePath)
}
$aes.IV = $IV
$aes.Key = $AESKey

# Ask user to select encryption or decryption
Write-Output "Select an action:"
Write-Output "1. Encrypt Folder"
Write-Output "2. Decrypt Folder"
$choice = Read-Host "Enter choice (1 or 2)"

# Encryption
if ($choice -eq 1) {
    foreach ($file in Get-ChildItem -Path $folderPath -File | Where-Object { $_.Name -ne ".iv" }) {
        try {
            # AES encryption process
            $encryptor = $aes.CreateEncryptor()
            $fileContent = [System.IO.File]::ReadAllBytes($file.FullName)
            $encryptedContent = $encryptor.TransformFinalBlock($fileContent, 0, $fileContent.Length)

            # Write the encrypted content to a new file with an additional .enc extension
            $encryptedFilePath = "$($file.FullName).enc"
            [System.IO.File]::WriteAllBytes($encryptedFilePath, $encryptedContent)
            Write-Output "Encrypted: $($file.FullName)"
            
            # Remove the original file
            Remove-Item -Path $file.FullName
        } catch {
            Write-Output "Failed to encrypt $($file.FullName): $_"
        }
    }
    Write-Output "Folder contents encrypted successfully and original files removed."
}

# Decryption
elseif ($choice -eq 2) {
    $errorOccurred = $false
    foreach ($file in Get-ChildItem -Path $folderPath -Filter "*.enc") {
        try {
            # AES decryption process
            $decryptor = $aes.CreateDecryptor()
            $encryptedContent = [System.IO.File]::ReadAllBytes($file.FullName)
            $decryptedContent = $decryptor.TransformFinalBlock($encryptedContent, 0, $encryptedContent.Length)

            # Remove one .enc extension from the file name
            $decryptedFilePath = $file.FullName -replace "\.enc$", ""
            [System.IO.File]::WriteAllBytes($decryptedFilePath, $decryptedContent)
            Write-Output "Decrypted: $($file.FullName)"
            
            # Remove the encrypted file
            Remove-Item -Path $file.FullName

        } catch {
            # Catch any decryption errors and set the error flag
            Write-Output "Failed to decrypt $($file.FullName): $_"
            $errorOccurred = $true
        }
    }

    # Check if any errors occurred during decryption
    if ($errorOccurred) {
        Write-Output "Decryption failed for one or more files. Please check the password and try again."
    } else {
        Write-Output "Folder contents decrypted successfully and files restored."
    }
} else {
    Write-Output "Invalid choice. Please select 1 for encryption or 2 for decryption."
}

# Dispose of AES object
$aes.Dispose()