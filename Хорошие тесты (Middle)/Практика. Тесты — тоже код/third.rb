class Project
  def completion_percentage=(percentage)
    percentage = percentage.to_i

    @completion_percentage = case
    when percentage > 100
      100
    when percentage < 0
      0
    else
      percentage
    end
  end
end

describe Project do
  subject(:project) { build_stubbed :project }

  describe "#completion_percentage=" do
    def percentage_for(percentage)
      project.completion_percentage = percentage
    end

    it "return value between 0 and 100" do
      expect(percentage_for(101)).to eq(100)
      expect(percentage_for(99)).to eq(99)
      expect(percentage_for(-1)).to eq(0)
      expect(percentage_for(0)).to eq(0)
      expect(percentage_for(100)).to eq(100)
    end
  end
end
