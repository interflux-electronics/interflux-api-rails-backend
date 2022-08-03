module V1
  module Admin
    class PersonSerializer < ApplicationSerializer
      attributes :first_name,
                 :last_name,
                 :chinese_name,
                 :full_name,
                 :email,
                 :phone,
                 :avatar_path,
                 :avatar_variations,
                 :avatar_caption,
                 :avatar_alt

      belongs_to :image

      has_many :companies, if: requested?('companies')
      has_many :company_members, if: requested?('company_members')

      has_many :images, if: requested?('images')
      has_many :person_images, if: requested?('person_images')

      attribute :has_user do |object|
        object.user.present?
      end
    end
  end
end
