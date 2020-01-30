describe Attachment do
  describe "#published?" do
    context "when attachable is a Finding" do
      subject(:attachment) { described_class.new(attachable: build(:finding, published: true)) }

      it { is_expected.to be_published }
    end

    context "when attachable is not Finding" do
      subject(:attachment) { described_class.new(attachable: build(:todo)) }

      it { is_expected.not_to be_published }
    end
  end
  
  describe "#published?" do
    subject(:attachment) { create(:attachment, attachment_file_name: attachment_file_name) }
    
    context "when word document is attached" do
      let(:attachment_file_name) { "word.docx" }

      it { is_expected.to be_published }
    end

    context "when pdf is attached" do
      let(:attachment_file_name) { "NotOffice.pdf" }

      it { is_expected.not_to be_published }
    end
  end
end
