#/bin/bash

# http://tomcat.apache.org/tomcat-6.0-doc/ssl-howto.html

# http://docs.oracle.com/javaee/6/tutorial/doc/glien.html

# https://developer.salesforce.com/page/Making_Authenticated_Web_Service_Callouts_Using_Two-Way_SSL

# http://www.pixelstech.net/article/1450354633-Using-keytool-to-create-certificate-chain

# Clean the keystore
rm -Rf $PWD/src/main/resources/keystore

# Clean the truststore - we will only trust IAG Chains
rm -Rf $PWD/src/main/resources/truststore

## CSG is a certificate authority
## Platforms can only use certificates signed by CSG Root certificate

# Create the truststore
## One IAG Root CA
## Signed CA's per platform with IAG certificate chain?
## stores public keys / certificates from CA's used to trust remote party or SSL connections.

# Should use internet standard PKCS12

# Create the keystore
# Import the root alias certificate into truststore
echo "Importing IAG root_ca into new truststore"
keytool -import -alias root_ca -file /home/vagrant/Apps/iag_internal_ca.crt -keystore $PWD/src/main/resources/truststore -noprompt -trustcacerts -storepass iag123456 -v -keypass iag123456 


## Contains private keys when running a server for SSL connections
echo "Creating Key pair for IAG Root CA - RSA 2048bit"
keytool -genkeypair -alias root_pk -keystore $PWD/src/main/resources/truststore -dname "CN=IAG Internal CA, DC=auiag, DC=corp" -storepass iag123456 -keypass iag123456 -keyalg RSA -keysize 2048 -validity 712 -ext bc=ca:true

echo "Truststore contents"
keytool -list -keystore $PWD/src/main/resources/truststore -storepass iag123456 -v

# Import the root alias certificate into truststore

# Create a self-signed certificate (with the root alias certificate)
# https://www.sslshopper.com/article-how-to-create-a-self-signed-certificate-using-java-keytool.html

# CN for Root = CN=IAG Internal CA, DC=auiag, DC=corp

echo "Creating Policy Platform certificate - RSA 2048 bit"
keytool -genkeypair -alias policy_cert -keystore $PWD/src/main/resources/keystore -storepass iag123456 -dname "CN=policy platform" -v -keypass iag123456 -keysize 2048 -validity 712 -keyalg RSA 

# Now create a certificate signing request for this new policy_cert
echo "Creating certificate signing request for Policy platform cert"
keytool -certreq -keystore $PWD/src/main/resources/keystore -storepass iag123456 -v -alias policy_cert -file $PWD/src/main/resources/policy_cert.csr

# Now create a new 'Policy_Certificate' from this signing request using the root CA
echo "Signing Policy certificate with IAG Cert private key"
keytool -gencert -keystore $PWD/src/main/resources/truststore -storepass iag123456 -alias root_pk -infile $PWD/src/main/resources/policy_cert.csr -outfile $PWD/src/main/resources/policy_cert.cer -v

echo "Policy Certificate - signed by IAG CA"
keytool -printcert -file $PWD/src/main/resources/policy_cert.cer -v

# Signing certificates with your own CA
# https://docs.oracle.com/cd/E19509-01/820-3503/ggezy/index.html

# Import the self-signed certificate into the keystore
echo "Importing Policy Certificate into truststore as alias 'policy_ca'"
keytool -importcert -keystore $PWD/src/main/resources/truststore -storepass iag123456 -file $PWD/src/main/resources/policy_cert.cer -alias policy_ca -v 

echo "Truststore contents - after creation"
keytool -list -keystore $PWD/src/main/resources/truststore -storepass iag123456 -v

