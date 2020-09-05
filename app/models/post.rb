class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) } # [todo] default_scope はできれば使わないのが賢明??
  validates :user_id, presence: true
  validates :content, presence: true
  validates :area   , presence: true
  validates :genre  , presence: true
  validates :season , presence: true
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png], message: "有効な画像形式でなければなりません" },
                    size:         { less_than: 5.megabytes, message: "画像サイズが5未満でなければなりません" }
end
