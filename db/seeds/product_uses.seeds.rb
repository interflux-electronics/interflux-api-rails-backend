require 'yaml'
require 'byebug'
require 'ap'

after :products, :uses do
  count_before = ProductUse.count

  puts '---------'
  puts 'Seeding product use'
  puts '---------'

  file = File.read 'db/seeds/data/uses.yml'
  data = YAML.safe_load(file)

  data.each_with_index do |_use, i|
    use = OpenStruct.new(_use)
    puts "#{i + 1} - #{use.name}"

    use.products.each_with_index do |product_name, ii|
      puts "#{i + 1}.#{ii + 1} - #{product_name}"

      use_record = Use.find_by(name: use.name)
      product_record = Product.find_by(name: product_name)
      relation_record = ProductUse.where(product_id: product_record.id).where(use_id: use_record.id).first

      properties = OpenStruct.new(
        product_id: product_record.id,
        use_id: use_record.id
      )

      if relation_record.nil?
        ProductUse.create!(properties.to_h)
      else
        relation_record.update!(properties.to_h)
      end
    end
  end

  puts '---------'
  count_after = ProductUse.count
  difference = count_after - count_before
  puts "Before seeding, the database had #{count_before} product use."
  puts "After seeding, the database has #{count_after}."
  puts "That's #{difference} new ones."
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
