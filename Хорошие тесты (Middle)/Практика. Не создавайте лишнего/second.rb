class Event < ActiveRecord::Base
  attr_accessible :date
end
 
class EventPresenter
  def initialize(event)
    @event = event
  end
 
  def date
    case @event.date
    when Date.today
      "Today"
    when Date.yesterday
      "Yesterday"
    else
      @event.date.to_s
    end
  end
end

describe EventPresenter do
  subject(:date_presentation) { .date }

  def create_event(date)
    event = instance_double(Event, date: date)
    described_class.new(event)
  end

  describe "#date" do
    context "when event date is today" do
      it { expect(create_event(Date.today).date).to eq("Today") }
    end

    context "when event date is yesterday" do        
      it { expect(create_event(Date.yesterday).date).to eq("Yesterday") }
    end

    context "when event date in midnight" do        
      it { expect(create_event(Date.midnight).date).to eq("Today") }
    end

    context "when event date is tomorrow" do        
      it { expect(create_event(Date.new("12/12/2019")).date).to eq("12/12/2019") }
    end
  end
end