class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions
  has_many :socket_channels
     
  ########### start Doorkeeper hepler method
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    return { success: false, code: 'INVALID', data: nil } if !user

    if user&.valid_password?(password)
      return user
    end
  end

  ########### End Doorkeeper hepler method    
end
