describe AccountActivityMailer do
  context ".report" do
    let(:account_activity_mailer) { AccountActivityMailer.report }

    it "delivers report in attachment" do
      account_activity_mailer.attachments.should have(1).item
      account_activity_mailer.attachments.first.filename.should eq "filename.xls"
    end
  end
end