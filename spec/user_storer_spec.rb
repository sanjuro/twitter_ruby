require 'spec_helper'
require 'storer'

describe UserStorer do
  subject { UserStorer.new(StringIO.new(user_lines)) }

  it 'uses a Hash for storage' do
    expect(subject.storage).to be_a(Hash)
  end

  # it 'stores all data alphabetically' do
  #   hash = HashReader.new(StringIO.new("mustang\nthunderbird\ncougar"))
  #   expect(hash.storage).to eq({'cougar' => 'cougar', 'mustang' => 'mustang', 'thunderbird' => 'thunderbird'})
  # end

  context "public instance methods" do

    describe '#read' do
      it 'adds correctly formed lines to the store' do
        expect(subject.storage).to have_key('Alan')
        expect(subject.storage['Alan']).to eq(['Martin'])
        expect(subject.storage).to have_key('Ward')
        expect(subject.storage['Ward']).to eq(['Alan', 'Martin'])
      end

      it 'adds all users into storage' do
        expect(subject.storage.count).to eq(3)
        expect(subject.storage).to have_key('Martin')
        expect(subject.storage['Martin']).to eq([])
      end

      it 'does not include any bad input lines' do
        expect(subject.storage.count).to eq(3)
        expect(subject.storage).to_not have_key('Donkey')
      end

      it 'adds the main followee only once' do
        expect(subject.storage['Ward']).to eq(['Alan', 'Martin'])
      end

      it 'correctly allows spaces in usernames' do
        list = UserStorer.new(StringIO.new('Roger Wilco follows Alan'))
        expect(list.storage.count).to eq(2)
        expect(list.storage).to have_key('Roger Wilco')
        expect(list.storage).to have_key('Alan')
      end

    end
  end
end