puts 'file included'
module WebmockMacros
   def toggle_webmock
    before(:each, webmock: false) do
      WebMock.disable!
    end
    after(:each, webmock: false) do
      WebMock.enable!
    end
  end
  def mock_requests
    background do
      stub_body = '{"code" :  " OK" ,
                 "message":  "OK",
                 "count":  "1" ,
                 "pages":  "1" ,
                 "information" :  {
                  "app_name":  "SP Test App" ,
                  "appid":  "157",
                  " virtual_ currency":  "Coins",
                  "country":  " US" ,
                  "language":  " EN" ,
                  "support_url" :  "http://iframe.sponsorpay.com/mobile/DE/157/my_offers"
                 },
                 "offers" :  [
                  {
                    "title":  " Tap  Fish",
                    "offer_id":  " 13554",
                    " teaser " :  "  Download and START " ,
                    " required _actions " :  "Download and START",
                    "link" :  "http://iframe.sponsorpay.com/mbrowser?appid=157&lpid=11387&uid=player1",
                    "offer_types" :  [
                     {
                      "offer_type_id":  "101",
                      "readable":  "Download"
                     },
                     {
                      "offer_type_id":  "112",
                      "readable":  "Free"
                     }
                    ] ,
                    "thumbnail" :  {
                     "lowres" :  "http://cdn.sponsorpay.com/assets/1808/icon175x175- 2_square_60.png" ,
                     "hires":  "http://cdn.sponsorpay.com/assets/1808/icon175x175- 2_square_175.png"
                    },
                    "payout" :  "90",
                    "time_to_payout" :  {
                     "amount" :  "1800" ,
                     "readable":  "30 minutes"
                    }
                  }
                 ]
                }'
    stub_request(:any, /http:\/\/api\.sponsorpay\.com.*/).to_return(:headers=>{ 'x-sponsorpay-response-signature' => Digest::SHA1.hexdigest(stub_body+Rails.configuration.fyber_api_key) }, :body => stub_body)
    end
  end
end
module WebmockExamplesHelpers
  def mock_invalid_signature_response
    stub_body = '{"evil": true}'
    stub_request(:any, /http:\/\/api\.sponsorpay\.com.*/).to_return(:headers=>{ 'x-sponsorpay-response-signature' => Digest::SHA1.hexdigest(stub_body) }, :body => stub_body)
  end
end
RSpec.configure do |config|
  config.extend WebmockMacros
  config.include WebmockExamplesHelpers
end