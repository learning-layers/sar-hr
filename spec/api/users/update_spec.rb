RSpec.describe 'PATCH /users/:id' do
  subject { response }

  let(:user) { create(:user) }

  let(:params) {
    {
      :user => {
        :email => Faker::Internet.safe_email
      }
    }
  }

  context 'with an authenticated user' do
    before do
      patch_with_auth "/users/#{user.id}", params
    end

    context 'when valid data is submitted' do
      its(:status) { should eq 200 }
      its(:body)   { should match_schema :user_instance }

      it 'has updated attributes' do
        fetched_value = parse_json(body, 'user/email')
        changed_value = params[:user][:email]

        expect(fetched_value).to eq(changed_value)
      end
    end

    context 'when invalid data is submitted' do
      let(:params) {
        {
          :user => {
            :email => nil
          }
        }
      }

      its(:status) { should eq 422 }
      its(:body)   { should match_schema :error }
    end
  end

  context 'with an unauthenticated user' do
    before do
      patch "/users/#{user.id}", params
    end

    its(:status) { should eq 401 }
    its(:body)   { should match_schema :error }
  end
end
