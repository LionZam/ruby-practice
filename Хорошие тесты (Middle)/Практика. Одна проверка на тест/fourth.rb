describe CommentsController do
  describe "POST create" do
    context "with valid params given" do
      before { post :create, valid_params }

      it "creates comment" do
        expect(response).to be_a_successful_rendered_template
        expect(assigns[:comment]).to be_a_comment_representation
        expect(CommentNotifier).to have_received(:notify)
      end
    end
  end
end

RSpec::Matchers.define :be_a_successful_rendered_template do
  match do |response|
    expect(response).to be_success
    expect(response).to render_template("index")
  end
end

RSpec::Matchers.define :be_a_comment_representation do
  match do |actual|
    expect(actual).to be
    expect(actual.commentable).to eq resource
    expect(actual.user).to be
  end
end
