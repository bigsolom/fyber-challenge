require 'rails_helper'

feature 'Get Offers' do
  scenario 'Fill the input form then get list of offers' do
    stub_body = {"code"=>  " OK" ,"message"=>  "OK","count"=>  "1" , "pages"=>  "1" ,
     "information" =>  {
      "app_name"=>  "SP Test App" ,
      "appid"=>  "157",
      " virtual_ currency"=>  "Coins",
      "country"=>  " US" ,
      "language"=>  " EN" ,
      "support_url" =>  "http=>//iframe.sponsorpay.com/mobile/DE/157/my_offers"
     },
     "offers" =>  [
      {
        "title"=>  " Tap  Fish",
        "offer_id"=>  " 13554",
        " teaser " =>  "  Download and START " ,
        " required _actions " =>  "Download and START",
        "link" =>  "http=>//iframe.sponsorpay.com/mbrowser?appid=157&lpid=11387&uid=player1",
        "offer_types" =>  [
         {
          "offer_type_id"=>  "101",
          "readable"=>  "Download"
         },
         {
          "offer_type_id"=>  "112",
          "readable"=>  "Free"
         }
        ] ,
        "thumbnail" =>  {
         "lowres" =>  "http=>//cdn.sponsorpay.com/assets/1808/icon175x175- 2_square_60.png" ,
         "hires"=>  "http=>//cdn.sponsorpay.com/assets/1808/icon175x175- 2_square_175.png"
        },
        "payout" =>  "90",
        "time_to_payout" =>  {
         "amount" =>  "1800" ,
         "readable"=>  "30 minutes"
        }
      }
     ]
    }
    stub_request(:any, /http:\/\/api\.sponsorpay\.com.*/).to_return(:headers=>{ 'x-sponsorpay-response-signature' => Digest::SHA1.hexdigest(stub_body.to_s+Rails.configuration.fyber_api_key) }, :body => stub_body.to_s)
    visit root_path
    fill_in 'inputUID', with: 'player2'
    fill_in 'inputPub0', with: 'campaign1'
    fill_in 'inputPage', with: '1'
    click_button 'Get Offers'
    expect(current_path).to eq offers_path
    expect(page).to have_content 'Tap Fish'
  end
end