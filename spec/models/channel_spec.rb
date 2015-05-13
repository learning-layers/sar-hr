RSpec.describe Channel do
  subject(:channel) { Channel.new(name) }

  shared_examples 'coercion' do
    it 'should be coercible into a String' do
      expect(channel.to_s).to eq(name.to_s)
      expect(channel.to_str).to eq(name.to_s)
    end

    it 'should be coercible into a Symbol' do
      expect(channel.to_sym).to eq(name.to_sym)
    end
  end

  context 'when given a String' do
    let(:name) { 'global' }
    include_examples 'coercion'
  end

  context 'when given a Symbol' do
    let(:name) { :global }
    include_examples 'coercion'
  end
end
