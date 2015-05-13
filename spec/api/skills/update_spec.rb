RSpec.describe 'PATCH /skills/:id' do
  subject { response }

  let(:user)  { create(:user) }
  let(:skill) { create(:skill) }

  let(:params) {
    {
      skill: {
        name: Faker::Hacker.ingverb
      }
    }
  }

  before do
    patch "/skills/#{skill.id}", params: params, as: user
  end

  context 'with an admin' do
    let(:user) { create(:user, :as_admin) }

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

      it_behaves_like 'unprocessable entity'
    end
  end

  context 'with a user' do
    it_behaves_like 'forbidden'
  end

  context 'with a visitor' do
    let(:user) { nil }
    it_behaves_like 'unauthorized'
  end
end
