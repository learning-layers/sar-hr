RSpec.describe 'DELETE /skills/:id' do
  subject { response }

  let(:skill) { create(:skill) }
  let(:id)    { skill.id }

  context 'with an admin' do
    before do
      delete "/skills/#{id}", as: create(:user, :as_admin)
    end

    context 'when a valid skill is requested' do
      its(:status) { should eq 204 }
      its(:body)   { should be_empty }
    end

    context 'when an invalid skill is requested' do
      let(:id) { '123123' }

      its(:status) { should eq 404 }
      its(:body)   { should match_schema('error') }
    end
  end

  context 'with a user' do
    before do
      delete "/skills/#{id}", as: create(:user)
    end

    its(:status) { should eq 403 }
    its(:body)   { should match_schema('error') }
  end

  context 'with a visitor' do
    before do
      delete "/skills/#{id}"
    end

    its(:status) { should eq 401 }
    its(:body)   { should match_schema('error') }
  end
end
