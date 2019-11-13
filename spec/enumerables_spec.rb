require_relative '../enumerables.rb'
RSpec.describe Enumerable do
array = [1,2,3,4,5]
falsy_array = [1,22, false,0,'oop']


  describe '#my_each' do

    it "return Enumerator if no block is given" do
    expect(array.my_each).to be_a(Enumerator)
    end
    it "return object without modifying original array" do
    expect(array.my_each {|x| x * 2} ).to eql(array)
    end
    it "when block is provided, its is applied to every item of array" do
    result = []
    array.my_each {|x| result << x * 2}
    expect(result).to eq([2,4,6,8,10])
    end
  end
describe 'my_all?' do
 
  it "should return false when no block is given and when object contains false or nil values" do
  expect(falsy_array.my_all?).to equal(false)
  end
  it "return false if one item of object collection doesnt pass block condition" do
  expect([3,4,2,10,9].my_all?{|x| x % 2 == 0 }).to be false
  end
  it "return true if all items met true condition" do
    expect([3,6,9,12].my_all?{|x| x % 3 == 0 }).to be true
    end
end

describe 'my_count' do
  it "returned class should be Integer" do
    expect(array.my_count).to be_a(Integer)
  end

  it "should return size of object when no parameter or block is given" do
  expect([1,1,1].my_count).to eql(3)
  end

  it "should return count of items thad pass condition in block" do
    expect([1,1,1,2].my_count {|x| x != 2}).to eql(3)
    end

end
end
