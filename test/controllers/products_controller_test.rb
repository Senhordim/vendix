require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @categories = categories
  end

  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select '.product', 3
    assert_select '.category', 6
  end

  test 'render a list of products filtered by category' do
    get products_path(category_id: categories(:computers).id)
    assert_response :success
    assert_select '.product', 1
  end

  test 'render a detailed product page' do
    get product_path(products(:ps4))
    assert_response :success
    assert_select '.title', 'PS4 Fat'
    assert_select '.description', 'PS4 em bom estado'
    assert_select '.price', '1300'
  end

  test 'render a new product form' do
    get new_product_path
    assert_response :success
    assert_select 'form'
  end

  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: 'OCulos 3D',
        description: 'em perfeito estado',
        price: 500,
        category_id: categories(:videogames).id
      }
    }

    flash_notice = flash['notice']

    assert_redirected_to products_path
    assert_equal flash_notice[:created], 'Produto criado com sucesso'
  end

  # test 'Does not allow to create a new product with empty fields' do
  #   post products_path, params: {
  #     product: {
  #       title: '',
  #       description: 'em perfeito estado',
  #       price: 500,
  #       category_id: categories(:videogames).id
  #     }
  #   }

  #   assert_response :unprocessable_entity
  # end

  # test 'render an edit product form' do
  #   get edit_product_path(products(:ps4))
  #   assert_response :success
  #   assert_select 'form'
  # end

  # test 'allow to update a product' do
  #   patch product_path(products(:ps4)), params: {
  #     product: {
  #       price: 399
  #     }
  #   }

  #   assert_redirected_to products_path
  #   assert_equal flash[:notice], 'Product was successfully updated.'
  # end

  # test 'does not allow to update a product' do
  #   patch product_path(products(:ps4)), params: {
  #     product: {
  #       price: nil
  #     }
  #   }

  #   assert_response :unprocessable_entity
  # end

  # test 'can delete a product' do
  #   assert_difference('Product.count', -1) do
  #     delete product_path(products(:ps4))
  #   end

  #   assert_redirected_to products_path
  #   assert_equal flash[:notice], 'Product was successfully destroyed.'
  # end
end
