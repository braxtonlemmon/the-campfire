class Comment < ApplicationRecord
	include PublicActivity::Common

	belongs_to :commentable, polymorphic: true
	belongs_to :author, class_name: 'User', foreign_key: 'author_id'

	validates :content, presence: true, length: { maximum: 5000 } 

	def author
		User.find_by(id: author_id)
	end
end
