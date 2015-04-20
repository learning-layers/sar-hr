RSpec.describe 'DELETE /users/:id' do
  subject { response }

  let(:user) { create(:user) }
  let(:id)   { user.id }

  context 'with an authenticated user' do
    before do
      delete_with_auth "/users/#{id}"
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

  context 'with an unauthenticated user' do
    before do
      delete "/users/#{id}"
    end

    its(:status) { should eq 401 }
    its(:body)   { should match_schema('error') }
  end
end
