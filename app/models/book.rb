class Book < ActiveRecord::Base
  belongs_to :user
  validates :title, :author, :content, :description, presence: true
  # :has_uploadcare_group
end
