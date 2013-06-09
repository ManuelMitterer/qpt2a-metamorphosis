  # Autoren:  Manuel Mitterer, Matthias Prieth
  # Lizenz:   AGPL 3

class Reward < ActiveRecord::Base
  attr_accessible :description, :name, :picture_link
  has_and_belongs_to_many :users
end
