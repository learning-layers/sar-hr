RSpec.describe 'DELETE /sessions' do
  subject { response }

  before do
    delete_with_auth '/sessions'
  end

  its(:status) { should eq 204 }
  its(:body)   { should be_empty }
end
