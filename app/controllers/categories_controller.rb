class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[edit update destroy]

  # GET /categories
  def index
    @categories = current_user.categories.order(:name)
  end

  # GET /categories/new
  def new
    @category = current_user.categories.new
  end

  # POST /categories
  def create
    @category = current_user.categories.new(category_params)

    if @category.save
      redirect_to categories_path, notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /categories/:id/edit
  def edit
  end

  # PATCH/PUT /categories/:id
  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /categories/:id
  def destroy
    if @category.transactions.exists?
      redirect_to categories_path,
                  alert: "You cannot delete a category that has transactions."
    else
      @category.destroy
      redirect_to categories_path, notice: "Category was successfully deleted."
    end
  end

  private

    def set_category
      @category = current_user.categories.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to categories_path, alert: "Category not found."
    end

    def category_params
      params.require(:category).permit(:name)
    end
end

