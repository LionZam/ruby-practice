describe AccountActivityMailer do
  subject(:account_activity_mailer) { AccountActivityMailer.report }

  context ".report" do
    it "delivers report in attachment" do
      expect(account_activity_mailer.attachments).to have(1).item
      expect(account_activity_mailer.attachments.first.filename).to eq("filename.xls")
    end
  end
end
