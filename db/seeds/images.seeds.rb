require 'byebug'
require 'ap'

after :products do
  count_before = Image.count

  puts '---------'
  puts 'Seeding images'
  puts '---------'

  products = Product.all

  products.each_with_index do |product, i|
    puts "#{i + 1} - #{product.name}"

    sets = {
      'soldering-fluxes': [
        '25L drum front right top',
        '5L drum front right top',
        '1L bottle front top',
        '200L barrel front top',
        'all containers'
      ],
      'solder-pastes': [
        'front top',
        'right top',
        'inside without lid'
      ],
      'solder-wires': [
        'front-top',
        'front',
        'top',
        'wire zoomed in',
        'all coil sizes',
        'all wire thicknesses',
        'all alloys'
      ]
    }

    tags = sets[product.family.slug.to_sym] || ['avatar']

    tags.each_with_index do |tag, ii|
      puts "#{i}.#{ii} - #{tag}"

      cdn_path = "/images/products/#{product.family.slug}-#{product.slug}-#{tag.parameterize}.jpg"

      properties = OpenStruct.new(
        cdn_path: cdn_path,
        sizes: '2000x2000,1800x1800,1600x1600,1400x1400,1200x1200,1000x1000,800x800,600x600,500x500,400x400,300x300,200x200,100x100',
        formats: 'webp,jpg',
        tag_long: "#{product.family.name_single} #{product.name} #{tag}",
        tag_short: tag
      )

      record = Image.find_by(cdn_path: cdn_path)

      if record.nil?
        Image.create!(properties.to_h)
      else
        record.update!(properties.to_h)
      end
    end

    # processes = SolderingProcesses.all
    #
    # processes.each_with_index do |process, i|
    #   puts "#{i + 1} - #{process.name}"
    #
    #   # /videos/processes/wave-soldering-closeup-of-wave.webm
    #   # /videos/processes/wave-soldering-closeup-of-wave.mp4
    #   # /videos/processes/wave-soldering-closeup-of-wave-poster.jpg
    #
    #   # /images/processes/wave-soldering-circuit-board-moving-through-wave.webp
    #   # /images/processes/wave-soldering-circuit-board-moving-through-wave.jpg
    #
    #   sets = {
    #     'wave-soldering': [
    #       'hero video',
    #       'hero',
    #       'closeup of wave',
    #       'circuit board moving through wave',
    #       'final result',
    #       'wave soldering machine ERSA',
    #     ],
    #     'selective-soldering': [
    #       'hero video',
    #       'hero',
    #       'close-up of spray nozzle',
    #       'close-up of alloy fountain',
    #       'circuit board being sprayed',
    #       'circuit board being soldered',
    #       'circuit board being sprayed video',
    #       'circuit board being soldered video'
    #     ],
    #   }
    #
    #   tags = sets[product.family.slug.to_sym] || ['hero video.mp4', 'hero.jpg']
    #
    #   tags.each_with_index do |tag, ii|
    #
    #     puts "#{i}.#{ii} - #{tag}"
    #
    #     ext = tag.include? "video" ? ".mp4"
    #
    #     cdn_path = "/images/processes/#{process.slug}-#{tag}.#{ext}"
    #
    #     properties = OpenStruct.new(
    #       cdn_path: cdn_path,
    #       sizes: '2000x1125,1800x1012,1600x900,1400x787,1200x675,1000x562,800x450,600x337,500x281,400x281,300x168,200x112,100x56',
    #       formats: 'webm,mp4',
    #       alt: "#{product.family.name_single} #{product.name} #{tag}",
    #       caption: tag
    #     )
    #
    #     record = Image.find_by(cdn_path: cdn_path)
    #
    #     if record.nil?
    #       Image.create!(properties.to_h)
    #     else
    #       record.update!(properties.to_h)
    #     end
    #   end
    # end
  end

  puts '---------'
  count_after = Image.count
  difference = count_after - count_before
  puts "Before seeding, the database had #{count_before} images."
  puts "After seeding, the database has #{count_after}."
  puts "That's #{difference} new ones."
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
