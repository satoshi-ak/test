class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  scope :expired, -> {order(expired_at: :desc)}
  scope :search_title,->(title){where("title LIKE?","%#{title}%")}
  scope :search_status,->(status){where(status: status)}
  scope :priority_sort, ->(priority){where(priority: priority)}
  enum status: { 高: "0", 中: "1", 低: "2"}
  enum priority: { 未着手: "0", 着手中: "1", 完了: "2"}
end
