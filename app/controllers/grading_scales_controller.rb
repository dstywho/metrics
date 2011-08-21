class GradingScalesController < ApplicationController
  # GET /grading_scales
  # GET /grading_scales.xml
  def index
    @grading_scales = GradingScale.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @grading_scales }
    end
  end

  # GET /grading_scales/1
  # GET /grading_scales/1.xml
  def show
    @grading_scale = GradingScale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @grading_scale }
    end
  end

  # GET /grading_scales/new
  # GET /grading_scales/new.xml
  def new
    @grading_scale = GradingScale.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grading_scale }
    end
  end

  # GET /grading_scales/1/edit
  def edit
    @grading_scale = GradingScale.find(params[:id])
  end

  # POST /grading_scales
  # POST /grading_scales.xml
  def create
    @grading_scale = GradingScale.new(params[:grading_scale])

    respond_to do |format|
      if @grading_scale.save
        format.html { redirect_to(@grading_scale, :notice => 'Grading scale was successfully created.') }
        format.xml  { render :xml => @grading_scale, :status => :created, :location => @grading_scale }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grading_scale.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /grading_scales/1
  # PUT /grading_scales/1.xml
  def update
    @grading_scale = GradingScale.find(params[:id])

    respond_to do |format|
      if @grading_scale.update_attributes(params[:grading_scale])
        format.html { redirect_to(@grading_scale, :notice => 'Grading scale was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grading_scale.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /grading_scales/1
  # DELETE /grading_scales/1.xml
  def destroy
    @grading_scale = GradingScale.find(params[:id])
    @grading_scale.destroy

    respond_to do |format|
      format.html { redirect_to(grading_scales_url) }
      format.xml  { head :ok }
    end
  end
end
