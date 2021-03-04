# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :date, presence: true
  has_many :logs, inverse_of: :course, dependent: :destroy
  accepts_nested_attributes_for :logs, allow_destroy: true, reject_if: :all_blank
  validates_associated :logs
end
