# frozen_string_literal: true

Product.all.delete_all

Product.create(
  name: 'IF 2005M',
  slug: 'IF-2005M',
  public: true,
  product_type: 'soldering-flux',
  pitch: 'Interflux® IF 2005M is the **internationally renowned** resin- and rosin-free, no-clean / No-residue™ **flux standard**.'
)

Product.create(
  name: 'OSPI 3311M',
  slug: 'OSPI-3311M',
  public: true,
  product_type: 'soldering-flux',
  pitch: 'Interflux® OSPI 3311M is an alcohol based no-clean flux for **soldering OSP** finished boards that have passed one or more reflow cycles.'
)

Product.create(
  name: 'DP 5600',
  slug: 'DP-5600',
  public: true,
  product_type: 'solder-paste',
  pitch: 'Interflux® DP 5600 is a no-clean solder paste for **low temperature SnBi(Ag)** alloys.'
)

Product.create(
  name: 'QF 70',
  slug: 'QF-70',
  public: true,
  product_type: 'solder-wire',
  pitch: 'Interflux® **QF 70** is an absolutely halide-free, rosin based no-clean solder wire with **fast wetting for fast soldering** operations in lead-free alloys.'
)

Product.create(
  name: 'QF 50',
  slug: 'QF-50',
  public: false,
  product_type: 'solder-wire',
  pitch: 'Interflux® **QF 50** is an absolutely halide-free, rosin based no-clean solder wire with **fast wetting for fast soldering** operations in lead-free alloys.'
)

Document.create(
  name: 'Technical Data IF 2005M',
  url: 'https://cdn.interflux.com/documents/technical-data-for-soldering-flux-IF-2005M-English.pdf',
  document_type: 'TD',
  public: true
)

Document.create(
  name: 'Technical Data OSPI 3311M',
  url: 'https://cdn.interflux.com/documents/technical-data-for-soldering-flux-OSPI-3311M-English.pdf',
  document_type: 'TD',
  public: true
)

Document.create(
  name: 'Outdated document',
  url: 'https://cdn.interflux.com/documents/outdated-document.pdf',
  document_type: 'TD',
  public: false
)

Document.create(
  name: 'Wave Soldering best practices',
  url: 'https://cdn.interflux.com/documents/wave-soldering-best-practices.pdf',
  document_type: 'guide',
  public: true
)

# TODO: Learn how to do to many relationships
# product1.update(documents: [document1.id, document4.id])
# product2.update(documents: [document2.id, document4.id])
