class FindingAction
  belongs_to :creator
  
  def notify_creator(updater)
    FindingActionNotifier.send_creator_notification(self) if should_notify_creator?(updater)
  end
  
  private
  
  def should_notify_creator?(updater)
    updater != creator && NotificationsManager.allows_notifying?(updater)
  end
end

describe FindingAction do
	subject { described_class.new }

	describe "#notify_creator" do
		context "when updater and creater are same user" do
			it "returns nil" do
				expect(subject.notify_creator(subject.creater)).to be_false
			end
		end
	end
	context "when creater was delete" do
		it "deletes dependent records" do
			expect(FindingAction.find(subject.id)).not_to exist
		end
	end
end