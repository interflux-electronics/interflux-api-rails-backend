require 'csv'
require 'byebug'
require 'ap'

after :product_families,
      :products,
      :features,
      :containers do

  puts '---------'
  puts 'Seeding product variants'
  puts '---------'

  count_before = Product.count

  file = File.read 'db/seeds/data/product_variants.csv'
  data = CSV.parse(file)

  data.each_with_index do |arr, i|
    code = arr[0]
    name = arr[1]

    # Correct inconsistent spelling
    name = name.sub('µ- dIFe', 'µ-dIFe')
    name = name.sub('Bright1', 'Bright 1')
    name = name.sub('Delphine ', 'DP ')
    name = name.sub('DP5600', 'DP 5600')
    name = name.sub('IF 710/V4', 'IF 710 V4')
    name = name.sub("IF 9007'", 'IF 9007')
    name = name.sub('IF14-', 'IF 14-')
    name = name.sub('IF8300', 'IF 8300')
    name = name.sub('IF910', 'IF 910')
    name = name.sub('í-Flex', 'i-Flex')
    name = name.sub(/^Interflux /, '')
    name = name.sub('Anti-Oxidant Pellets', 'Anti-oxidant pellets')
    name = name.sub('NH1', 'NH 1')
    name = name.gsub(/  /, ' ')
    name = name.sub('Pacific', 'PacIFic')
    name = name.sub('Plain Solderwire', 'Plain solder wire')
    name = name.sub('Solder pellets/Grenaille', 'Solder pellets')
    name = name.sub('Solder Stones', 'Solder stones')
    name = name.sub('Solderbar', 'Solder bar')
    name = name.sub('Solder bar(', 'Solder bar ')
    name = name.sub('Soldersticks', 'Solder sticks')
    name = name.sub('TerrIFic RP 65', 'TerrIFic RP65')

    byebug if name.nil?

    is_flux = name.match?(/Soldering Flux|Gel Flux|Soldering Dip Flux|T 2005M Thinner|T 1000 Conditioner/i)
    is_paste = name.match?(/Solderpaste|Dip Paste/i)
    is_wire = name.match?(/Solderwire|Solder wire/i)
    is_machine = name.match?(/ICSF/i)
    is_aux = name.match?(/Clean Wipes|Pellets|pellets|De-oxidising gel|De-Oxidation Oil|Fluxpen|Fluxstone|Soldermask|Solder sticks|Tip Tinner|Solder bar|Solder Stones|Stencil Cleaner|Purgel|Adhesive Remover Wipes|Soldersticks|Neutral Solution|LMPA™ Oil|Reagent|IPA\/DI Wipes|Stencil Clean|IPA\/DI Cleaner/i)

    count = [is_flux, is_paste, is_wire, is_machine, is_aux].select { |i| i == true }.count

    return byebug if count > 1

    family = '/// UNKNOWN'
    family = 'Flux   ' if is_flux
    family = 'Paste  ' if is_paste
    family = 'Wire   ' if is_wire
    family = 'Machine' if is_machine
    family = 'Aux    ' if is_aux

    puts "#{i} | #{family} | #{code} | #{name}"

    family_name = 'Soldering fluxes' if is_flux
    family_name = 'Solder pastes' if is_paste
    family_name = 'Solder wires' if is_wire
    family_name = 'Spray fluxers' if is_machine
    family_name = 'Auxiliaries' if is_aux

    return byebug if family_name.nil?

    family = ProductFamily.find_by(name_plural: family_name)

    return byebug if family.nil?

    series = ProductSeries.all.where(product_family_id: family.id)

    matches = series.select do |s|
      search = s.name
      # It's important to add the space to avoid mismatching:
      # IF 2005 vs IF 2005C
      # DP 5505 vs DP 5505IC
      search += ' ' unless search.start_with?('IF 14')
      if search.starts_with? 'Q6'
        name.starts_with? search
      else
        name.include? search
      end
    end

    return byebug if matches.count > 1
    return byebug if matches.count < 1

    record = Product.find_by(code: code)

    properties = OpenStruct.new(
      code: code,
      name: name,
      product_series_id: matches[0].id
    )

    if record.nil?
      Product.create(properties.to_h)
    else
      record.update(properties.to_h)
    end
  end

  puts '---------'
  count_after = Product.count
  difference = count_after - count_before
  puts "Before seeding, the database had #{count_before} products."
  puts "After seeding, the database has #{count_after}."
  puts "That's #{difference} new ones."
  puts '---------'
  puts 'Success!'
  puts '---------'
  puts ' '
end
