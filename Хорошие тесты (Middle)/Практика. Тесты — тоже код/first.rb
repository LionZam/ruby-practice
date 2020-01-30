class Attachment < ActiveRecord::Base
  MAX_ATTACHMENT_SIZE = 1.gigabyte

  validate :file_size_is_limited

  private

  def file_size_is_limited
    if attachment_size > MAX_ATTACHMENT_SIZE
      errors.add(:attachment, "size is limited to 1GB per attachment")
    end
  end
end

describe Attachment do
  let(:attachment) { build :attachment, file: file}

  describe "#errors" do
    subject(:errors) { attachment.errors }

    before { allow(attachment).to recieve(:attachment_size).and_return(attachment_size)

    context "when file size is more than max attachment size" do
      let(:attachment_size) { Attachment::MAX_ATTACHMENT_SIZE + 1.megabyte }

      it "contains validation error" do
        expect(subject.first).to eq("Attachment size is limited to 1GB per attachment")
      end
    end

    context "when file size is less than max attachment size" do
      let(:attachment_size) { Attachment::MAX_ATTACHMENT_SIZE - 1.megabyte }

      it { is_expected }.to be_empty
    end

    context "when file size is eqaul max attachment size" do
      let(:attachment_size) { Attachment::MAX_ATTACHMENT_SIZE }

      it { is_expected }.to be_empty
    end
  end
end
