class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true


  #define class method for stock lookup
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      # secret_token: 'Tsk_a23cbfec9acd4e98b6e86b3ce4e26c29',
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
  end

  def self.check_stock(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
