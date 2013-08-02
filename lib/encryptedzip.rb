require_relative './encryptedzip/version'
require 'openssl'
require 'securerandom'
require 'zipruby'

module EncryptedZip

  class << self
    attr_accessor :public_key_file, :encrypted_filepath, :password_path
  end

  def self.create_encrypted_zip(options={})
    check_errors(options)
    password = generate_password
    create_password_file(password)

    create_zip(encrypted_filepath, options[:files])
    Zip::Archive.encrypt(encrypted_filepath, password)

    create_zip(options[:output_filepath], 
      [password_path, encrypted_filepath])

    clean_up
    options[:output_filepath]
  end

  private
  def self.encrypted_filepath
    @encrypted_filepath || 'encrypted.zip'
  end

  def self.password_path
    @password_path || 'password.txt'
  end

  def self.create_zip(filename, files)
    Zip::Archive.open(filename, Zip::CREATE) do |archive|
      files.each do |file|
        archive.add_file(file) 
      end
    end
  end

  def self.clean_up
    File.delete(encrypted_filepath, password_path)
  end

  def self.generate_password
    SecureRandom.base64(85)
  end

  def self.encrypt_string(string)
    public_key = OpenSSL::PKey::RSA.new(File.read(public_key_file))
    cipher = public_key.public_encrypt(string)
  end

  def self.create_password_file(password)
    File.open(password_path, "wb") {|f| f.write(encrypt_string password)}
  end

  def self.check_errors(options)
    raise "You must set a public key file location" unless @public_key_file
    raise "Place a public key at #{@public_key_file}" unless File.exists? @public_key_file
    raise "You must supply an output filepath" unless options.has_key? :output_filepath
    raise "You must supply a list of files to encrypt" unless options.has_key? :files
  end
end
