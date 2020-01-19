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
      let(:book) { described_class.new(filename: "a") }

      it "has file_url" do
        expect { book.file_url }.to eq "/system/a/a"
      end
    end
  end

  describe "#delete_file" do
    let(:book) { described_class.new(filename: "abc") }

    it "will delete filename and change file_destroyed_at" do
      expect { book.delete_file }.to change { book.filename }.to(nil)
      
      expect { book.delete_file }.to change do
        book.file_destroyed_at.strftime("%m/%d/%Y %H:%M")
      end.to(Time.now.strftime("%m/%d/%Y %H:%M"))
    end
  end
end