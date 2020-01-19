describe Attachment do
  describe "#published?" do
    context "when attachable is a Finding" do
      subject { described_class.new(attachable: build(:finding, published: true)) }

      it { is_expected.published?.should be_true }
    end
 
    context "when attachable is not Finding" do
      subject { described_class.new(attachable: build(:todo)) }

      it { is_expected.published?.should be_false }
    end
  end
 
  describe "#editable?" do
    context "when word document is attached" do
      subject { create(:attachment, :attachment_file_name => "word.docx") }
      
      it { is_expected.editable?.should be_true }
    end
    
    context "when pdf is attached" do
      subject { create(:attachment, :attachment_file_name => "word.docx") }
      
      it { is_expected.editable?.should be_false }
    end
  end
end