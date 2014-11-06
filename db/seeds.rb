User.delete_all

counter = 1

5.times do

  User.create(
    username: "user" + counter.to_s,
    password: "hello",
    password_confirmation: "hello"
  )

  counter += 1

end
