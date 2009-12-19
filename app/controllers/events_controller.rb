class EventsController < ApplicationController
  
  # Don't use the layout for AJAX methods
  layout "events.html", :except => [:show, :edit, :new]
  
  # GET /events
  # GET /events.xml
=begin
  def index
    @month = params[:month].to_i
    @year = params[:year].to_i

    if @month.zero? or @year.zero?
      @events = Event.all
    else
      @shown_month = Date.civil(@year, @month)
      @events = events_for_month(@shown_month)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end
=end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    @event.start_at = Time.utc params[:year], params[:month], params[:day]
    @event.end_at = @event.start_at

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    # set the start and end times correctly for all day events
    if params[:event][:all_day] == "1"
      params[:event]["start_at(4i)"], params[:event]["start_at(5i)"] = "00", "00"
      params[:event]["end_at(4i)"], params[:event]["end_at(5i)"] = "23", "59"
    end
    
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to(calendar_path(:year => @event.start_at.year,
          :month => @event.start_at.month)) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
    
    # set the start and end times correctly for all day events
    if params[:event][:all_day] == "1"
      params[:event]["start_at(4i)"], params[:event]["start_at(5i)"] = "00", "00"
      params[:event]["end_at(4i)"], params[:event]["end_at(5i)"] = "23", "59"
    end

    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = @event.name + ' was successfully updated.'
        format.html { redirect_to(calendar_path(:year => @event.start_at.year,
          :month => @event.start_at.month)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(calendar_path(:year => @event.start_at.year,
        :month => @event.start_at.month)) }
      format.xml  { head :ok }
    end
  end

end
