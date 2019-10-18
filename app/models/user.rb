class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
				 :recoverable, :rememberable, :validatable,
				 :omniauthable, omniauth_providers: %i[facebook]

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
	has_many :images, foreign_key: 'author_id', dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :comments, foreign_key: 'author_id', dependent: :destroy

	has_one_attached :avatar
	
	validates :name, presence: true, length: { maximum: 40 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: {maximum: 255},
										format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true										
	
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
			user.email = auth.info.email
			user.password = Devise.friendly_token[0, 20]
			user.name = auth.info.name   # assuming the user model has a name
			# user.image = auth.info.image # assuming the user model has an image
			# If you are using confirmable and the provider(s) you use validate emails, 
			# uncomment the line below to skip the confirmation emails.
			# user.skip_confirmation!
		end
	end

	def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


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
				.order(updated_at: :desc)
	end	
	
	def like(post)
		likes << post
	end

	def unlike(like)
		likes.delete(like)
	end

	def likes?(post)
		like = Like.where('post_id = ? and user_id = ?', post.id, id)
		like.count > 0
	end

end
