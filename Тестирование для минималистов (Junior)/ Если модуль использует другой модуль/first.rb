class FindingAction
  belongs_to :creator
 
  def notify_creator(updater)
    FindingActionNotifier.send_creator_notification(self) if should_notify_creator?(updater)
  end
 
  private
 
  def should_notify_creator?(updater)
    updater != creator
  end
end

describe FindingAction do
  describe "#notify_creator" do
    subject { described_class.new(creator: user) }
    before { allow(FindingActionNotifier).to receive(:send_creator_notification?).and_return(notification) }

    context "when updater and creater are same users" do
      it "not sends comment notification" do
        subject.notify_creator(user).to be_nil

        expect(FindingActionNotifier).to have_not_received(:send_creator_notification).with(subject)
      end
    end

    context "when updater and creater are different users" do
      it "sends comment notification" do
        subject.notify_creator(user).to be_notification_representaion(notification)

        expect(FindingActionNotifier).to have_received(:send_creator_notification).with(subject)
      end
    end
  end
end