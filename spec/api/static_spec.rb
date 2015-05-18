RSpec.describe 'static resources' do
  subject { response }

  describe 'GET /' do
    before { get '/' }

    its(:status) { should eq 200 }
    its(:body)   { should be_empty }
  end

  describe 'GET /robots.txt' do
    before { get '/robots.txt' }

    its(:status) { should eq 200 }
    its(:body)   { should match /\s*User-agent:\s*\*\s*\n\s*Disallow:\s*\//i }
  end
end
