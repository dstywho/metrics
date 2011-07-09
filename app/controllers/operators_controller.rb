class OperatorsController < ApplicationController
  # GET /operators
  # GET /operators.xml
  def index
    @operators = Operator.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @operators }
    end
  end

  # GET /operators/1
  # GET /operators/1.xml
  def show
    @operator = Operator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @operator }
    end
  end

  # GET /operators/new
  # GET /operators/new.xml
  def new
    @operator = Operator.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @operator }
    end
  end

  # GET /operators/1/edit
  def edit
    @operator = Operator.find(params[:id])
  end

  # POST /operators
  # POST /operators.xml
  def create
    @operator = Operator.new(params[:operator])

    respond_to do |format|
      if @operator.save
        format.html { redirect_to(@operator, :notice => 'Operator was successfully created.') }
        format.xml  { render :xml => @operator, :status => :created, :location => @operator }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @operator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /operators/1
  # PUT /operators/1.xml
  def update
    @operator = Operator.find(params[:id])

    respond_to do |format|
      if @operator.update_attributes(params[:operator])
        format.html { redirect_to(@operator, :notice => 'Operator was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @operator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /operators/1
  # DELETE /operators/1.xml
  def destroy
    @operator = Operator.find(params[:id])
    @operator.destroy

    respond_to do |format|
      format.html { redirect_to(operators_url) }
      format.xml  { head :ok }
    end
  end
end
