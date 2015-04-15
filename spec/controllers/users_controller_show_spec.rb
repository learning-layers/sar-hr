RSpec.describe UsersController do
  subject { response }

  describe '#show' do
    before do
      get :show, :id => id
    end

    let(:user) {
      User.create(
        :email => 'asd@example.com',
        :password => 'foobarfoo',
        :first_name => 'foo',
        :last_name => 'bar'
      )
    }

    let(:id) { user.id }

    context 'with an authenticated user' do
      before do
        authenticate
      end

      context 'when a valid user is requested' do
        its(:status) { should eq 200 }
        its(:body)   { should match_json_schema 'user' }
      end

      context 'when an invalid user is requested' do
        let(:id) { 'invalid id' }

        its(:status) { should eq 404 }
        its(:body)   { should match_json_schema 'error' }
      end
    end

    context 'with an unauthenticated user' do
      its(:status) { should eq 401 }
      its(:body)   { should match_json_schema 'error' }
    end
  end
end
