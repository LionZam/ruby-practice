class CarwashLocator
  MAX_DISTANCE = 3000

  def self.nearest(coordinates)
    washes = Carwash.with_coordinates

    washes.select { |wash| wash.distance_to(coordinates) < MAX_DISTANCE }
  end
end

describe CarwashLocator do
  subject(:carwash_locator) { described_class.new }

  describe ".nearest" do
    before do
      carwash_further_than_max_distance = double("Carwash", distance_to: CarwashLocator::MAX_DISTANCE + 1)
      carwash_closer_than_max_distance = double("Carwash", distance_to: CarwashLocator::MAX_DISTANCE - 1)
      carwashes = [carwash_closer_than_max_distance, carwash_further_than_max_distance]

      allow(Carwash).to receive(:with_coordinates).and_return(carwashes)        
    end

    it "not returns carwashes further than max distance" do
      expect(carwash_locator.nearest).to eq([carwash_closer_than_max_distance])
    end
  end
end