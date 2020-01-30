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
  let(:event) { instance_double(Event, date: date }

  describe "#date" do
    context "when event date is today" do
      let(:date) { Date.today }

      it { expect(date_presentation).to eq("Today") }
    end

    context "when event date is yesterday" do
      let(:date) { Date.yesterday }
        
      it { expect(date_presentation).to eq("Yesterday") }
    end

    context "when event date in midnight" do
      let(:date) { Date.midnight }
        
      it { expect(date_presentation).to eq("Today") }
    end

    context "when event date is tomorrow" do
      let(:date) { Date.new("12/12/2019") }
        
      it { expect(date_presentation).to eq("12/12/2019")
    end
  end
end