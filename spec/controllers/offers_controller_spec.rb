require "rails_helper"

RSpec.describe OffersController, :type => :controller do
  toggle_webmock
  it "responds raises an exception for missing parameters" do
    expect{(get :index)}.to raise_error(ActionController::ParameterMissing)
  end
  it "responds with 403 Invalid signature for tampered signature in response" do
    mock_invalid_signature_response
    get :index, {uid: 'player1', pub0: 'campaign2', page: 1}
    assert_response 403
  end
  it "responds for valid requests (without mocking)", webmock: false do
    get :index, {uid: 'player1', pub0: 'campaign2', page: 1}
    assert_response 200
    expect(response).to render_template :index
    expect(assigns :offers).not_to be_nil
  end
end