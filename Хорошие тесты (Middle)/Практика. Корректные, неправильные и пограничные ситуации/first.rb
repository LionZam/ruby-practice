class TodoPresenter
  MAX_TAGS_ALLOWED = 4
 
  def display_text
    return todo.title unless todo.tags.any?
 
    todo_title_with_tags(todo)
  end
 
  private
 
  def todo_title_with_tags(todo)
    if (1..MAX_TAGS_ALLOWED).cover? todo.tags.count
      [todo.title, tags_list(todo.tags)].join(" ")
    else
      [todo.title, tags_list(todo.tags.first(MAX_TAGS_ALLOWED)), "and more..."].join(" ")
    end
  end
 
  def tags_list(tags)
    tags.join(", ")
  end
end

describe TodoPresenter
  let(:todo_presenter) { create :todo_presenter, tags: tags, title: "title" }

  describe "#display_text" do
    subject { todo_presenter.display_text }

    context "when tags count is zero" do
      let(:tags) { [] }

      it { is_expected }.to eq(todo_presenter.title)
    end

    context "when tags count is more than zero" do
      context "when tags count is less than max tags allowed" do
        let(:tags) { ["a", "b"]  }

        it { is_expected }.to eq("title a, b")
      end

      context "when tags count more than max tags allowed" do
        let(:tags) { %w[a b c d e] }

        it { is_expected }.to eq("title a, b, c, d and more...")
      end

      context "when tags count is max tags allowed" do
        let(:tags) { %w[a b c d] }

        it { is_expected }.to eq("title a, b, c, d")
      end
    end
  end
end

