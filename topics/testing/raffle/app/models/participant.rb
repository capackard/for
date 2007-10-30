class Participant < ActiveRecord::Base

  belongs_to :raffle

  belongs_to :prize
end
