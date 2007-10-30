class RafflesController < ApplicationController
  # GET /raffles
  # GET /raffles.xml
  def index
    @raffles = Raffle.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @raffles }
    end
  end

  # GET /raffles/1
  # GET /raffles/1.xml
  def show
    @raffle = Raffle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @raffle }
    end
  end

  # GET /raffles/new
  # GET /raffles/new.xml
  def new
    @raffle = Raffle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @raffle }
    end
  end

  # GET /raffles/1/edit
  def edit
    @raffle = Raffle.find(params[:id])
  end

  # POST /raffles
  # POST /raffles.xml
  def create
    @raffle = Raffle.new(params[:raffle])

    respond_to do |format|
      if @raffle.save
        flash[:notice] = 'Raffle was successfully created.'
        format.html { redirect_to(@raffle) }
        format.xml  { render :xml => @raffle, :status => :created, :location => @raffle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @raffle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /raffles/1
  # PUT /raffles/1.xml
  def update
    @raffle = Raffle.find(params[:id])

    respond_to do |format|
      if @raffle.update_attributes(params[:raffle])
        flash[:notice] = 'Raffle was successfully updated.'
        format.html { redirect_to(@raffle) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @raffle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /raffles/1
  # DELETE /raffles/1.xml
  def destroy
    @raffle = Raffle.find(params[:id])
    @raffle.destroy

    respond_to do |format|
      format.html { redirect_to(raffles_url) }
      format.xml  { head :ok }
    end
  end
end
