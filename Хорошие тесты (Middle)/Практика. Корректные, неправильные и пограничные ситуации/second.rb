describe Attachment do
  subject { create: attachment }

  let(:ms_offce_types) {
    [
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      "application/vnd.openxmlformats-officedocument.presentationml.presentation",
      "application/msword",
      "application/vnd.ms-excel",
      "application/vnd.ms-powerpoint"
    ]
  }

  describe "#editable?" do
    ms_offce_types.each do |ms_offce_type|
     context "when attachment_content_type is #{ms_offce_type}" do
      let(:attachment) { create: attachment, attachment_content_type: ms_offce_type }

      public_send("it", "returns true") do
        expect(attachment.editable?).to be true
      end
    end
  end
end
