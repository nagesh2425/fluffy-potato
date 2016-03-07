class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist
  
  validates :name, presence: true, length: { in: 5..50 }
  validates :album_id, :artist_id, presence: true
  
  scope :recent, ->(number) { where("created_at > ?", 6.months.ago).select("name").limit(number).order("created_at DESC") }
   
end
