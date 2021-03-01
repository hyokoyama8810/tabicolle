# frozen_string_literal: true

class Log < ApplicationRecord
  belongs_to :course
  validates :spot, presence: true
end
