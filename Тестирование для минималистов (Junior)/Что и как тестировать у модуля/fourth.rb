class Book
  def file_url
    "/system/#{path_prefix}/#{filename}"
  end

  def delete_file
    self.filename = nil
    self.file_destroyed_at = Time.now
    save
  end

  private

  def path_prefix
    filename[0..1].downcase
  end
end

describe Book do
  describe "#file_url" do
    context "filename size has only one symbol" do
      subject(:book) { described_class.new(filename: "a") }

      it "has file_url" do
        expect(book.file_url).to eq "/system/a/a"
      end
    end
  end

  describe "#delete_file" do
    let(:book) { described_class.new(filename: "abc") }

    before do
      time_now = Time.now
      
      book.delete_file 
      allow(Time).to receive(:now).and_return(time_now)
    end

    it "deletes filename" do
      expect(book.filename).to be_nil
    end

    it "sets file destroyed at now" do
      expect(Time).to have_received(:now)
      expect(book.file_destroyed_at).to eq(time_now)
    end
  end
end