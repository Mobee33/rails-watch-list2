# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
require "json"
require "open-uri"

url = "https://tmdb.lewagon.com/movie/top_rated"
movie_serialized = URI.open(url).read
movie = JSON.parse(movie_serialized)

puts "cleaning databases"
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts "Creating movies..."
i = 0
Movie.create(title: "#{movie["results"][i]["original_title"]}", overview: "#{movie["results"][i]["overview"]}", poster_url: "https://www.themoviedb.org/t/p/w500#{movie["results"][i]["poster_path"]}")
puts "Created #{Movie.count} new movie"
100.times do |number|
  i += 1
  Movie.create(title: "#{movie["results"][i]["original_title"]}", overview: "#{movie["results"][i]["overview"]}", poster_url: "https://www.themoviedb.org/t/p/w500#{movie["results"][i]["poster_path"]}")
  puts "Created #{Movie.count} new movies"
end
