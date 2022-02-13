module V1
  module Public
    class LanguageSerializer < ApplicationSerializer
      attributes :name_english,
                 :name_native,
                 :three_letter_code,
                 :public
    end
  end
end


# create_table "languages", primary_key: "two_letter_code", id: :string, force: :cascade do |t|
#   t.string "name_english"
#   t.string "name_native"
#   t.string "three_letter_code"
#   t.boolean "public", default: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end
