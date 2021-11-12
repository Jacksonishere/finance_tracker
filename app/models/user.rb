class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #can register user, forgot password, one logged in stay signed in
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
