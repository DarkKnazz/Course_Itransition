class Comment < ApplicationRecord
  after_create_commit { CommentBroadcastJob.perform_later self }
end
