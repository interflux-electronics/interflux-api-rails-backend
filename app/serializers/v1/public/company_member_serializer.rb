module V1
  module Public
    class CompanyMemberSerializer < ApplicationSerializer
      attribute :public,
                :public_title,
                :public_email,
                :public_phone,
                :rank_among_companies,
                :rank_among_members

      attribute :title, if: proc { |record, _params|
        record.public_title
      }

      attribute :email, if: proc { |record, _params|
        record.public_email
      }

      attribute :phone, if: proc { |record, _params|
        record.public_phone
      }

      belongs_to :company
      belongs_to :person
    end
  end
end
