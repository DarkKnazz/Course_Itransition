class Post < ApplicationRecord
	include SearchCop
	belongs_to :user
	belongs_to :category
	has_many :steps
	has_many :comments
	acts_as_taggable
	ratyrate_rateable 'original_score'

	search_scope :search do
    attributes :name, :preview
		attributes comment: 'comments.content'
		attributes step: ['steps.content', 'steps.name']
  end

	def avg_rating_dimension(post)
    array = Rate.where(rateable_id: id, rateable_type: 'Post').where(dimension: 'original_score')
    stars = array.map {|post| post.stars }
    star_count = stars.count
    stars_total = stars.inject(0){|sum,x| sum + x }
    score = stars_total / (star_count.nonzero? || 1)
  end
end
