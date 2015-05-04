RSpec.describe 'DELETE /users/:id' do
  subject { response }

  let(:user) { create(:user) }
  let(:id)   { user.id }

  context 'with an admin' do
    before do
      delete_with_auth "/users/#{id}", nil, nil, user: create(:user, :as_admin)
    end

    context 'when a valid user is requested' do
      its(:status) { should eq 204 }
      its(:body)   { should be_empty }
    end

    context 'when an invalid user is requested' do
      let(:id) { '123123' }

      its(:status) { should eq 404 }
      its(:body)   { should match_schema('error') }
    end
  end

  context 'with a user' do
    context 'when target is not self' do
      before do
        delete_with_auth "/users/#{id}"
      end

      its(:status) { should eq 403 }
      its(:body)   { should match_schema('error') }
    end

    context 'when target is self' do
      before do
        delete_with_auth "/users/#{id}", nil, nil, user: user
      end

      its(:status) { should eq 204 }
      its(:body)   { should be_empty }
    end
  end

  context 'with a visitor' do
    before do
      delete "/users/#{id}"
    end

    its(:status) { should eq 401 }
    its(:body)   { should match_schema('error') }
  end
end
