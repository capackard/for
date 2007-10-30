class Prize < ActiveRecord::Base

  belongs_to :raffle

  has_one :participant
end
