class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  ratyrate_rater
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
		 :omniauth_providers => [:facebook, :twitter, :vkontakte, :google_oauth2]
  has_many :posts
  def self.facebook_from_omniauth(auth)
	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	  user.provider = auth.provider
	  user.uid = auth.uid
	  user.email = auth.info.email
	  user.password = Devise.friendly_token[0,20]
	  user.image = auth.info.image
	  user.nickname = auth.info.name
	  user.save
	end
  end

  def self.vkontakte_from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	user.provider = auth.provider
	user.uid = auth.uid
	user.email = auth.info.first_name + "_" + auth.info.last_name + "@vk.com"
	user.password = Devise.friendly_token[0,20]
	user.image = auth.info.image
	user.nickname = auth.info.first_name + " " + auth.info.last_name
	user.save
  end
end

def self.twitter_from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	user.provider = auth.provider
	user.uid = auth.uid
	user.email = auth.info.name + "@twitter.com";
	user.password = Devise.friendly_token[0,20]
	user.image = auth.info.image
	user.nickname = auth.info.name
	user.save
  end
end

def self.google_from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	user.provider = auth.provider
	user.uid = auth.uid
	user.email = auth.info.email
	user.password = Devise.friendly_token[0,20]
	user.image = auth.info.image
	user.nickname = auth.info.name
	user.save
  end
end
end
