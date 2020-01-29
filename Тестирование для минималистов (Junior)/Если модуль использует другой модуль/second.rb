class RisksController
  def update_from_origin
    SourceTrackableUpdater.new(trackable_resource).update_from_origin
 
    redirect_to trackable_resource
  end
end

resource "Risks" do
  patch "risks/:id" do
    parameter :id, "Risk id", required: true

    let(:risk) { create :risk }
    let(:id) { risk.id }

    before do
      source_trackable_updater_double = double(SourceTrackableUpdater, update_from_origin: true)
      allow(SourceTrackableUpdater).to receive(:new).with(risk).and_return(source_trackable_updater_double)
    end

    example_request "update from origin" do
      expect(SourceTrackableUpdater).to have_received(:new).with(risk)
      expect(source_trackable_updater_double).to have_received(:update_from_origin)

      expect(response).to_be redirect_to(:action => :show, :id => risk.id)
    end
  end
end