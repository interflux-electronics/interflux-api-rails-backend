module V1
  module Admin
    class VideoSerializer < ApplicationSerializer
      attributes :path,
                 :variations,
                 :title_public,
                 :title_admin,
                 :poster_url

      has_many :cdn_files, if: requested?('cdn_files')
    end
  end
end
