class Signature

  def self.hash_request_parameters(params)
    Digest::SHA1.hexdigest(params.sort_by {|key, value| key}.map {|pair| pair[0]+"="+pair[1].to_s}.join("&").concat("&"+Rails.configuration.fyber_api_key))
  end

  def self.sign_response(response)
    Digest::SHA1.hexdigest(response+Rails.configuration.fyber_api_key)
  end

end