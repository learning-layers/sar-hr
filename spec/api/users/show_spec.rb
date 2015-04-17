RSpec.describe 'GET /users/:id' do
  subject { response }

  let(:user) { create(:user) }
  let(:id)   { user.id }

  context 'with an authenticated user' do
    before do
      get_with_auth "/users/#{id}"
    end

    context 'when a valid user is requested' do
      its(:status) { should eq 200 }
      its(:body)   { should match_schema :user_instance }
    end

    context 'when an invalid user is requested' do
      let(:id) { '123123' }

      its(:status) { should eq 404 }
      its(:body)   { should match_schema :error }
    end
  end

  context 'with an unauthenticated user' do
    before do
      get "/users/#{id}"
    end

    its(:status) { should eq 401 }
    its(:body)   { should match_schema :error }
  end
end
