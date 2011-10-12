class ReportDefinitionsController < ApplicationController
  # GET /report_definitions
  # GET /report_definitions.xml
  def index
    @report_definitions = ReportDefinition.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @report_definitions }
    end
  end

  # GET /report_definitions/1
  # GET /report_definitions/1.xml
  def show
    @report_definition = ReportDefinition.find(params[:id])
    @date = params[:date].nil? ? Time.now : Time.parse(params[:date]) 
    @evaluations =  @report_definition.evaluations 
    @projects =  @report_definition.projects

    respond_to do |format|
      to_render = {:id => @report_definition.id , :evaluations => @evaluations, :projects => @projects}
      format.html # show.html.erb
      format.xml  { render :xml => to_render }
      format.json { render :json => to_render }
    end
  end

  # GET /report_definitions/new
  # GET /report_definitions/new.xml
  def new
    @report_definition = ReportDefinition.new
    @report_definition.project_report_definitions.build
    @report_definition.evaluations.build 

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @report_definition }
    end
  end

  # GET /report_definitions/1/edit
  def edit
    @report_definition = ReportDefinition.find(params[:id])
  end

  # POST /report_definitions
  # POST /report_definitions.xml
  def create
    @report_definition = ReportDefinition.new(params[:report_definition])

    respond_to do |format|
      if @report_definition.save
        format.html { redirect_to(@report_definition, :notice => 'Report definition was successfully created.') }
        format.xml  { render :xml => @report_definition, :status => :created, :location => @report_definition }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @report_definition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /report_definitions/1
  # PUT /report_definitions/1.xml
  def update
    @report_definition = ReportDefinition.find(params[:id])

    respond_to do |format|
      if @report_definition.update_attributes(params[:report_definition])
        format.html { redirect_to(@report_definition, :notice => 'Report definition was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @report_definition.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /report_definitions/1
  # DELETE /report_definitions/1.xml
  def destroy
    @report_definition = ReportDefinition.find(params[:id])
    @report_definition.destroy

    respond_to do |format|
      format.html { redirect_to(report_definitions_url) }
      format.xml  { head :ok }
    end
  end
end
