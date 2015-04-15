RSpec.describe UsersController do
  subject { response }

  describe '#create' do
    before do
      post :create, params
    end

    let(:params) {
      {
        :user => {
          :email => 'abc@example.com',
          :password => 'foobarfoo',
          :first_name => 'foo',
          :last_name => 'bar'
        }
      }
    }

    context 'with an authenticated user' do
      before do
        authenticate
      end

      context 'when valid data is submitted' do
        its(:status) { should eq 201 }
        its(:body)   { should match_json_schema 'user' }
      end

      context 'when invalid data is submitted' do
        let(:params) { {} }

        its(:status) { should eq 422 }
        its(:body)   { should match_json_schema 'error' }
      end
    end

    context 'with an unauthenticated user' do
      its(:status) { should eq 401 }
      its(:body)   { should match_json_schema 'error' }
    end
  end
end
