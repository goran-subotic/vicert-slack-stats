require 'rails_helper'

describe Stat, :type => :model do

    it 'persists a stat object' do
      stat = Stat.create(:name => 'rspec.test.user')
      expect(stat).to be_persisted
    end

    it 'is not equal to another object with same name' do
      stat1 = Stat.create(:name => 'rspec.test.user')
      stat2 = Stat.create(:name => 'rspec.test.user')

      expect(stat1).to be_persisted
      expect(stat2).to be_persisted
      expect(stat1).to_not eq(stat2)
    end

    it 'is not persisted' do
      stat = Stat.new(:name => 'rspec.test.user')

      expect(stat).to_not be_persisted
    end

end