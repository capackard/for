class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.xml
  def index
    render :xml => categories
  end

  # POST /categories
  # POST /categories.xml
  def create
    parent = Category.find_by_id(params[:node][:parent_id])
    params[:node].delete(:parent_id) 
    @category = Category.new(params[:node])
    if @category.save
      parent.add_child(@category) if parent
      render :xml => categories, :status => :created
    else
      render :xml => @category.errors
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])
    params[:node].delete(:id)
    if @category.update_attributes(params[:node])
      render :xml => categories
    else
      render :xml => @category.errors
    end
  end

  def move
    parent = Category.find_by_id(params[:node][:parent_id])
    @category = Category.find(params[:node][:id])
    @category.move_to_child_of(parent)
    render :xml => categories
  end
  
  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    render :xml => categories
  end
  
  private
  
  def categories
    Category.result_to_attributes_xml(Category.root.full_set)
  end
end
