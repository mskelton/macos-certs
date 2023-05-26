# macOS Certs

GitHub action to create a keychain and import macOS certificates for publishing
macOS apps.

## Usage

```yml
- name: Add macOS certs
  uses: mskelton/macos-certs@v1
  env:
    CERT_P12: ${{ secrets.MACOS_CERT_P12 }}
    CERT_PASSWORD: ${{ secrets.MACOS_CERT_PASSWORD }}
```

### Exporting certificates

To export your signing certificates, follow the steps below.

1. Login to Apple Developer and go to [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/certificates/list)
1. Create the appropriate signing certificates
1. Download and add the certificates to your keychain
1. Select the certificates and their associated private keys in keychain and
   export as a `p12` file.
1. Run the following command to convert your `p12` file into a base64 string.
   ```bash
   base64 -i <p12_file> | pbcopy
   ```
1. Add the copied string to a `CERT_P12` secret in your repo.
1. Add the password you used when exporting to the `CERT_PASSWORD` secret in
   your repo.

_When exporting your certificates and private keys from keychain, it should look
something like this._

![Certificates](https://github.com/mskelton/macos-certs/assets/25914066/cdc3bb94-14d8-4059-b803-9dc635d89e2f)
