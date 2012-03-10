class Vehicle < ActiveRecord::Base
  # Text box sizes for display in the views
  NUMBER_SIZE = 20
  TYPE_SIZE = 20
  SUBTYPE_SIZE = 20
  CAPACITY_SIZE = 20
  FROM_SIZE = 20
  TO_SIZE = 20
  TYPE_VALUES = ["Train", "Bus"]
  SUB_TYPE_VALUES = ["Passenger", "Express", "Superfast", "Ultra Deluxe", "Deluxe", "Semi Deluxe", "Air Bus", "Volvo AC"]
  BOOK_VALUES = (1..10).to_a

  validates_uniqueness_of :number  

#  validates_inclusion_of :type, :in => []
#  validates_inclusion_of :sub_type, :in => []
  validates_presence_of :number
end
