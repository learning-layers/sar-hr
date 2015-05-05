RSpec.describe 'GET /users' do
  subject { response }

  context 'with a user' do
    before do
      get '/users', as: create(:user)
    end

    its(:status) { should eq 200 }
    its(:body)   { should match_schema('users/collection') }
  end

  context 'with a visitor' do
    before do
      get '/users'
    end

    its(:status) { should eq 401 }
    its(:body)   { should match_schema('error') }
  end
end
