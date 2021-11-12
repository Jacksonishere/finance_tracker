class Stock < ApplicationRecord

  #define class method for stock lookup
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      # secret_token: 'Tsk_a23cbfec9acd4e98b6e86b3ce4e26c29',
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    return client.price(ticker_symbol)
  end
end
