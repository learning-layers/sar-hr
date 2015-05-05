RSpec.describe Skill do
  subject(:skill) { build(:skill) }

  describe 'factory' do
    it { should be_valid }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'associations' do
    it { should have_and_belong_to_many(:users) }
  end
end
