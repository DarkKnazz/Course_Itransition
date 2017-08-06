class Step < ApplicationRecord
	belongs_to :post
	acts_as_list
	default_scope { order('position ASC') }
end
