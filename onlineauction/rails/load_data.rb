# Load data: Derek sells a Wii. Daniel and Tony bid on it. Chuck is left out for the moment. Sorry mate :-)
Auction.delete_all
Bid.delete_all
Item.delete_all
Seller.delete_all
User.delete_all
daniel = User.create(:name => "Daniel", :email => "daniel@nouvelles-solutions.com")
tony = User.create(:name => "Tony", :email => "tony@effectiveui.com")
derek = User.create(:name => "Derek", :email => "derek@flexonrails.net", :seller => Seller.new)
RAILS_DEFAULT_LOGGER.debug "@@@Derek:#{derek.id} INSPECT#{derek.inspect}"
seller = derek.seller
auction = seller.auctions.create(:duration => 24, 
                                  :title => "Awesome Wii", 
                                  :start_bid => 24, 
                                  :reserve_price => 220,
                                  :buy_now_price => 249,
                                  :item => Item.create(:description => "Wii"))
auction.bids.create(:user => daniel, :price => 25)                                  
auction.bids.create(:user => tony, :price => 28)                                  
