raise 'No FYBER_API_KEY found' unless ENV['FYBER_API_KEY']
Rails.application.config.fyber_api_key = ENV['FYBER_API_KEY']