namespace :companies do
  task public_transfer: :environment do
    Company.where(public: true).each do |company|
      company.update!(shown_on_main_website: true)
    end
  end

  task create_icsf_suppliers: :environment do
    log.info '⛵️'

    # 1. Create the 8 missing companies.

    to_create = [
      ['AI Electronics & Technology', 'AI Electronics & Technology Co., Ltd.', '114/192 M.1 T.Samet A. Mueang, Chonburi 20000', 'Thailand', 'center.aiet@hotmail.com', 'https://www.aiet.co.th/', '+66955861119'],
      ['Elas', 'Elas Kft.', 'Diófa u. 130, Budapest, 1162', 'Hungary', 'elas@elas.hu', 'https://elas.hu', '+36 (1) 220-9401'],
      ['Link Ways Tech', 'Link Ways Tech Co., Ltd.', '16F, Block B, Jin Shi Wang Hu Building, No. 18, Jia Rui alley, SIP, China',	'China', 'dajiang.zhu@mylinkways.com', 'https://www.mylinkways.com/', '+86 177 5172 9710'],
      ['PT Tamura Trade Indonsia', nil, 'Taman Surya II Blok D2/3, Cengkareng, Jakarta Barat 11830', 'Indonesia', 'suwito@tamuratrade.com', nil, '+62811878355'],
      ['SIP Technology', 'SIP Technology (M) SDN BHD', '36 Lorong IKS Bukit Tengah, Taman IKS Bukit Tengah, Penang 14000', 'Malaysia', 'clkong@sip-technology.com', 'https://sip-technology.com/en/', '+604 508 8318'],
      ['Smartsol Technologies Mexico', nil, 'Prol. Pino Suárez 1039-int 23,El Vigía,Zapopan, Jalisco 45140',	'Mexico', 'contact@smartsol.mx', 'https://smartsol.mx/', '+52 3332713784'],
      ['Smartsol Technologies USA', nil, '12301 Rojas Dr Ste A14, El Paso, TX 79928', 'United States of America', 'contact@smartsol.mx', 'https://smartsol.mx/', '+16199007517'],
      ['VLK Techno Trade', 'V.L.K. TECHNO TRADE CO.,LTD.', '13, 36/7 Thanon Lam Luk Ka, Bueng Kham Phroi, Lam Luk Ka District, Pathum Thani 12150', 'Thailand', 'sales@vlk.th.com', 'https://www.vlktechno.com/', '+66215024751']
    ]

    to_create.each do |data|
      record = Company.find_by(business_name: data[0])

      next if record.present?

      Company.create!(
        business_name: data[0],
        legal_name: data[1],
        address: data[2],
        country: Country.find_by(name_english: data[3]),
        email_orders: data[4],
        website: data[5],
        phone: data[6]
      )
    end

    # 2. Flag 13 companies as approved ISCF distributors.

    to_approve = [
      'ABAN Electronics',
      'AI Electronics & Technology',
      'Autronix Systems',
      'Elas',
      'Interflux Singapore',
      'JRPV Semicon Supplies',
      'Link Ways Tech',
      'Oritech',
      'PT Tamura Trade Indonsia',
      'SIP Technology',
      'Smartsol Technologies Mexico',
      'Smartsol Technologies USA',
      'VLK Techno Trade'
    ]

    to_approve.each do |name|
      company = Company.find_by(business_name: name)

      raise '🔥' if company.nil?

      company.update(
        public: true,
        shown_on_icsf_website: true
      )
    end

    log.info '✅'
  end

  private

  def log
    Rails.logger
  end
end
