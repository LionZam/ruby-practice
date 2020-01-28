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
  subject(:objective) { build_stubbed :objective }

  it "not locked by default" do
    is_expected.not_to be_locked
  end

  context "when locked by object" do
    before { objective.locked_by = "" }

    it { is_expected.to be_locked }
  end

  context "when lock status is uploading" do
    before { objective.lock_status = Objective::LOCK_STATUSES[:uploading] }

    it { is_expected.to be_locked }
  end

  context "when lock status is locked" do
    before { objective.lock_status = Objective::LOCK_STATUSES[:locked] }

    it { is_expected.to be_locked }
  end
  
  describe "#release_lock" do
    let(:objective) { build_stubbed: objective, :with_locked_values}

    it "will reset all values" do
      expect(objective.locked_by).to be_nil
      expect(objective.locked_on_name).to be_nil
      expect(objective.locked_on_id).to be_nil
      expect(objective.locked_status).to eq(Objective::LOCK_STATUSES[:unlocked])
    end
  end

  describe ".LOCK_STATUSES" do
    it "frozen for changes" do
      expect(subject.LOCK_STATUSES[:locked] = 1).to raiseError(FrozenError)
    end
  end

  describe "#lock_status" do
    it "not aviable for changes" do
      expect(subject.lock_status = 4).to raiseError(NoMethodError)
    end
  end
end

