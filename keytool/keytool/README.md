# Keytool

Goal: An automation based attempt to prove certificate management across platforms

## Pre-Requisites:

* JAVA 1.8
* The IAG certificate
* Maven 3+ - we will use a maven plugin to speed up automation (Keytool maven plugin)

## Starting up

Take a copy of a cacerts file from a JRE installation 
By default this file is found at %JAVA_HOME%/jre/lib/security/cacerts


The password for the *cacerts* file will be `changeit`


## The keystore

We will create a keystore at ${project.basedir}/src/main/resources/keytore

The password will be 'iag123456'


## To import the CA

`mvn generate-resources' - will execute a build plugin

### Test the keystore

`keytool --list -keystore ./src/main/resources/keystore -storepass iag123456`


## Location of cacerts
/usr/lib/jvm/java-7-oracle/jre/lib/security/cacerts

## Sample Keys, certificates

http://fm4dd.com/openssl/certexamples.htm
