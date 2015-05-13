RSpec.describe 'DELETE /users/:id' do
  subject { response }

  let(:user) { create(:user) }
  let(:id)   { create(:user).id }

  before do
    delete "/users/#{id}", as: user
  end

  context 'with an admin' do
    let(:user) { create(:user, :as_admin) }

    context 'when a valid user is requested' do
      it_behaves_like 'no content'
    end

    context 'when an invalid user is requested' do
      let(:id) { '123123' }
      it_behaves_like 'not found'
    end
  end

  context 'with a user' do
    context 'when target is not self' do
      it_behaves_like 'forbidden'
    end

    context 'when target is self' do
      let(:id) { user.id }
      it_behaves_like 'no content'
    end
  end

  context 'with a visitor' do
    let(:user) { nil }
    it_behaves_like 'unauthorized'
  end
end
