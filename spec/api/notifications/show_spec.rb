RSpec.describe 'GET /notifications/:channel' do
  subject { response }

  let(:user)    { create(:user) }
  let(:channel) { 'global' }

  before do
    # Response isn't available until a notification occurs: it will wait until
    # there is one. Let's speed things up and provide one from the get-go.
    allow(Notifications::Queue).to receive(:subscribe).and_yield('ping')

    get "/notifications/#{channel}", as: user
  end

  context 'when requesting a public channel' do
    context 'with a user' do
      its(:status)       { should eq 200 }
      its(:content_type) { should eq 'text/event-stream' }
    end

    context 'with a visitor' do
      let(:user) { nil }
      it_behaves_like 'unauthorized'
    end
  end

  context 'when requesting a private or unknown channel' do
    let(:channel) { 'mikearuba' }
    it_behaves_like 'forbidden'
  end
end
