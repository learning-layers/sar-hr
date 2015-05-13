RSpec.describe 'POST /skills' do
  subject { response }

  let(:user)   { create(:user) }
  let(:params) { { skill: attributes_for(:skill) } }

  before do
    post '/skills', params: params, as: user
  end

  context 'with an admin' do
    let(:user) { create(:user, :as_admin) }

    context 'when valid data is submitted' do
      its(:status) { should eq 201 }
      its(:body)   { should match_schema('skills/instance') }
    end

    context 'when invalid data is submitted' do
      let(:params) { {} }
      it_behaves_like 'unprocessable entity'
    end
  end

  context 'with a user' do
    it_behaves_like 'forbidden'
  end

  context 'with a visitor' do
    let(:user) { nil }
    it_behaves_like 'unauthorized'
  end
end
