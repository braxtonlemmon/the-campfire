class Post < ApplicationRecord
	include PublicActivity::Common 

	has_many :likes, dependent: :delete_all
	belongs_to :author, class_name: 'User', foreign_key: 'author_id'
	has_many :comments, as: :commentable, dependent: :delete_all
	validates :content, presence: true, length: { maximum: 10000 }
	validates :author_id, presence: true

	has_one_attached :image

	def all_comments
		Comment.where("commentable_id = ?", id).order(updated_at: :desc)
	end
end
