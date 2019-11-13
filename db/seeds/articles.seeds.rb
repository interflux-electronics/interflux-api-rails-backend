require 'yaml'
require 'byebug'
require 'ap'

count_before = Article.count

puts '---------'
puts 'Seeding articles'
puts '---------'

file = File.read 'db/seeds/data/articles.yml'
data = YAML.safe_load(file)

data.each_with_index do |_article, i|
  article = OpenStruct.new(_article)

  puts "#{i + 1} - #{article.title}"

  record = Article.find_by(slug: article.slug)

  properties = OpenStruct.new(
    slug: article.slug,
    title: article.title,
    body: article.body,
  )

  if record.nil?
    Article.create!(properties.to_h)
  else
    record.update!(properties.to_h)
  end
end

puts '---------'
count_after = Article.count
difference = count_after - count_before
puts "Before seeding, the database had #{count_before} articles."
puts "After seeding, the database has #{count_after}."
puts "That's #{difference} new ones."
puts '---------'
puts 'Success!'
puts '---------'
puts ' '
