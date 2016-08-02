# Keytool

Goal: An automation based attempt to prove certificate management across platforms

## Pre-Requisites:

* JAVA 1.8
* The IAG certificate
* Maven 3+ - we will use a maven plugin to speed up automation (Keytool maven plugin)

The primary reference to create the certificate, key creation script was this article - http://www.pixelstech.net/article/1450354633-Using-keytool-to-create-certificate-chain

## Starting up

Take a copy of a cacerts file from a JRE installation 
By default this file is found at %JAVA_HOME%/jre/lib/security/cacerts


The password for the *cacerts* file will be `changeit`

## The keystore

We will create a keystore at ${project.basedir}/src/main/resources/keytore

The password will be `iag123456`

# The truststore

We will create a truststore at ${project.basedir}/src/main/resources/truststore

It's intent is to store the private key for the Root CA, and trust certificates.
* IAG Internal CA
* IAG Internal Private Key (for signing)
* IAG Policy Platform CA
* ...

The password will be `iag123456`


## To import the CA

`keytoolseq.sh`


`mvn generate-resources' - will execute a build plugin

### Test the keystore

`keytool --list -keystore ./src/main/resources/keystore -storepass iag123456`

### Test the truststore

`keytool --list -keystore ./src/main/resources/truststore -storepass iag123456`


## Location of cacerts
/usr/lib/jvm/java-7-oracle/jre/lib/security/cacerts

## Sample Keys, certificates

The following site contains some generated Keys & certificates

http://fm4dd.com/openssl/certexamples.htm
