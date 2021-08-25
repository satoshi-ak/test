class Task < ApplicationRecord
  scope :expired, -> {order(expired_at: :desc)}
  scope :search_title,->(title){where("title LIKE?","%#{title}%")}
  scope :search_status, ->(status){where("name LIKE?","%#{status}%")}
end
