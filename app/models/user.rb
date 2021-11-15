class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #can register user, forgot password, one logged in stay signed in
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :friendships
  has_many :friends, through: :friendships
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_stock(ticker_symbol)
    #if stock is nil, no way its tracked otherwise would be found so return false.
    return false unless stock

    #stock has been added to db alrdy, some1 tracking, check if user following stock
    stocks.where(id: stock.id).exists?
  end
  
  def under_stock_limit?
    stocks.count < 7
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def fullname
    return "#{first_name} #{last_name}" if first_name || last_name
    return "Anon"
  end

end
