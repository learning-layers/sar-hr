RSpec.describe 'PATCH /skills/:id' do
  subject { response }

  let(:skill) { create(:skill) }

  let(:params) {
    {
      skill: {
        name: Faker::Hacker.ingverb
      }
    }
  }

  context 'with an admin' do
    before do
      patch "/skills/#{skill.id}", params: params, as: create(:user, :as_admin)
    end

    context 'when valid data is submitted' do
      its(:status) { should eq 200 }
      its(:body)   { should match_schema('skills/instance') }

      it 'has updated attributes' do
        fetched_value = parse_json(body, 'skill/name')
        changed_value = params[:skill][:name]

        expect(fetched_value).to eq(changed_value)
      end
    end

    context 'when invalid data is submitted' do
      let(:params) {
        {
          skill: {
            name: nil
          }
        }
      }

      its(:status) { should eq 422 }
      its(:body)   { should match_schema('error') }
    end
  end

  context 'with a user' do
    before do
      patch "/skills/#{skill.id}", params: params, as: create(:user)
    end

    its(:status) { should eq 403 }
    its(:body)   { should match_schema('error') }
  end

  context 'with a visitor' do
    before do
      patch "/skills/#{skill.id}", params
    end

    its(:status) { should eq 401 }
    its(:body)   { should match_schema('error') }
  end
end
