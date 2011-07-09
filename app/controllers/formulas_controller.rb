class FormulasController < ApplicationController
  # GET /formulas
  # GET /formulas.xml
  def index
    @formulas = Formula.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @formulas }
    end
  end

  # GET /formulas/1
  # GET /formulas/1.xml
  def show
    @formula = Formula.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @formula }
    end
  end

  # GET /formulas/new
  # GET /formulas/new.xml
  def new
    @formula = Formula.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @formula }
    end
  end

  # GET /formulas/1/edit
  def edit
    @formula = Formula.find(params[:id])
  end

  # POST /formulas
  # POST /formulas.xml
  def create
    @formula = Formula.new(params[:formula])

    respond_to do |format|
      if @formula.save
        format.html { redirect_to(@formula, :notice => 'Formula was successfully created.') }
        format.xml  { render :xml => @formula, :status => :created, :location => @formula }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @formula.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /formulas/1
  # PUT /formulas/1.xml
  def update
    @formula = Formula.find(params[:id])

    respond_to do |format|
      if @formula.update_attributes(params[:formula])
        format.html { redirect_to(@formula, :notice => 'Formula was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @formula.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /formulas/1
  # DELETE /formulas/1.xml
  def destroy
    @formula = Formula.find(params[:id])
    @formula.destroy

    respond_to do |format|
      format.html { redirect_to(formulas_url) }
      format.xml  { head :ok }
    end
  end
end
