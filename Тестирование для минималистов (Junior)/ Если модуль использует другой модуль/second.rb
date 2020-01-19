class RisksController
  def update_from_origin
    SourceTrackableUpdater.new(trackable_resource).update_from_origin
 
    redirect_to trackable_resource
  end
end

describe RisksController do
  describe "#update_from_origin" do
      before { allow(SourceTrackableUpdater).to receive(:new) }
 
      it "redirect to trackable_resource" do
				expect(response).to redirect_to(assigns(:trackable_resource))
				expect(SourceTrackableUpdater).to have_received(:new)
      end
    end
  end
end