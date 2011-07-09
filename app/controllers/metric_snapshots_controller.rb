class MetricSnapshotsController < ApplicationController
  # GET /metric_snapshots
  # GET /metric_snapshots.xml
  def index
    @metric_snapshots = MetricSnapshot.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @metric_snapshots }
    end
  end

  # GET /metric_snapshots/1
  # GET /metric_snapshots/1.xml
  def show
    @metric_snapshot = MetricSnapshot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @metric_snapshot }
    end
  end

  # GET /metric_snapshots/new
  # GET /metric_snapshots/new.xml
  def new
    @metric_snapshot = MetricSnapshot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @metric_snapshot }
    end
  end

  # GET /metric_snapshots/1/edit
  def edit
    @metric_snapshot = MetricSnapshot.find(params[:id])
  end

  # POST /metric_snapshots
  # POST /metric_snapshots.xml
  def create
    @metric_snapshot = MetricSnapshot.new(params[:metric_snapshot])

    respond_to do |format|
      if @metric_snapshot.save
        format.html { redirect_to(@metric_snapshot, :notice => 'Metric snapshot was successfully created.') }
        format.xml  { render :xml => @metric_snapshot, :status => :created, :location => @metric_snapshot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @metric_snapshot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /metric_snapshots/1
  # PUT /metric_snapshots/1.xml
  def update
    @metric_snapshot = MetricSnapshot.find(params[:id])

    respond_to do |format|
      if @metric_snapshot.update_attributes(params[:metric_snapshot])
        format.html { redirect_to(@metric_snapshot, :notice => 'Metric snapshot was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @metric_snapshot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /metric_snapshots/1
  # DELETE /metric_snapshots/1.xml
  def destroy
    @metric_snapshot = MetricSnapshot.find(params[:id])
    @metric_snapshot.destroy

    respond_to do |format|
      format.html { redirect_to(metric_snapshots_url) }
      format.xml  { head :ok }
    end
  end
end
