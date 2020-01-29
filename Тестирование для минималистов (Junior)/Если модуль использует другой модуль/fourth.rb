class BatchSectionClone
  def self.clone(sections, target)
    sections.map do |section|
      SectionClone.new(section, target).clone
    end
  end
end

describe BatchSectionClone do
  describe ".clone" do
    let(:sections) { build_list :section, 5 }
    let(:target) { build_stubbed :target }

    before do
      section_clone_double = double(SectionClone, clone: true)
      allow(SectionClone).to receive(:new).and_return(section_clone_double) 

      described_class.clone(sections, target)
    end

    it "clones all sections" do
      expect(SectionClone).to have_received(:new).exactly(sections.size).times
      expect(section_clone_double).to have_received(:clone).exactly(sections.size).times
    end
  end
end