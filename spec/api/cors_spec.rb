RSpec.describe 'cross-origin resource sharing' do
  subject { response }

  describe 'OPTIONS / (with preflight headers)' do
    before do
      options '/', headers: {
        # Note that the origin needs to match one of the space-delimited
        # origins set by the CLIENT_ORIGINS environment variable. This variable
        # is set in rails_helper.rb for tests.
        'Origin' => origin,
        'Access-Control-Request-Method' => 'GET',
        'Access-Control-Request-Headers' => 'X-FOO-BAR'
      }
    end

    shared_examples 'successful request' do
      it 'should have CORS headers' do
        expect(response.headers.keys).to include(
          'Access-Control-Allow-Credentials',
          'Access-Control-Allow-Headers',
          'Access-Control-Allow-Methods',
          'Access-Control-Allow-Origin',
          'Access-Control-Expose-Headers',
          'Access-Control-Max-Age'
        )
      end

      its(:status) { should eq 200 }
      its(:body)   { should be_empty }
    end

    context 'with the first allowed origin' do
      let(:origin) { 'http://example.com' }
      include_examples 'successful request'
    end

    context 'with the second allowed origin' do
      let(:origin) { 'https://example.com' }
      include_examples 'successful request'
    end
  end
end
