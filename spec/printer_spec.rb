require 'spec_helper'
require 'printer'

describe CommandLinePrinter do

  describe "public instance methods" do

    describe "#display" do
      it 'sends output to command line' do
        expect{ subject.display('sending to command line') }.to output("sending to command line\n").to_stdout
      end
    end
  end
end