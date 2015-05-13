RSpec.describe 'DELETE /sessions' do
  subject { response }

  before do
    delete '/sessions', as: create(:user)
  end

  it_behaves_like 'no content'
end
