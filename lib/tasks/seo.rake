namespace :seo do
  task check: :environment do
    url = ENV['url']
    conn = Faraday.new(
      headers: { 'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8' }
    )
    response = conn.get(url)
    html = Nokogiri::HTML(response.body)
    puts '------'
    html.css('title').each do |title|
      puts title.to_html.gsub(/\n|\s\s/, '')
    end
    puts '------'
    html.css([
      'meta[name="description"]',
      'meta[name=robots]',
      'meta[property^="og:"]'
    ].join(', ')).each do |meta|
      puts meta.to_html.gsub(/\n|\s\s/, '')
    end
    puts '------'
    html.css([
      'link[rel="canonical"]',
      'link[rel="alternate"]',
      'link[rel="icon"]'
    ].join(', ')).each do |links|
      puts links.to_html.gsub(/\n|\s\s/, '')
    end
    puts '------'
    # html.css('meta,link').each do |meta|
    #   puts meta.to_html.gsub(/\n|\s\s/, '')
    # end
  end
end
