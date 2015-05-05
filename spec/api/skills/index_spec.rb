RSpec.describe 'GET /skills' do
  subject { response }

  context 'with a user' do
    before do
      get '/skills', as: create(:user)
    end

    its(:status) { should eq 200 }
    its(:body)   { should match_schema('skills/collection') }
  end

  context 'with a visitor' do
    before do
      get '/skills'
    end

    its(:status) { should eq 401 }
    its(:body)   { should match_schema('error') }
  end
end
