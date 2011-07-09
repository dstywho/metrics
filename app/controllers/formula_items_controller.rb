class FormulaItemsController < ApplicationController
  # GET /formula_items
  # GET /formula_items.xml
  def index
    @formula_items = FormulaItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @formula_items }
    end
  end

  # GET /formula_items/1
  # GET /formula_items/1.xml
  def show
    @formula_item = FormulaItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @formula_item }
    end
  end

  # GET /formula_items/new
  # GET /formula_items/new.xml
  def new
    @formula_item = FormulaItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @formula_item }
    end
  end

  # GET /formula_items/1/edit
  def edit
    @formula_item = FormulaItem.find(params[:id])
  end

  # POST /formula_items
  # POST /formula_items.xml
  def create
    @formula_item = FormulaItem.new(params[:formula_item])

    respond_to do |format|
      if @formula_item.save
        format.html { redirect_to(@formula_item, :notice => 'Formula item was successfully created.') }
        format.xml  { render :xml => @formula_item, :status => :created, :location => @formula_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @formula_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /formula_items/1
  # PUT /formula_items/1.xml
  def update
    @formula_item = FormulaItem.find(params[:id])

    respond_to do |format|
      if @formula_item.update_attributes(params[:formula_item])
        format.html { redirect_to(@formula_item, :notice => 'Formula item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @formula_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /formula_items/1
  # DELETE /formula_items/1.xml
  def destroy
    @formula_item = FormulaItem.find(params[:id])
    @formula_item.destroy

    respond_to do |format|
      format.html { redirect_to(formula_items_url) }
      format.xml  { head :ok }
    end
  end
end
