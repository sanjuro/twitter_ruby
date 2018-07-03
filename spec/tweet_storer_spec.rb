require 'spec_helper'
require 'storer'

describe TweetStorer do
  subject { TweetStorer.new(StringIO.new(tweet_lines)) }

  it 'use an Array for storage' do
    expect(subject.storage).to be_an(Array)
  end

  context "public instance methods" do

    describe '#read' do
      it 'gets tweets and stores them in order' do
        expect(subject.storage.count).to eq(3)
        expect(subject.storage[0]).to eq({user: 'Alan', tweet: 'If you have a procedure with 10 parameters, you probably missed some.'})
        expect(subject.storage[1]).to eq({user: 'Ward', tweet: 'There are only two hard things in Computer Science: cache invalidation, naming things and off-by-1 errors.'})
        expect(subject.storage[2]).to eq({user: 'Alan', tweet: 'Random numbers should not be generated with a method chosen at random.'})
      end

      it 'tweets must not be longer than 140 characters' do
        tweet = Array.new(4, 'This line is longer than 140 characters.').join(' ')
        line = 'Mr Wilco> ' + tweet
        list = TweetStorer.new(StringIO.new(line))
        expect(list.storage[0][:tweet].length).to be(139)
      end

      it 'allow spaces in usernames' do
        list = TweetStorer.new(StringIO.new('Roger Wilco> Testing   one '))
        expect(list.storage[0]). to eq({user: 'Roger Wilco', tweet: 'Testing   one'})
      end
    end
    
  end
end
