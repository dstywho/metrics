class ConstantsController < ApplicationController
  # GET /constants
  # GET /constants.xml
  def index
    @constants = Constant.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @constants }
    end
  end

  # GET /constants/1
  # GET /constants/1.xml
  def show
    @constant = Constant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @constant }
    end
  end

  # GET /constants/new
  # GET /constants/new.xml
  def new
    @constant = Constant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @constant }
    end
  end

  # GET /constants/1/edit
  def edit
    @constant = Constant.find(params[:id])
  end

  # POST /constants
  # POST /constants.xml
  def create
    @constant = Constant.new(params[:constant])

    respond_to do |format|
      if @constant.save
        format.html { redirect_to(@constant, :notice => 'Constant was successfully created.') }
        format.xml  { render :xml => @constant, :status => :created, :location => @constant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @constant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /constants/1
  # PUT /constants/1.xml
  def update
    @constant = Constant.find(params[:id])

    respond_to do |format|
      if @constant.update_attributes(params[:constant])
        format.html { redirect_to(@constant, :notice => 'Constant was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @constant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /constants/1
  # DELETE /constants/1.xml
  def destroy
    @constant = Constant.find(params[:id])
    @constant.destroy

    respond_to do |format|
      format.html { redirect_to(constants_url) }
      format.xml  { head :ok }
    end
  end
end
