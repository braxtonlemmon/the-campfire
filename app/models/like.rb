class Like < ApplicationRecord
	include PublicActivity::Common 
	belongs_to :user
	belongs_to :post
	
	validates :user_id, presence: true
	validates :post_id, presence: true
end
