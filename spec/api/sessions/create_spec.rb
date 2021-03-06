RSpec.describe 'POST /sessions' do
  subject { response }

  let(:password) { 'foobarbaz' }
  let(:user)     { create(:user, password: password) }
  let(:params)   { { user: { email: user.email, password: password } } }

  before do
    post '/sessions', params: params
  end

  context 'using correct credentials' do
    its(:status) { should eq 201 }
    its(:body)   { should match_schema('sessions/instance') }
  end

  context 'using the wrong password' do
    let(:params) { { user: { email: user.email, password: 'nope' } } }
    it_behaves_like 'unauthorized'
  end

  context 'using the wrong email' do
    let(:params) { { user: { email: 'nope', password: password } } }
    it_behaves_like 'unauthorized'
  end

  context 'using an invalid body' do
    let(:params) { {} }
    it_behaves_like 'unprocessable entity'
  end
end
