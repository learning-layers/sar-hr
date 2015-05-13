RSpec.describe 'DELETE /skills/:id' do
  subject { response }

  let(:user)  { create(:user) }
  let(:skill) { create(:skill) }
  let(:id)    { skill.id }

  before do
    delete "/skills/#{id}", as: user
  end

  context 'with an admin' do
    let(:user) { create(:user, :as_admin) }

    context 'when a valid skill is requested' do
      it_behaves_like 'no content'
    end

    context 'when an invalid skill is requested' do
      let(:id) { '123123' }
      it_behaves_like 'not found'
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
