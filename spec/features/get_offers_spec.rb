require 'rails_helper'

feature 'Get Offers' do
  mock_requests
  toggle_webmock
  scenario 'Fill the input form then get list of offers through a stubbed reply' do
    visit root_path
    fill_in 'inputUID', with: 'player2'
    fill_in 'inputPub0', with: 'campaign1'
    fill_in 'inputPage', with: '1'
    click_button 'Get Offers'
    expect(current_path).to eq offers_path
    expect(page).to have_content 'Tap Fish'
  end

  scenario 'Missing UID in the form parameters should prevent the form from submitting', js: true do
    visit root_path
    click_button 'Get Offers'
    expect(current_path).to eq root_path
    within 'div.has-error' do
      expect(page).to have_text 'UID is required'
    end
  end

  scenario 'Fill the input form then submitting should get a response from the backend (without mocking)', webmock: false do
    visit root_path
    fill_in 'inputUID', with: 'player2'
    fill_in 'inputPub0', with: 'campaign1'
    fill_in 'inputPage', with: '1'
    click_button 'Get Offers'
    expect(current_path).to eq offers_path
    expect(page).to have_content 'No Offers'
    expect(page.status_code).to eq(200)
  end

end