class Post < ApplicationRecord
	belongs_to :user
	has_many :steps
	acts_as_taggable 
end
