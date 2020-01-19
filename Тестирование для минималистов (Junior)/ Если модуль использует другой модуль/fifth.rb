class CarwashLocator
  MAX_DISTANCE = 3000

  def self.nearest(coordinates)
    washes = Carwash.with_coordinates

    washes.select { |wash| wash.distance_to(coordinates) < MAX_DISTANCE }
  end
end

describe BatchSectionClone do
  let(:carwashes) { [create(:carwash, coordinates: [CarwashLocator::MAX_DISTANCE + 1, 0])] }
  let(:my_coordinates) { [0, 0] }

  describe ".nearest" do
    subject { described_class.nearest }

    context "when nearest carwash is exist" do
      before do
        carwashes << create(:carwash, coordinates: [CarwashLocator::MAX_DISTANCE - 1, 0] )
        allow(Carwash).to receive(:with_coordinates).and_return(carwashes)        
      end

      it { is_expected.to have(1).item }
      it { expect(subject.first).to eq(carwashes.first) }
    end

    context "when nearest carwash is exist" do
      before do
        allow(Carwash).to receive(:with_coordinates).and_return(carwashes)        
      end

      it { is_expected.to have(0).items }
    end
  end
end