Category.transaction do
  root = Category.create(:name => "Main Category")

  cameras = Category.create(:name => "Cameras & Photo")
  cameras.add_child(Category.create(:name => "Bags"))
  cameras.add_child(Category.create(:name => "Accessories"))
  cameras.add_child(Category.create(:name => "Analog Cameras"))
  cameras.add_child(Category.create(:name => "Digital Cameras"))

  phones = Category.create(:name => "Cell Phones")
  phones.add_child(Category.create(:name => "Accessories"))
  phones.add_child(Category.create(:name => "Phones"))
  phones.add_child(Category.create(:name => "Prepaid Cards"))

  dvds = Category.create(:name => "Dvds")
  dvds.add_child(Category.create(:name => "Blueray"))
  dvds.add_child(Category.create(:name => "HD DVD"))
  dvds.add_child(Category.create(:name => "DVD"))

  root.add_child(cameras)
  root.add_child(phones)
  root.add_child(dvds)
end