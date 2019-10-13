class FriendRequest < ApplicationRecord
	belongs_to :inviter, class_name: 'User'
	belongs_to :invitee, class_name: 'User'

	validates :inviter_id, presence: true
	validates :invitee_id, presence: true
end
