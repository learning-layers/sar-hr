RSpec.describe 'DELETE /sessions' do
  subject { response }

  before do
    delete '/sessions', as: create(:user)
  end

  its(:status) { should eq 204 }
  its(:body)   { should be_empty }
end
