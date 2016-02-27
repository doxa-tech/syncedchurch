class EventsController < ApplicationController
  load_and_authorize except: :agenda

  def index
    @table = Table.new(self, Event, @events)
    @table.respond
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.recurrence_attributes = recurrence_params
    if @event.save
      redirect_to event_path(@event), success: t("events.new.success")
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @event.assign_attributes(event_params)
    @event.recurrence_attributes = recurrence_params
    if @event.save
      redirect_to edit_event_path(@event), success: t("events.edit.success")
    else
      render 'new'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def agenda
    @categories = Event.categories
    render layout: "agenda"
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :tstart, :dstart, :tend, :dend, :location, :url, :visibility, :category)
  end

  def recurrence_params
    params.require(:event).require(:recurrence).permit(:frequence, :until, :count, monthly: [])
  end
end
