class Friendship < ApplicationRecord
  belongs_to :user
  # I have a pk called friend_id that references a User. 
  belongs_to :friend, class_name: 'User'

  def self.get_friendship(user_id, friend_id)
    #where is a model level query
    where(user_id: user_id, friend_id: friend_id).first
  end
end
