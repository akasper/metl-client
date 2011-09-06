require 'spec_helper'

describe Metl::GoldenMaster do

  before(:all) do
    class GoldenMasterSpec
      include Metl::GoldenMaster
    end
  end

  subject {GoldenMasterSpec.new}

  CLASS_METHODS = [
    :exposes, :persists, :groups, :has
  ] unless defined? CLASS_METHODS

  describe '.exposes' do
    context 'given params' do
      it 'is a collection' do
      end

      context 'one time' do
        it 'has a single element' do
          subject.class.exposes(:param).size.should == 1
        end
      end
    end

    context 'given no params' do
      it 'is a collection' do
        subject.class.exposes.should respond_to :each
      end
    end
  end

end