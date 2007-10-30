class Raffle < ActiveRecord::Base
  has_many :participants
  has_many :prizes
end
