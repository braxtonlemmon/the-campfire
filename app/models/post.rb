class Post < ApplicationRecord
	has_many :likes, dependent: :delete_all
	belongs_to :author, class_name: 'User', foreign_key: 'author_id'

	validates :content, presence: true, length: { maximum: 10000 }
	validates :author_id, presence: true
end
