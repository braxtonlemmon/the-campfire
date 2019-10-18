module UsersHelper
	def avatar_for(user, size = 150)
		image_tag user.avatar.variant(resize: "#{size}x#{size}") if user.avatar.attached?
	end
end
