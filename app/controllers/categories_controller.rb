class CategoriesController < ApplicationController
  def create
    @category = Category.create(categ_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to root_path, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def categ_params
    params.require(:category).permit(:name)
  end
end
