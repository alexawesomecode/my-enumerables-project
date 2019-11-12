require_relative '../enumerables.rb'
describe Enumerable do
  describe "#my_each" do

    array = [1,2,3]
    let(:bloque) {|x| x*2}
    it "return Enumerator if no block is given" 
    
    it "return every item of array without modifying array" do
    expect(array.my_each.send(:bloque)).to eq([2,4,6])
    end
    it "when block is provided, its is applied to every item of array"

  end
end
