class OffersController < ApplicationController
  def index

    fyber_request_params = {"appid" => 157, "device_id"=> "2b6f0cc904d137be2e1730235f5664094b831186", "locale"=> "de", "ip"=> "109.235.143.113", "offer_types"=> 112}
    fyber_request_params["uid"] = params.require(:uid)
    fyber_request_params["page"] = params["page"]
    fyber_request_params["pub0"] = params["pub0"]
    fyber_request_params["timestamp"] = Time.now.to_i
    fyber_request_params["hashkey"]=Signature.hash_request_parameters(fyber_request_params)

    @reply = HTTParty.get('http://api.sponsorpay.com/feed/v1/offers.json',query: fyber_request_params)


    #validate response
    unless @reply.headers["x-sponsorpay-response-signature"] == Signature.sign_response(@reply.body)
      render status: 403, text: "Invalid Signature"
    end
    @offers = JSON.parse(@reply.body)["offers"]
  end

end
