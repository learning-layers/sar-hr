RSpec.describe 'GET /skills' do
  subject { response }

  let(:user) { create(:user) }

  before do
    get '/skills', as: user
  end

  context 'with a user' do
    its(:status) { should eq 200 }
    its(:body)   { should match_schema('skills/collection') }
  end

  context 'with a visitor' do
    let(:user) { nil }
    it_behaves_like 'unauthorized'
  end
end
