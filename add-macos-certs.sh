#!/usr/bin/env sh

KEYCHAIN=build.keychain
KEYCHAIN_PASSWORD=actions
CERT_P12_FILE=certificate.p12

# Recreate the certificate from the secure environment variable
echo $CERT_P12 | base64 --decode >$CERT_P12_FILE

# Create a keychain
security create-keychain -p $KEYCHAIN_PASSWORD $KEYCHAIN

# Make the keychain the default so identities are found
security default-keychain -s $KEYCHAIN

# Unlock the keychain
security unlock-keychain -p $KEYCHAIN_PASSWORD $KEYCHAIN

# Developer cert
security import $CERT_P12_FILE -k $KEYCHAIN -P "$CERT_PASSWORD" -T /usr/bin/codesign

# Set the partition list (sort of like an access control list)
security set-key-partition-list -S apple-tool:,apple: -s -k $KEYCHAIN_PASSWORD $KEYCHAIN >/dev/null

# remove certs
rm -fr *.p12

# Echo the identity, just so that we know it worked.
# This won't display anything secret.
security find-identity -v -p codesigning $KEYCHAIN
