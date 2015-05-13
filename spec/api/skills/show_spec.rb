RSpec.describe 'GET /skills/:id' do
  subject { response }

  let(:user)  { create(:user) }
  let(:skill) { create(:skill) }
  let(:id)    { skill.id }

  before do
    get "/skills/#{id}", as: user
  end

  context 'with a user' do
    context 'when a valid skill is requested' do
      its(:status) { should eq 200 }
      its(:body)   { should match_schema('skills/instance') }
    end

    context 'when an invalid skill is requested' do
      let(:id) { '123123' }
      it_behaves_like 'not found'
    end
  end

  context 'with a visitor' do
    let(:user) { nil }
    it_behaves_like 'unauthorized'
  end
end
