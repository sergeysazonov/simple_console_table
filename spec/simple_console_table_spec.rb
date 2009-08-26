require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

describe SimpleConsoleTable do

  before(:each) do
    @table = SimpleConsoleTable.new
  end

  it 'should return an empty string if the table is empty' do
    @table.as_string.should be_empty
  end

  it 'should output a nicely formatted table' do
    @table << ['one', 'two', 'three']
    @table << ['four', 'five', 'six']

    @table.as_string.should == <<-EOF
+--------+--------+---------+
|   one  |   two  |  three  |
+--------+--------+---------+
|  four  |  five  |    six  |
+--------+--------+---------+
EOF
  end

  it 'should allow adding rows of different lengths' do
    @table << ['one', 'two', 'three']
    @table << ['four', 'five', 'six', 'seven']

    @table.as_string.should == <<-EOF
+--------+--------+---------+---------+
|   one  |   two  |  three  |         |
+--------+--------+---------+---------+
|  four  |  five  |    six  |  seven  |
+--------+--------+---------+---------+
EOF
  end

  it 'should use to_s method for values other than strings' do
    class Dummy
      def initialize(dummy_id); @dummy_id = dummy_id; end
      def to_s; "Dummy #{@dummy_id}"; end
    end
    
    @table << ['one', 2, 'three']
    @table << [true, 'five', -6.89, Dummy.new(345)]

    @table.as_string.should == <<-EOF
+--------+--------+---------+-------------+
|   one  |     2  |  three  |             |
+--------+--------+---------+-------------+
|  true  |  five  |  -6.89  |  Dummy 345  |
+--------+--------+---------+-------------+
EOF
  end

  it 'should flatten nested arrays' do
    @table << [1, 2, [3, 4], [5]]
    @table << [[[[[[6, 7, 8]]], [[[[9, 10]]]]]]]

    @table.as_string.should == <<-EOF
+-----+-----+-----+-----+------+
|  1  |  2  |  3  |  4  |   5  |
+-----+-----+-----+-----+------+
|  6  |  7  |  8  |  9  |  10  |
+-----+-----+-----+-----+------+
EOF
  end
  
  it 'should have print method for printing the table directly to the standard output' do
    @table.should respond_to(:print)
  end
end
