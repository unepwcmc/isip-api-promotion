require 'json'
require 'csv'

f_animals = 'animals_utf8.csv'
f_plants = 'plants_utf8.csv'

change_id = 1
species = []
changes = []

[f_animals, f_plants].each do |file|
  puts "Opening file: #{file}"
  table = CSV.read(file)
  # Columns mapping:
  # 1: full_name
  # 2: author_year
  # 4: id
  # 6: current_listing
  # 10: change_type
  # 11: relevant_listing
  ids = []
  table[1, 90].each do |row|
    unless ids.include? row[4]
      ids << row[4]
      species << {
        :id => row[4],
        :full_name => row[1],
        :author_year => row[2],
        :current_listing => row[6],
      }
      changes << {
        :id => change_id,
        :taxon_concept_id => row[4],
        :change_type => row[9],
        :species_listing_name => row[10]
      }
      change_id += 1
    end
  end
  puts "Finished file #{file}"
end
puts "Adding data to species.json"
File.open("species.json", "a") do |f|
  f.write(species.to_json)
end
puts "Adding data to changes.json"
File.open("changes.json", "a") do |f|
  f.write(changes.to_json)
end
