module V1
  module Public
    class CompanyMemberSerializer < ApplicationSerializer
      attribute :public

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
