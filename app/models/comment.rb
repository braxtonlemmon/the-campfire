class Comment < ApplicationRecord
	include PublicActivity::Common
	# tracked owner: ->(controller, model) { controller && controller.current_user }
	
	belongs_to :commentable, polymorphic: true
	belongs_to :author, class_name: 'User', foreign_key: 'author_id'

	validates :content, presence: true, length: { maximum: 5000 } 
	validates :commentable_id, presence: true
	validates :commentable_type, presence: true
	validates :author_id, presence: true

	def author
		User.find_by(id: author_id)
	end
end
