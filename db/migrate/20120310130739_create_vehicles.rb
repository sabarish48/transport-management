class CreateVehicles < ActiveRecord::Migration
  def self.up
    create_table :vehicles do |t|
      t.column :number, :string
      t.column :main_type, :string
      t.column :sub_type, :string
      t.column :capacity, :integer
      t.column :available, :integer
      t.column :from, :string
      t.column :to, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :vehicles
  end
end
