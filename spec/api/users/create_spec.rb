RSpec.describe 'POST /users' do
  subject { response }

  let(:params) { { :user => attributes_for(:user) } }

  context 'with an admin' do
    before do
      post_with_auth '/users', params, nil, user: create(:admin)
    end

    context 'when valid data is submitted' do
      its(:status) { should eq 201 }
      its(:body)   { should match_schema('users/instance') }
    end

    context 'when invalid data is submitted' do
      let(:params) { {} }

      its(:status) { should eq 422 }
      its(:body)   { should match_schema('error') }
    end
  end

  context 'with a user' do
    before do
      post_with_auth '/users', params
    end

    its(:status) { should eq 403 }
    its(:body)   { should match_schema('error') }
  end

  context 'with a visitor' do
    before do
      post '/users', params
    end

    its(:status) { should eq 401 }
    its(:body)   { should match_schema('error') }
  end
end
