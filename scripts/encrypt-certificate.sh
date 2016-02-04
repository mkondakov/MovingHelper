#!/bin/sh

openssl aes-256-cbc -k "$ENCRYPTION_SECRET" -in scripts/profile/WildcardDistribution.mobileprovision.enc -d -a -out scripts/profile/WildcardDistribution.mobileprovision
openssl aes-256-cbc -k "$ENCRYPTION_SECRET" -in scripts/certs/enterprise.cer.enc -d -a -out scripts/certs/enterprise.cer
openssl aes-256-cbc -k "$ENCRYPTION_SECRET" -in scripts/certs/enterprise.p12.enc -d -a -out scripts/certs/enterprise.p12