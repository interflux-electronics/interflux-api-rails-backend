# frozen_string_literal: true

# Product.all.delete_all
# ProductGroup.all.delete_all
# ProductSubGroup.all.delete_all
# ProductUse.all.delete_all

# ProductTranslation.all.delete_all
# ProductGroupTranslation.all.delete_all
# ProductSubGroupTranslation.all.delete_all
# Feature.all.delete_all
# Process.all.delete_all
# Document.all.delete_all

# PRODUCT GROUPS

# @flux = ProductGroup.create!(
#   name: 'Soldering flux',
#   plural: 'Soldering fluxes',
#   slug: 'soldering-fluxes'
# )
#
# @paste = ProductGroup.create!(
#   name: 'Solder paste',
#   plural: 'Solder pastes',
#   slug: 'solder-pastes'
# )
#
# @wire = ProductGroup.create!(
#   name: 'Solder wire',
#   plural: 'Solder wires',
#   slug: 'solder-wires'
# )
#
# @spray = ProductGroup.create!(
#   name: 'Spray fluxer',
#   plural: 'Spray fluxers',
#   slug: 'spray-fluxers'
# )
#
# @aux = ProductGroup.create!(
#   name: 'Auxiliary',
#   plural: 'Auxiliaries',
#   slug: 'auxiliaries'
# )

# PRODUCT SUB GROUPS

# @alcohol_flux = ProductSubGroup.create!(
#   product_group: @flux,
#   name: 'Alcohol-based soldering flux',
#   plural: 'Alcohol-based soldering fluxes',
#   slug: 'alcohol-based'
# )
#
# @voc_free_flux = ProductSubGroup.create!(
#   product_group: @flux,
#   name: 'VOC-free soldering flux',
#   plural: 'VOC-free soldering flux',
#   slug: 'VOC-free'
# )
#
# @low_voc_flux = ProductSubGroup.create!(
#   product_group: @flux,
#   name: 'Low VOC soldering flux',
#   plural: 'Low VOC soldering flux',
#   slug: 'low-VOC'
# )
#
# @rosin_flux = ProductSubGroup.create!(
#   product_group: @flux,
#   name: 'Rosin-based soldering flux',
#   plural: 'Rosin-based soldering flux',
#   slug: 'rosin-based'
# )
#
# @rework_flux = ProductSubGroup.create!(
#   product_group: @flux,
#   name: 'Soldering flux for rework & repair',
#   plural: 'Soldering fluxes for rework & repair',
#   slug: 'for-rework-and-repair'
# )
#
# @flux_thinner = ProductSubGroup.create!(
#   product_group: @flux,
#   name: 'Flux thinner',
#   plural: 'Flux thinners',
#   slug: 'flux-thinner'
# )
#
# @no_clean_paste = ProductSubGroup.create!(
#   product_group: @paste,
#   name: 'No-clean solder paste',
#   plural: 'No-clean solder pastes',
#   slug: 'no-clean-solder-pastes'
# )
#
# @no_clean_paste = ProductSubGroup.create!(
#   product_group: @paste,
#   name: 'No-clean solder paste',
#   plural: 'No-clean solder pastes',
#   slug: 'no-clean-solder-pastes'
# )
#
# @lmpa = ProductSubGroup.create!(
#   product_group: @paste,
#   name: 'Low melting point solder paste',
#   plural: 'Low melting point solder pastes',
#   slug: 'low-melting-point-solder-pastes'
# )
#
# @lead_free_wire = ProductSubGroup.create!(
#   product_group: @wire,
#   name: 'Lead-free solder wire',
#   plural: 'Lead-free solder wires',
#   slug: 'lead-free-solder-wires'
# )
#
# @lead_wire = ProductSubGroup.create!(
#   product_group: @wire,
#   name: 'Lead-based solder wire',
#   plural: 'Lead-based solder wires',
#   slug: 'lead-based-solder-wires'
# )
#
# @standalone_spray = ProductSubGroup.create!(
#   product_group: @spray,
#   name: 'Standalone spray fluxer',
#   plural: 'Standalone spray fluxers',
#   slug: 'standalone-spray-fluxers'
# )
#
# @retrofit_spray = ProductSubGroup.create!(
#   product_group: @spray,
#   name: 'Retrofit spray fluxer',
#   plural: 'Retrofit spray fluxers',
#   slug: 'retrofit-spray-fluxers'
# )
#
# @product_tool = ProductSubGroup.create!(
#   product_group: @aux,
#   name: 'Production tool',
#   plural: 'Production tools',
#   slug: 'production-tools'
# )
#
# @cleaning_product = ProductSubGroup.create!(
#   product_group: @aux,
#   name: 'Cleaning product',
#   plural: 'Cleaning products',
#   slug: 'cleaning-products'
# )
#
# @solder_bath_treatement = ProductSubGroup.create!(
#   product_group: @aux,
#   name: 'Cleaning product',
#   plural: 'Cleaning products',
#   slug: 'cleaning-products'
# )
#
# @solder_alloys = ProductSubGroup.create!(
#   product_group: @aux,
#   name: 'Solder alloy',
#   plural: 'Solder alloys',
#   slug: 'solder-alloys'
# )

