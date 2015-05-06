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

  context 'with an admin' do
    before do
      patch "/users/#{user.id}", params: params, as: create(:user, :as_admin)
    end

    context 'when valid data is submitted' do
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

    context 'when invalid data is submitted' do
      let(:params) {
        {
          :user => {
            :email => nil
          }
        }
      }

      its(:status) { should eq 422 }
      its(:body)   { should match_schema('error') }
    end
  end

  context 'with a user' do
    context 'when target is not self' do
      before do
        patch "/users/#{user.id}", params: params, as: create(:user)
      end

      its(:status) { should eq 403 }
      its(:body)   { should match_schema('error') }
    end

    context 'when target is self' do
      before do
        patch "/users/#{user.id}", params: params, as: user
      end

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
  end

  context 'with a visitor' do
    before do
      patch "/users/#{user.id}", params
    end

    its(:status) { should eq 401 }
    its(:body)   { should match_schema('error') }
  end
end
