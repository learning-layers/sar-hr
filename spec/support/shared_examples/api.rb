#
# Common API responses.
#
# Use them like this:
#
#   subject { response }
#
#   context 'whoops no authentication' do
#     it_behaves_like 'unauthorized'
#   end
#

RSpec.shared_examples 'no content' do
  its(:status) { should eq 204 }
  its(:body)   { should be_empty }
end

RSpec.shared_examples 'unauthorized' do
  its(:status) { should eq 401 }
  its(:body)   { should match_schema('error') }
end

RSpec.shared_examples 'forbidden' do
  its(:status) { should eq 403 }
  its(:body)   { should match_schema('error') }
end

RSpec.shared_examples 'not found' do
  its(:status) { should eq 404 }
  its(:body)   { should match_schema('error') }
end

RSpec.shared_examples 'unprocessable entity' do
  its(:status) { should eq 422 }
  its(:body)   { should match_schema('error') }
end
