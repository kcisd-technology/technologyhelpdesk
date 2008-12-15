class HowtosController < ApplicationController
  # GET /howtos
  # GET /howtos.xml
  def index
    @howtos = Howto.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @howtos }
    end
  end

  # GET /howtos/1
  # GET /howtos/1.xml
  def show
    @howto = Howto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @howto }
    end
  end

  # GET /howtos/new
  # GET /howtos/new.xml
  def new
    parent = parent_object;
    @howto = Howto.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @howto }
    end
  end

  # GET /howtos/1/edit
  def edit
    @howto = Howto.find(params[:id])
  end

  # POST /howtos
  # POST /howtos.xml
  def create
    @howto = Howto.new(params[:howto])

    respond_to do |format|
      if @howto.save
        flash[:notice] = 'Howto was successfully created.'
        format.html { redirect_to(@howto) }
        format.xml  { render :xml => @howto, :status => :created, :location => @howto }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @howto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /howtos/1
  # PUT /howtos/1.xml
  def update
    @howto = Howto.find(params[:id])

    respond_to do |format|
      if @howto.update_attributes(params[:howto])
        flash[:notice] = 'Howto was successfully updated.'
        format.html { redirect_to(@howto) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @howto.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /howtos/1
  # DELETE /howtos/1.xml
  def destroy
    @howto = Howto.find(params[:id])
    @howto.destroy

    respond_to do |format|
      format.html { redirect_to(howtos_url) }
      format.xml  { head :ok }
    end
  end
end
