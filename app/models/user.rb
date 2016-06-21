class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  mount_uploader :avatar, AvatarUploader

 def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
 	user = User.where(:provider => auth.provider, :uid => auth.uid).first
  if user
  	return user
  else
    registered_user = User.where(:email => auth.uid + "@facebook.com").first
    if registered_user
      return registered_user
    else
      user = User.create(
                        provider:auth.provider,
                        uid:auth.uid,
                        email:auth.uid+"@facebook.com",
                        password:Devise.friendly_token[0,20],
                        )
      end
    end
  end
end



