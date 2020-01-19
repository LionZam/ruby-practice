describe TodoPresenter do
  describe "#as_json" do
    context "when todo's target is a Post" do
      let(:project) { create(:project) }
      let(:post) { create(:post, project: project) }
      let(:todo) { create(:todo, :target => post) }
      subject { todo.as_json }
 
      it "includes reference number" do
        subject["reference_number"]).to eq post.reference_number
      end
    end
  end
end