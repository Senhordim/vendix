# ProductsController
class ProductsController < ApplicationController
  def index
    @products = Product.all.with_attached_photo.order(created_at: :desc)
  end

  def show
    product
  end

  def new
    @product = Product.new
    @categories = Category.all.order(name: :asc)
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path, notice: t('.create')
    else
      render :new, status: :unprocessable_entity, alert: 'Product was not created.'
    end
  end

  def edit
    product
  end

  def update
    if product.update(product_params)
      redirect_to products_path, notice: t('.update')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    product.destroy
    redirect_to products_path, notice: t('.destroy'), status: :see_other
  end

  private

  def product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end
end
