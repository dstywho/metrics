class EvaluationsController < ApplicationController
  # GET /evaluations
  # GET /evaluations.xml
  def index
    if params[:report_definition_id]
      @evaluations = Evaluation.find_all_by_report_definition_id(params[:report_definition_id])
    else
      @evaluations = Evaluation.all
    end
      

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @evaluations }
      format.json { render :json => @evaluations }
    end
  end

  # GET /evaluations/1
  # GET /evaluations/1.xml
  def show
    @evaluation = Evaluation.find(params[:id])
    if params[:project_id]
      datetime = params[:datetime] ? Time.parse(params[:datetime]) : Time.now
      if params[:all]
        @calculation = @evaluation.evaluate_all(Project.find_by_id(params[:project_id]),datetime,params[:numMonths])
      else
        @calculation = @evaluation.evaluate(Project.find_by_id(params[:project_id]),datetime)
      end
    end  

    respond_to do |format|
      to_be_rendered = @calculation.nil? ? @evaluation: @calculation
      format.html # show.html.erb
      format.xml  { render :xml => to_be_rendered}
      format.json { render :json => to_be_rendered}
    end
  end

  # GET /evaluations/new
  # GET /evaluations/new.xml
  def new
    @evaluation = Evaluation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @evaluation }
      format.json { render :json => @evaluation }
    end
  end

  # GET /evaluations/1/edit
  def edit
    @evaluation = Evaluation.find(params[:id])
  end

  # POST /evaluations
  # POST /evaluations.xml
  def create
    @evaluation = Evaluation.new(params[:evaluation])

    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to(@evaluation, :notice => 'Evaluation was successfully created.') }
        format.xml  { render :xml => @evaluation, :status => :created, :location => @evaluation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @evaluation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /evaluations/1
  # PUT /evaluations/1.xml
  def update
    @evaluation = Evaluation.find(params[:id])

    respond_to do |format|
      if @evaluation.update_attributes(params[:evaluation])
        format.html { redirect_to(@evaluation, :notice => 'Evaluation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @evaluation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.xml
  def destroy
    @evaluation = Evaluation.find(params[:id])
    @evaluation.destroy

    respond_to do |format|
      format.html { redirect_to(evaluations_url) }
      format.xml  { head :ok }
    end
  end
end
