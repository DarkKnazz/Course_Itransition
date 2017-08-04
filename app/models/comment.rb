class Comment < ApplicationRecord
  after_create_commit { CommentBroadcastJob.perform_later self }
  belongs_to :user
  belongs_to :post
end
