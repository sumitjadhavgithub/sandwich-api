class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions
  has_many :web_sockets
     
  ########### start Doorkeeper hepler method
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    return { success: false, code: 'INVALID', data: nil } if !user

    if user&.valid_password?(password)
      return user
    end
  end
  ########### End Doorkeeper hepler method    
  def user_json
    {
      id: id,
      email: email,
      uuid: web_sockets.present? ? web_sockets.first.uuid : ""
    }
  end 
end
