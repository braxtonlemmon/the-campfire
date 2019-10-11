10.times do |i|
	User.create(name:  "user#{i+1}",
							email:    "user#{i+1}@email.com",
							password: "foobar")
end

users = User.all
users.each do |user|
	5.times do
		user.posts.create(content: 'random blah blah blah blah')
	end
end