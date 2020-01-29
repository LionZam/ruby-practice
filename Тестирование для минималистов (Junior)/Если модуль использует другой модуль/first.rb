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
  subject(:finding_action) { build_stubbed :finding_action }

  describe "#notify_creator" do
    before { allow(FindingActionNotifier).to receive(:send_creator_notification) }

    context "when updater and creater are same users" do
      before { finding_action.notify_creator(finding_action.creator) }

      it "not sends comment notification" do
        expect(FindingActionNotifier).to have_not_received(:send_creator_notification).with(finding_action)
      end
    end

    context "when updater and creater are different users" do
      let(:another_user) { build_stubbed :user }

      before { finding_action.notify_creator(another_user) }

      it "sends comment notification" do
        expect(FindingActionNotifier).to have_received(:send_creator_notification).with(finding_action)
      end
    end
  end
end