class VegetablesController < ApplicationController
  # GET /vegetables
  # GET /vegetables.xml
  def index
    @vegetables = Vegetable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @vegetables }
    end
  end

  # GET /vegetables/1
  # GET /vegetables/1.xml
  def show
    @vegetable = Vegetable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vegetable }
    end
  end

  # GET /vegetables/new
  # GET /vegetables/new.xml
  def new
    @vegetable = Vegetable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @vegetable }
    end
  end

  # GET /vegetables/1/edit
  def edit
    @vegetable = Vegetable.find(params[:id])
  end

  # POST /vegetables
  # POST /vegetables.xml
  def create
    @vegetable = Vegetable.new(params[:vegetable])

    respond_to do |format|
      if @vegetable.save
        format.html { redirect_to(@vegetable, :notice => 'Vegetable was successfully created.') }
        format.xml  { render :xml => @vegetable, :status => :created, :location => @vegetable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @vegetable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vegetables/1
  # PUT /vegetables/1.xml
  def update
    @vegetable = Vegetable.find(params[:id])

    respond_to do |format|
      if @vegetable.update_attributes(params[:vegetable])
        format.html { redirect_to(@vegetable, :notice => 'Vegetable was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @vegetable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vegetables/1
  # DELETE /vegetables/1.xml
  def destroy
    @vegetable = Vegetable.find(params[:id])
    @vegetable.destroy

    respond_to do |format|
      format.html { redirect_to(vegetables_url) }
      format.xml  { head :ok }
    end
  end
end
