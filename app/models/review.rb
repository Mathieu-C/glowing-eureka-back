class Review < ApplicationRecord
  validates :rating, :body, presence: true
  validates :body, length: { minimum: 1, maximum: 2048 }
  validates :rating, inclusion: { in: [1, 2, 3, 4, 5], message: "This rating is not allowed." }

  after_create :notify_review_created

  class << self
    def on_change
      Review.connection.execute "LISTEN reviews"
      loop do
        Review.connection.raw_connection.wait_for_notify do |event, pid, review|
          yield review
        end
      end
    ensure
      Review.connection.execute "UNLISTEN reviews"
    end
  end

  def json_content
    JSON.generate({ rating: rating, body: body })
  end

  def notify_review_created
    Review.connection.execute "NOTIFY reviews, '#{self.json_content}'"
  end
end
