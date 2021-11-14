class UserStock < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  def self.get_user_stock(user_id, stock_id)
    where(user_id: user_id, stock_id: stock_id).first
  end
end
