class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :name
      t.integer :prize_id
      t.integer :raffle_id
      t.string :email

      t.timestamps 
    end
  end

  def self.down
    drop_table :participants
  end
end
