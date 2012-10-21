class Episode < ActiveRecord::Base
  belongs_to :director, class_name: Person
  belongs_to :writer, class_name: Person
  attr_accessible :original_air_date, :title
end
