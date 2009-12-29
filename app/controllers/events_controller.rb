class EventsController < ApplicationController
  
  # Don't use the layout for AJAX methods
  layout "events.html", :except => [:show, :edit, :new]

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
    set_default_start_and_end_times @event

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
    fix_times_for_all_day_event
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        flash[:notice] = '"' + @event.name + '" has been added.'
        format.html { redirect_to_calendar @event }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        flash[:error] = error_string "add", @event
        format.html { redirect_to_calendar @event }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
    fix_times_for_all_day_event

    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = '"' + @event.name + '" has been updated.'
        format.html { redirect_to_calendar @event }
        format.xml  { head :ok }
      else
        flash[:error] = error_string "update", @event
        format.html { redirect_to_calendar @event }
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
      flash[:notice] = '"' + @event.name + '" has been deleted.'
      format.html { redirect_to_calendar @event }
      format.xml  { head :ok }
    end
  end
  
private

  def set_default_start_and_end_times event
    event.start_at = Time.utc params[:year], params[:month], params[:day], 18, 00
    event.end_at = event.start_at + 1.hour
  end

  def fix_times_for_all_day_event
    if params[:event][:all_day] == "1"
      params[:event]["start_at(4i)"], params[:event]["start_at(5i)"] = "00", "00"
      params[:event]["end_at(4i)"], params[:event]["end_at(5i)"] = "23", "59"
    end
  end
  
  def redirect_to_calendar event
    redirect_to calendar_path(:year => event.start_at.year, :month => event.start_at.month)
  end

  def error_string action, event
    e_str = "Failed to #{action} "
    e_str << (event.name.blank? ? "event:" : '"' + event.name + '":')
    event.errors.full_messages.each do |error|
      e_str << " #{error};"
    end
    e_str.chop << "."
  end

end
