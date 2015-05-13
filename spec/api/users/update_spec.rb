RSpec.describe 'PATCH /users/:id' do
  subject { response }

  let(:user) { create(:user) }
  let(:id)   { create(:user).id }

  let(:params) {
    {
      :user => {
        :email => Faker::Internet.safe_email
      }
    }
  }

  before do
    patch "/users/#{id}", params: params, as: user
  end

  shared_examples 'successful request' do
    its(:status) { should eq 200 }
    its(:body)   { should match_schema('users/instance') }

    it 'has updated attributes' do
      fetched_value = parse_json(body, 'user/email')
      changed_value = params[:user][:email]

      expect(fetched_value).to eq(changed_value)
    end

    context 'when changing skills' do
      let(:skill) { create(:skill) }

      let(:params) {
        {
          :user => {
            :skill_ids => [ skill.id ]
          }
        }
      }

      it 'updates skills' do
        fetched_value = parse_json(body, 'user/skill_ids')
        changed_value = params[:user][:skill_ids]

        expect(fetched_value).to eq(changed_value)
      end
    end
  end

  context 'with an admin' do
    let(:user) { create(:user, :as_admin) }

    context 'when valid data is submitted' do
      it_behaves_like 'successful request'
    end

    context 'when invalid data is submitted' do
      let(:params) {
        {
          :user => {
            :email => nil
          }
        }
      }

      it_behaves_like 'unprocessable entity'
    end
  end

  context 'with a user' do
    context 'when target is not self' do
      it_behaves_like 'forbidden'
    end

    context 'when target is self' do
      let(:id) { user.id }
      it_behaves_like 'successful request'
    end
  end

  context 'with a visitor' do
    let(:user) { nil }
    it_behaves_like 'unauthorized'
  end
end
