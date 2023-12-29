namespace :videos do
  task create: :environment do
    Video.delete_all

    videos = [
      ['videos/our-journey-towards-sustanability/our-journey-towards-sustanability', '@1920x1080.mp4,@1920x1080.webm,@1920x1080.ogg,@800x449.jpg', "Interflux Electronics's journey towards sustainability"],
      ['videos/selective-soldering-with-LMPA-Q-at-30mms/selective-soldering-with-LMPA-Q-at-30mms', '@411x338.mp4,@411x338.webm,@411x338.jpg', 'Selective soldering with LMPA-Q at 30mm per second'],
      ['videos/selective-soldering-with-SAC-at-5mms/selective-soldering-with-SAC-at-5mms', '@411x338.mp4,@411x338.webm,@411x338.jpg', 'Selective soldering with SAC at 5mm per second'],
      ['videos/webinars/interflux-webinar-chemical-reliabilty-of-residues-on-an-electronic-circuit', '@1920x1080.mp4,@1920x1080.jpg', 'interflux webinar chemical reliabilty of residues on an electronic circuit'],
      ['videos/webinars/interflux-webinar-low-melting-point-soldering', '@1920x1080.mp4,@1920x1080.jpg', 'interflux webinar low melting point soldering'],
      ['videos/webinars/interflux-webinar-preheating-wave-soldering', '@1920x1080.mp4,@1920x1080.jpg', 'interflux webinar preheating wave soldering'],
      ['videos/webinars/interflux-webinar-rework-and-repair-from-the-perspective-of-the-soldering-materials', '@1920x1080.mp4,@1920x1080.jpg', 'interflux webinar rework and repair from the perspective of the soldering materials'],
      ['videos/webinars/interflux-webinar-selective-soldering', '@1920x1080.mp4,@1920x1080.jpg', 'interflux webinar selective soldering'],
      ['videos/webinars/interflux-webinar-soldering-webinar-wave-soldering', '@1920x1080.mp4,@1920x1080.jpg', 'interflux webinar soldering webinar wave soldering'],
      ['videos/webinars/interflux-webinar-spray-fluxing-wave-soldering', '@1920x1080.mp4,@1920x1080.jpg', 'interflux webinar spray fluxing wave soldering'],
      ['videos/webinars/interflux-webinar-stencil-printing-part-1-the-printing-parameters', '@1920x1080.mp4,@1920x1080.jpg', 'interflux webinar stencil printing part 1 the printing parameters'],
      ['videos/webinars/interflux-webinar-stencil-printing-part-2-the-solder-paste', '@1920x1080.mp4,@1920x1080.jpg', 'interflux webinar stencil printing part 2 the solder paste'],
      ['videos/ICSF-Select6/ICSF-Select6', '@1920x1080.mp4,@1920x1080.webm,@1920x1080.jpg', 'ICSF Select6']
    ]

    videos.each do |video|
      path = video[0]
      variations = video[1]
      title = video[2]

      Video.create!(path: path, title: title, variations: variations)
    end
  end

  def log
    Rails.logger
  end
end
