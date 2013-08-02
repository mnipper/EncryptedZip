# EncryptedZip

Use EncryptedZip to create an archive of encrypted files.  Files are encrypted using AES-256 using a randomly generated base64 password of approximately 100 characteres.  The password is encrypted according to a provided public key.  The encrypted password is then stored as a txt file and zipped along with the encrypted zip.

## Installation

Add this line to your application's Gemfile:

    gem 'encryptedzip'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install encryptedzip

## Usage

You must specify a public key file to use for the password encryption:
```
EncryptedZip.public_key_file = 'public.pem'
```

You can then create an encrypted zip file by providing an output filepath and an array of filepaths to encrypt.
```
EncryptedZip.create_encrypted_zip(output_filepath: 'archive.zip', files: ['secret.txt'])
```

Optionally, you can provide a password_path and encrypted_filepath.
```
EncryptedZip.password_path = "p4$$w0rd.txt"
EncryptedZip.encrypted_filepath = "BigSecret.zip"
```

To generate a 4096-bit private key:
`$ openssl genrsa -des3 -out private.pem 4096`

To generate a public key from a private key:
`$ openssl rsa -in private.pem -out public.pem -outform PEM -pubout`

Example script to decrypt a password file:

```
require 'openssl'

private_key_file = 'private.pem'
password = '' # password used during key genertation
encrypted_string = File.read('password.txt') 
private_key = OpenSSL::PKey::RSA.new(File.read(private_key_file),password)
puts private_key.private_decrypt(encrypted_string)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
