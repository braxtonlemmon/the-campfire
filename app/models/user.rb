class User < ApplicationRecord
	# Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :validatable			 
	has_many :friendships, dependent: :destroy
	has_many :friends, through: :friendships
	has_many :active_requests, class_name: 'FriendRequest',
														 foreign_key: 'inviter_id',
														 dependent: :destroy
	has_many :invitees, through: :active_requests 
	has_many :passive_requests, class_name: 'FriendRequest',
															foreign_key: 'invitee_id',
															dependent: :destroy
	has_many :inviters, through: :passive_requests
	has_many :posts, foreign_key: 'author_id', dependent: :destroy
	has_many :likes
	
	def invite(other_user)
		invitees << other_user
	end

	def uninvite(other_user)
		invitees.delete(other_user)
	end

	def invited?(other_user)
		invitees.include?(other_user)
	end
	
	def add_friend(other_user)
		friends << other_user
	end

	def remove_friend(other_user)
		friends.delete(other_user)
	end

	def feed 
		friend_ids = 'SELECT friend_id FROM friendships
									WHERE user_id = :user_id'
		Post.where("author_id IN (#{friend_ids})
								OR author_id = :user_id", user_id: id)
	end									

end
