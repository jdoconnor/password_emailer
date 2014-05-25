class Note < OpenStruct
  def secret_key
    ENV['SECRET_KEY']
  end

  def salt
    ENV['SALT']
  end

  def iv
    ENV['IV']
  end

  def decrypted_secret
    return nil unless encrypted_secret
    # decrypt the encrypted secret
    Encryptor.decrypt(encrypted_secret.unpack('m').first, key: secret_key, iv: iv, salt: salt)
  end

  def save
    redis = Redis.new
    self.secret = secret
    self.id = SecureRandom.uuid
    # 1 day default
    expires_in_seconds = expires_in_seconds.present? ? expires_in_seconds.to_i : 86400
    encrypted_secret = [Encryptor.encrypt(secret, key: secret_key, iv: iv, salt: salt)].pack('m')
    redis.set(id, { encrypted_secret: encrypted_secret, name: name }.to_json, ex: expires_in_seconds)
    self
  end

  def self.find(id)
    redis = Redis.new
    json = redis.get(id)
    redis.del(id)
    json ||= { name: nil, encrypted_secret: nil }.to_json
    new(JSON.parse(json))
  end
end
