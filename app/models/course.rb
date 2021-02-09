# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :date, presence: true
end
