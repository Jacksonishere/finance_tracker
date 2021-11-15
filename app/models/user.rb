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


  ##### FOR SEARCH

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  #gets the records where the field_name contains th param
  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

  #gets the records that correlate to search params using the helpers above.
  def self.search(param)
    param.strip! #removes leading and trailing whitespace

    #returns unique list of concatenated users.  
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq

    #if none, means user not in the database with that first/last name or email
    return nil unless to_send_back
    to_send_back
  end

  #exclude current user from a list of users
  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  #use find if you know it exists otherwise throws error
  def already_following?(user_id)
    friends.where(id: user_id).exists?
  end


end
