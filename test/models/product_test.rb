# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id           :integer          not null, primary key
#  name         :string
#  slug         :string
#  visible      :string           default("f")
#  product_type :string
#  pitch        :string
#  corpus       :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'should not save product without name' do
    product = Product.new
    assert_not product.save, 'Saved the product without a name'
  end

  test 'should not save product without product_type' do
    product = Product.new
    assert_not product.save, 'Saved the product without a product_type'
  end

  test 'should not save product without pitch' do
    product = Product.new
    assert_not product.save, 'Saved the product without a pitch'
  end

  test 'should report error' do
    # some_undefined_variable is not defined elsewhere in the test case
    assert_raises(NameError) do
      some_undefined_variable
    end
  end
end
