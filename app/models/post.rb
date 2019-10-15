class Post < ApplicationRecord
	has_many :likes, dependent: :delete_all
	belongs_to :author, class_name: 'User', foreign_key: 'author_id'
	has_many :comments, as: :commentable
	validates :content, presence: true, length: { maximum: 10000 }
	validates :author_id, presence: true

	def commentz
		Comment.where("commentable_id = ?", id).order(updated_at: :desc)
	end
end
