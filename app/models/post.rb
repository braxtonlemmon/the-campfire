class Post < ApplicationRecord
	include PublicActivity::Common 

	has_many :likes, dependent: :delete_all
	belongs_to :author, class_name: 'User', foreign_key: 'author_id'
	has_many :comments, as: :commentable, dependent: :delete_all
	has_one_attached :image

	validates :content, presence: true, length: { maximum: 10000 }

	def all_comments
		Comment.where("commentable_id = ?", id).order(updated_at: :desc)
	end
end
