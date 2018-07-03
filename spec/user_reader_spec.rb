require 'spec_helper'
require 'reader'

describe UserReader do
  subject { UserReader.new() }

  it 'blocks greater than signs in username' do
    reader = UserReader.new
    line = reader.read "Roger>Steve follows You\nYou follows Roger>Steve"
    expect(line.count).to eq(2)
  end

  it 'stops commas in usernames' do
  	reader = UserReader.new
    line = reader.read "Roger,Steve follows Larry"
    expect(line).to be_nil
  end

end