RSpec.describe 'GET /users/:id' do
  subject { response }

  let(:user) { create(:user) }
  let(:id)   { create(:user).id }

  before do
    get "/users/#{id}", as: user
  end

  context 'with a user' do
    context 'when a valid user is requested' do
      its(:status) { should eq 200 }
      its(:body)   { should match_schema('users/instance') }
    end

    context 'when an invalid user is requested' do
      let(:id) { '123123' }
      it_behaves_like 'not found'
    end
  end

  context 'with a visitor' do
    let(:user) { nil }
    it_behaves_like 'unauthorized'
  end
end
