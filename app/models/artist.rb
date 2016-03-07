class Artist < ActiveRecord::Base
  has_many :songs
  has_many :albums, through: :songs
  
  validates :name, presence: true
end
