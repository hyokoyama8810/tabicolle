class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) } # [todo] default_scope はできれば使わないのが賢明??
  validates :user_id, presence: true
  validates :content, presence: true
end