# PROCESS

# @for_wave = Use.create!(
#   name: 'For wave soldering'
# )
#
# @for_selective = Use.create!(
#   name: 'For selective soldering'
# )
#
# @for_reflow = Use.create!(
#   name: 'Solder wires'
# )
#
# @for_rework = Use.create!(
#   name: 'For rework & repair'
# )
#
# @for_pre_tinning = Use.create!(
#   name: 'For pre-tinning'
# )

# PRODUCTS

# @product1 = Product.create!(
#   name: 'IF 2005M',
#   slug: 'IF-2005M',
#   public: true,
#   product_group: @flux,
#   product_sub_group: @alcohol_flux,
#   uses: [ @for_wave ]
#   pitch: 'Interflux® IF 2005M is the **internationally renowned** resin- and rosin-free, no-clean / No-residue™ **flux standard**.'
# )
#
# @product2 = Product.create!(
#   name: 'OSPI 3311M',
#   slug: 'OSPI-3311M',
#   public: true,
#   product_type: 'soldering-flux',
#   pitch: 'Interflux® OSPI 3311M is an alcohol based no-clean flux for **soldering OSP** finished boards that have passed one or more reflow cycles.'
# )
#
# Product.create!(
#   name: 'DP 5600',
#   slug: 'DP-5600',
#   public: true,
#   product_type: 'solder-paste',
#   pitch: 'Interflux® DP 5600 is a no-clean solder paste for **low temperature SnBi(Ag)** alloys.'
# )
#
# Product.create!(
#   name: 'QF 70',
#   slug: 'QF-70',
#   public: true,
#   product_type: 'solder-wire',
#   pitch: 'Interflux® **QF 70** is an absolutely halide-free, rosin based no-clean solder wire with **fast wetting for fast soldering** operations in lead-free alloys.'
# )
#
# Product.create!(
#   name: 'QF 50',
#   slug: 'QF-50',
#   public: false,
#   product_type: 'solder-wire',
#   pitch: 'Interflux® **QF 50** is an absolutely halide-free, rosin based no-clean solder wire with **fast wetting for fast soldering** operations in lead-free alloys.'
# )
#
# ProductTranslation.create!(
#   locale: 'fr',
#   name: 'French name',
#   pitch: 'French pitch',
#   body: 'French body',
#   product_id: @product1.id
# )
#
# ProductTranslation.create!(
#   locale: 'de',
#   name: 'German name',
#   pitch: 'German pitch',
#   body: 'German body',
#   product_id: @product1.id
# )
#
# Document.create!(
#   name: 'Technical Data IF 2005M',
#   url: 'https://cdn.interflux.com/documents/technical-data-for-soldering-flux-IF-2005M-English.pdf',
#   document_type: 'TD',
#   public: true
# )
#
# Document.create!(
#   name: 'Technical Data OSPI 3311M',
#   url: 'https://cdn.interflux.com/documents/technical-data-for-soldering-flux-OSPI-3311M-English.pdf',
#   document_type: 'TD',
#   public: true
# )
#
# Document.create!(
#   name: 'Outdated document',
#   url: 'https://cdn.interflux.com/documents/outdated-document.pdf',
#   document_type: 'TD',
#   public: false
# )
#
# Document.create!(
#   name: 'Wave Soldering best practices',
#   url: 'https://cdn.interflux.com/documents/wave-soldering-best-practices.pdf',
#   document_type: 'guide',
#   public: true
# )

# User.create!(
#   email: 'admin@interflux.com',
#   password: 'password',
#   can_access_admin: true
# )

# TODO: Learn how to do to many relationships
# product1.update(documents: [document1.id, document4.id])
# product2.update(documents: [document2.id, document4.id])
