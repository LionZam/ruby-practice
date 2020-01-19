describe Backup do
  describe ".run" do
    it "notify users that backup is ready"
  end
end

describe ControlTest do
  context '.review_queue' do
    it 'returns counts of all control test plans'
  end
end

describe Post do
  describe "#destroy" do
    it "deletes comments collection"
  end
end

describe AttachmentsController do
  describe "#download" do
    it "not includes Pragma header" do
      get :download, id: attachment.id
      # response headers should not include Pragma header
      # in order to support IE8
      expect(response.headers.keys).not_to include("Pragma")
    end
  end
end