RSpec.describe 'GET /' do
  subject { response }

  before do
    get '/'
  end

  its(:status) { should eq 200 }
  its(:body)   { should be_empty }
end
