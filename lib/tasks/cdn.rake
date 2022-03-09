namespace :cdn do
  desc 'For each file in the CDN we need a database entry. This task helps us sync CDN and database.'

  task report: :environment do
    puts 'starting sync'
    db = CdnFile.all.map(&:path)
    puts 'db paths collected'
    cdn = `s3cmd ls s3://cdn-interflux/ --recursive`.scan(%r{s3://cdn-interflux/(.*)\n}).flatten
    puts 'cdn paths collected'
    to_add = cdn - db
    to_remove = db - cdn
    puts '------'
    puts 'to add to database:'
    if to_add.length > 0
      to_add.sort.each do |path|
        puts "ADD #{path}"
      end
    else
      puts 'nothing'
    end
    puts '------'
    puts 'to remove from database:'
    if to_remove.length > 0
      to_remove.sort.each do |path|
        puts "REMOVE #{path}"
      end
    else
      puts 'nothing'
    end
    puts '------'
  end

  task sync: :environment do
    puts 'starting sync'
    db = CdnFile.all.map(&:path)
    puts 'db paths collected'
    cdn = `s3cmd ls s3://cdn-interflux/ --recursive`.scan(%r{s3://cdn-interflux/(.*)\n}).flatten
    puts 'cdn paths collected'
    to_add = cdn - db
    to_remove = db - cdn
    puts '------'
    puts 'to add to database:'
    if to_add.length > 0
      to_add.each do |path|
        puts "ADD #{path}"
        props = OpenStruct.new(
          path: path
        )
        CdnFile.create!(props.to_h)
        puts 'done'
      end
    else
      puts 'nothing'
    end
    puts '------'
    puts 'to remove from database:'
    if to_remove.length > 0
      to_remove.each do |path|
        puts "REMOVE #{path}"
        record = CdnFile.find_by(path: path)
        record.destroy
        puts 'done'
      end
    else
      puts 'nothing'
    end
    puts '------'
    puts 'sync complete'
  end
end
