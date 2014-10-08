class OffersController < ApplicationController

  def index
    fyber_request_params = {"appid" => 157, "device_id"=> "2b6f0cc904d137be2e1730235f5664094b831186", "locale"=> "de", "ip"=> "109.235.143.113", "offer_types"=> 112}
    fyber_request_params["uid"] = params["uid"]
    fyber_request_params["page"] = params["page"]
    fyber_request_params["pub0"] = params["pub0"]
    fyber_request_params["timestamp"] = Time.now.to_i
    # fyber_request_params["ps_time"] = Time.now.to_i
    fyber_request_params["hashkey"]=Digest::SHA1.hexdigest(fyber_request_params.sort_by {|key, value| key}.map {|pair| pair[0]+"="+pair[1].to_s}.join("&").concat("&"+Rails.configuration.fyber_api_key))
    # byebug

    # debug_output $stdout
    @reply = HTTParty.get('http://api.sponsorpay.com/feed/v1/offers.json',query: fyber_request_params)

    #validate response
    unless @reply.headers["x-sponsorpay-response-signature"] == Digest::SHA1.hexdigest(@reply.body+Rails.configuration.fyber_api_key)
      render status: 403, text: "Invalid Signature"
    end
    @offers = @reply["offers"]
  end

end
