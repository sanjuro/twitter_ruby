require 'spec_helper'
require 'runner'

describe Runner do

  describe "public instance methods" do

    describe "#initialize" do
      it 'defaults to Printer if no interace is given' do
        expect(subject.printer).to be_a(Printer)
      end
    end

    describe "#run" do
      it 'checks the User file is not to be empty' do
        users  = StringIO.new(empty_file)
        tweets = StringIO.new(tweet_lines)
        expect {subject.run(users, tweets)}.to raise_error(TypeError)
      end

      it 'checks the Tweet file is not to be empty' do
        users  = StringIO.new(user_lines)
        tweets = StringIO.new(empty_file)
        expect {subject.run(users, tweets)}.to raise_error(TypeError)
      end
    end
  end
end