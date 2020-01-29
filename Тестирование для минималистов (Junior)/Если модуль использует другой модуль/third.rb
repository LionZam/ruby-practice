class TodoAssigneeNotifier
  def self.notify(todo)
    if NotificationManager.allows_notifying_membership?(todo.executor)
      TodoMailer.todo_notification(todo)
    end

    PushNotification.deliver("todo_assign", todo.executor, todo)
  end
end

describe TodoAssigneeNotifier do
  let(:todo) { build_stubbed :todo }

  describe ".notify" do
    context "when todo executor allows_notifying_membership" do
      before do
        allow(NotificationManager).to receive(:allows_notifying_membership).and_return(true)
        allow(TodoMailer).to receive(:todo_notification).with(todo)
        allow(PushNotification).to receive(:deliver).with("todo_assign", todo.executor, todo)
      end

      it { expect(TodoMailer).to have_received(:todo_notification) }
      it { expect(PushNotification).to have_received(:deliver) }
    end

    context "when todo executor not allows_notifying_membership" do
      before do
        allow(NotificationManager).to receive(:allows_notifying_membership).and_return(false)
        allow(PushNotification).to receive(:deliver).with("todo_assign", todo.executor, todo)
      end

      it { expect(TodoMailer).not_to have_received(:todo_notification) }
      it { expect(PushNotification).to have_received(:deliver) }
    end
  end
end
