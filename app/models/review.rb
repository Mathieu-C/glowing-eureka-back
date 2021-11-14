class Review < ApplicationRecord
  validates :rating, :body, presence: true
end
