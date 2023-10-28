namespace :companies do
  task public_transfer: :environment do
    Company.where(public: true).each do |company|
      company.update!(shown_on_main_website: true)
    end
  end
end
