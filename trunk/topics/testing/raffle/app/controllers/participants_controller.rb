class ParticipantsController < ApplicationController
  before_filter :get_raffle
  
  # GET /participants
  # GET /participants.xml
  def index
    @participants = @raffle.participants.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @participants }
    end
  end

  # GET /participants/1
  # GET /participants/1.xml
  def show
    @participant = @raffle.participants.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @participant }
    end
  end

  # GET /participants/new
  # GET /participants/new.xml
  def new
    @participant = Participant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @participant }
    end
  end

  # GET /participants/1/edit
  def edit
    @participant = @raffle.participants.find(params[:id])
  end

  # POST /participants
  # POST /participants.xml
  def create
    @participant = @raffle.participants.build(params[:participant])

    respond_to do |format|
      if @participant.save
        flash[:notice] = 'Participant was successfully created.'
        format.html { redirect_to(raffle_participant_url(@raffle, @participant)) }
        format.xml  { render :xml => @participant, :status => :created, :location => @participant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @participant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /participants/1
  # PUT /participants/1.xml
  def update
    @participant = @raffle.participants.find(params[:id])

    respond_to do |format|
      if @participant.update_attributes(params[:participant])
        flash[:notice] = 'Participant was successfully updated.'
        format.html { redirect_to(raffle_participant_url(@raffle, @participant)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @participant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.xml
  def destroy
    @participant = @raffle.participants.find(params[:id])
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to(raffle_participants_url(@raffle)) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def get_raffle
  	@raffle = Raffle.find(params[:raffle_id])
  end  
  
end
