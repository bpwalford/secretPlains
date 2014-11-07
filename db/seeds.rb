User.delete_all

counter = 1

5.times do

  User.create(
    email: "user" + counter.to_s + "@asdf.com"
  )

  counter += 1

end
