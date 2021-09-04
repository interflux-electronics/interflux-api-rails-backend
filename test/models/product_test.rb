require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'valid on create with just slug and name' do
    product = Product.new(
      slug: 'Foo-2000',
      name: 'Foo 2000'
    )
    assert product.valid?
  end

  test 'invalid without slug' do
    product = Product.new(
      slug: nil,
      name: 'Foo 2000'
    )
    assert_not product.valid?
  end

  test 'invalid without name' do
    product = Product.new(
      slug: 'Foo-2000',
      name: nil
    )
    assert_not product.valid?
  end

  test 'invalid without status' do
    product = Product.new(
      name: 'Foo 2000',
      slug: 'Foo-2000',
      status: nil
    )
    assert_not product.valid?
  end

  test 'invalid with bogus status' do
    product = Product.new(
      name: 'Foo 2000',
      slug: 'Foo-2000',
      status: 'bogus'
    )
    assert_not product.valid?
  end

  test 'valid with 5 statuses' do
    product = Product.new(
      name: 'Foo 2000',
      slug: 'Foo-2000',
      status: 'offline'
    )
    assert product.valid?
    product.update(status: 'new')
    assert product.valid?
    product.update(status: 'popular')
    assert product.valid?
    product.update(status: 'recommended')
    assert product.valid?
    product.update(status: 'outdated')
    assert product.valid?
    product.update(status: 'discontinued')
    assert product.valid?
  end

  test 'defaults new products to offline' do
    product = Product.new(
      name: 'Foo 2000',
      slug: 'Foo-2000'
    )
    assert_equal 'offline', product.status
  end

  test 'public is set to false if status is offline' do
    product = Product.new(
      name: 'Foo 2000',
      slug: 'Foo-2000'
    )
    assert_equal false, product.public
    product.update(status: 'popular')
    assert_equal true, product.public
    product.update(status: 'offline')
    assert_equal false, product.public
  end

  test 'avatar properties are set on save' do
    product = Product.new(
      name: 'Foo 2000',
      slug: 'Foo-2000'
    )

    assert_nil product.avatar_path
    assert_nil product.avatar_variations
    assert_nil product.avatar_caption
    assert_nil product.avatar_alt

    image = Image.new(
      path: 'images/products/Foo-2000/Foo-2000-10L',
      variations: '@1200x1200.webp,@1200x1200.jpg',
      caption: 'some caption',
      alt: 'some alt'
    )

    product.update(avatar: image)

    assert_equal 'images/products/Foo-2000/Foo-2000-10L', product.avatar_path
    assert_equal '@1200x1200.webp,@1200x1200.jpg', product.avatar_variations
    assert_equal 'some caption', product.avatar_caption
    assert_equal 'some alt', product.avatar_alt

    product.update(avatar: nil)

    assert_nil product.avatar_path
    assert_nil product.avatar_variations
    assert_nil product.avatar_caption
    assert_nil product.avatar_alt
  end

  test 'slug update whenever the name updates' do
    product = Product.new(
      name: 'Foo 2000',
      slug: 'Foo-2000'
    )
    product.update(name: 'Bar™ 2000 X')
    assert_equal 'Bar-2000-X', product.slug
  end

  test 'relations update whenever the slug updates' do
    skip('TODO')
    # product = Product.new(
    #   name: 'Foo 2000',
    #   slug: 'Foo-2000'
    # )
    # product.update(name: 'Bar 2000')
  end
end
