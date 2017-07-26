class Post < ApplicationRecord
	belongs_to :user
	has_many :steps
	acts_as_taggable
	ratyrate_rateable 'visual_effects', 'original_score', 'director', 'custome_design'
end
