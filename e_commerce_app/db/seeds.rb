description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."

test_user = User.create(name: "test user", username: "test user name", email: "blah@test.com", balance: 0)

products = [
  ["iMac", 600, "images/iMac.jpeg"]
]

products.each do |product|
  Product.create(name: product[0], price: product[1], description: description, image: product[2], user: test_user)
end
