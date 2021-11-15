class Friendship < ApplicationRecord
  belongs_to :user
  # I have a pk called friend_id that references a User. 
  belongs_to :friend, class_name: 'User'
end
