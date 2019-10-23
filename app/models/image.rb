class Image < ApplicationRecord
	include PublicActivity::Common 
	
	has_many :likes, dependent: :delete_all
	belongs_to :author, class_name: 'User', foreign_key: 'author_id'
	has_many :comments, as: :commentable
	has_one_attached :image
	
end
