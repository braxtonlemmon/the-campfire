class Post < ApplicationRecord
	include PublicActivity::Common 
	# tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }


	has_many :likes, dependent: :delete_all
	belongs_to :author, class_name: 'User', foreign_key: 'author_id'
	has_many :comments, as: :commentable
	validates :content, length: { maximum: 10000 }
	validates :author_id, presence: true

	has_one_attached :image

	def commentz
		Comment.where("commentable_id = ?", id).order(updated_at: :desc)
	end
end
