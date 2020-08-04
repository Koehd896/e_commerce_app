description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."

test_user = User.create(name: "test user", username: "test user name", email: "blah@test.com", balance: 0)

products = [
  ["iMac", 600, "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/IMac_vector.svg/1200px-IMac_vector.svg.png"],
  ["Chromebook", 299.99, "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Samsung_Series_3_Chromebook.JPG/1200px-Samsung_Series_3_Chromebook.JPG"],
  ["Beats Headphones", 150, "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/BeatsHeadphones-2_%2847705430872%29.jpg/1200px-BeatsHeadphones-2_%2847705430872%29.jpg"],
  ["Electric Mixer", 125.5, "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/White_KitchenAid_mixer_%28KSM150PSWH%29.jpg/1200px-White_KitchenAid_mixer_%28KSM150PSWH%29.jpg"],
  ["Stainless Steel Pan", 55.99, "https://upload.wikimedia.org/wikipedia/commons/5/5c/Pfanne_%28Edelstahl%29.jpg"],
  ["Microwave", 46.99, "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Consumer_Reports_-_Kenmore_microwave_oven.tif/lossy-page1-1200px-Consumer_Reports_-_Kenmore_microwave_oven.tif.jpg"],
  ["Coffee Maker", 25.99, "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Consumer_Reports_-_Zojirushi_coffeemaker_alt.tif/lossy-page1-1200px-Consumer_Reports_-_Zojirushi_coffeemaker_alt.tif.jpg"],
  ["Shoes", 20.35, "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Black_Converse_sneakers.JPG/1200px-Black_Converse_sneakers.JPG"],
  ["Hat", 15.25, "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Under_armour.JPG/1200px-Under_armour.JPG"],
  ["Skirt", 20, "https://upload.wikimedia.org/wikipedia/commons/9/96/COLLECTIE_TROPENMUSEUM_Rok_met_panoramische_beschildering_van_Indonesisch_landschap_TMnr_6217-7.jpg"]
]

products.each do |product|
  Product.create(name: product[0], price: product[1], description: description, image: product[2], user: test_user)
end
