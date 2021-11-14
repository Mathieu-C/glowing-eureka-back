class Review < ApplicationRecord
  validates :rating, :body, presence: true
  validates :body, length: { minimum: 1, maximum: 2048 }
  validates :rating, inclusion: { in: [1, 2, 3, 4, 5], message: "This rating is not allowed." }
end
