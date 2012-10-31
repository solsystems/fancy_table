FactoryGirl.define do
  factory :episode do
    sequence :title do |n|
      "Episode #{n}"
    end
    director
    writer
    original_air_date Date.new(2012, 12, 20)
  end

  factory :person, aliases: [:director, :writer] do
    name "Joss Whedon"
  end
end
