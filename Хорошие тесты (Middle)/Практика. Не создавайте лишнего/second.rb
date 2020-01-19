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
  subject(:date_presentation) { described_class.new(event).date }

  describe "#date" do
    context "when event date is today" do
      let(:event) { instance_double(Event, date: Date.today }

      it { date_presentation }.to eq("Today")
    end

    context "when event date is yesterday" do
      let(:event) { instance_double(Event, date: Date.yesterday }
        
      it { date_presentation }.to eq("Yesterday")
    end

    context "when event date in midnight" do
      let(:event) { instance_double(Event, date: Date.midnight }
        
      it { date_presentation }.to eq("Today")
    end

    context "when event date is tomorrow" do
      let(:event) { instance_double(Event, date: Date.today.next_day }
        
      it { date_presentation }.to Date.today.next_day.to_s
    end
  end
end