10.times do |i|
	user = User.create(name:  "user#{i+1}",
							email:    "user#{i+1}@email.com",
							password: "foobar",
						)
	file_url = Faker::Avatar.image
	file = open(file_url)						
	user.avatar.attach(io: file,
												 filename: "temp.#{file.content_type_parse.first.split("/").last}",
												 content_type: file.content_type_parse.first)
end


users = User.all
users.each do |user|
	5.times do
		user.posts.create(content: Faker::Hipster.paragraph)
	end
end