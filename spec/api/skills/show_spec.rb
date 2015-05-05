RSpec.describe 'GET /skills/:id' do
  subject { response }

  let(:skill) { create(:skill) }
  let(:id)    { skill.id }

  context 'with a user' do
    before do
      get "/skills/#{id}", as: create(:user)
    end

    context 'when a valid skill is requested' do
      its(:status) { should eq 200 }
      its(:body)   { should match_schema('skills/instance') }
    end

    context 'when an invalid skill is requested' do
      let(:id) { '123123' }

      its(:status) { should eq 404 }
      its(:body)   { should match_schema('error') }
    end
  end

  context 'with a visitor' do
    before do
      get "/skills/#{id}"
    end

    its(:status) { should eq 401 }
    its(:body)   { should match_schema('error') }
  end
end
