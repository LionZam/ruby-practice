class ReviewerMailer < ApplicationMailer
  def narrative_reviewer_notification(reviewer, narrative)
    I18n.with_locale(reviewer.locale) do
      @narrative = narrative

      mail to: reviewer.email,
      subject: "Narrative is assigned to you for review"
    end
  end

  def control_reviewer_notification(reviewer, control)
    I18n.with_locale(reviewer.locale) do
      @control = control

      mail to: reviewer.email,
      subject: "Control is assigned to you for review"
    end
  end


  def walkthrough_reviewer_notification(reviewer, walkthrough)
    I18n.with_locale(reviewer.locale) do
      @walkthrough = walkthrough

      mail to: reviewer.email,
      subject: "Walkthrough is assigned to you for review"
    end
  end
end

describe ReviewerMailer do
  let(:review_mailer) { described_class.new }
  let(:reviewer) { build :reviewer, locale: :es }

  shared_examples "an email which honors user's user locale" do
    it "sends to reviewer email" do
      expect(mail.to).to eq(reviewer_email)
    end

    context "when locale is present" do
      it "sends subject with translation" do
        expect(mail.subject).to eq(translated_subject)
      end
    end

    context "when locale isn't present" do
      before do
        #mock
      end

      it "sends subject on english" do
        expect(mail.subject).to eq(en_subject)
      end
    end
  end

  describe "#narrative_reviewer_notification" do
    context "when user locale is Spanish" do
      include_examples "an email which honors user's user locale" do
        let(:translated_subject) { "Se le asigna una narrativa para su revisión" }
        let(:reviewer_email) { [reviewer.email] }
        let(:en_subject) { "Narrative is assigned to you for review" }
      end
    end
  end

  describe "#control_reviewer_notification" do
    context "when user locale is Spanish" do
      include_examples "an email which honors user's user locale" do
        let(:translated_subject) { "Se le asigna una controlla para su revisión" }
        let(:reviewer_email) { [reviewer.email] }
        let(:en_subject) { "Control is assigned to you for review" }
      end
    end
  end

  describe "#walkthrough_reviewer_notification" do
    context "when user locale is Spanish" do
      include_examples "an email which honors user's user locale" do
        let(:translated_subject) { "Se le asigna una walkthrough para su revisión" }
        let(:reviewer_email) { [reviewer.email] }
        let(:en_subject) { "Walkthrough is assigned to you for review" }
      end
    end
  end
end
