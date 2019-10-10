10.times do |i|
	User.create(name:  "user#{i}",
							email:    "user#{i}@email.com",
							password: "foobar")
end