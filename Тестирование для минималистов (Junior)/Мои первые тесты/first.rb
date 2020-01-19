class Objective
  LOCK_STATUSES = {
    :unlocked  => 0,
    :uploading => 1,
    :locked    => 2
  }
    
  def locked?
    locked_by.present? &&
    [LOCK_STATUSES[:uploading], LOCK_STATUSES[:locked]].include?(lock_status)
  end
  
  def release_lock
    assign_attributes(
      :locked_by => nil,
      :locked_on_name => nil,
      :locked_on_id => nil,
      :lock_status => LOCK_STATUSES[:unlocked]
    )
  end
end

describe Objective do
	subject { described_class.new }

	describe "#locked?" do
		context "when init" do
			before { subject.release_lock }

			it "returns false by default" do
				expect(subject.locked?).to be_false
			end
		end

		context "when not init" do
			it "returns false by default" do
				expect(subject.locked?).to raiseError(NoMethodError)
			end
		end
	end

	describe "LOCK_STATUSES" do
		context "frozen for changes" do
			expect(subject.LOCK_STATUSES[:locked] = 1).to raiseError(FrozenError)
		end
	end

	describe "#lock_status" do
		context "not aviable for changes" do
			expect(subject.lock_status = 4).to raiseError(NoMethodError)
		end
	end
end