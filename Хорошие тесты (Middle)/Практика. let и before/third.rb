describe TodoPresenter do
  describe "#as_json" do
    subject(:as_json) { todo.as_json }

    context "when todo's target is a Post" do
      let(:project) { build_stubbed(:project) }
      let(:post) { build_stubbed(:post, project: project) }
      let(:todo) { build_stubbed(:todo, :target => post) }
 
      it "includes reference number" do
        expect(as_json["reference_number"]).to eq(post.reference_number)
      end
    end
  end
end