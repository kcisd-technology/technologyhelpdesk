class NotationsController < ApplicationController
  # GET /notations
  # GET /notations.xml
  def index
    @notations = Notation.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notations }
    end
  end

  # GET /notations/1
  # GET /notations/1.xml
  def show
    @notation = Notation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @notation }
    end
  end

  # GET /notations/new
  # GET /notations/new.xml
  def new
    @notation = Notation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @notation }
    end
  end

  # GET /notations/1/edit
  def edit
    @notation = Notation.find(params[:id])
  end

  # POST /notations
  # POST /notations.xml
  def create
    @notation = Notation.new(params[:notation])

    respond_to do |format|
      if @notation.save
        flash[:notice] = 'Notation was successfully created.'
        format.html { redirect_to(@notation) }
        format.xml  { render :xml => @notation, :status => :created, :location => @notation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @notation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notations/1
  # PUT /notations/1.xml
  def update
    @notation = Notation.find(params[:id])

    respond_to do |format|
      if @notation.update_attributes(params[:notation])
        flash[:notice] = 'Notation was successfully updated.'
        format.html { redirect_to(@notation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @notation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notations/1
  # DELETE /notations/1.xml
  def destroy
    @notation = Notation.find(params[:id])
    @notation.destroy

    respond_to do |format|
      format.html { redirect_to(notations_url) }
      format.xml  { head :ok }
    end
  end
end
