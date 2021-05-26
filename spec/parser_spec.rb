require './parser'

describe Parser do
  describe "#parse_a_instruction" do
    before do
      @parser = Parser.new('./test.asm')
    end

    context "when parsing a line without @ symbol" do
      it "returns nil" do
        expect(@parser.parse_a_instruction('abc')).to be_nil
      end
    end

    context "when parsing a line with @ symbol" do
      it "returns a separated array with symbol and number" do
        expect(@parser.parse_a_instruction('@abc')).to eq ['@', 'abc']
      end
    end
  end

  describe "#parse_c_instruction" do
    before do
      @parser = Parser.new('./test.asm')
    end

    context "when parsing a line without any instruction" do
      it "returns nil" do
        expect(@parser.parse_c_instruction('MD')).to eq nil
      end
    end

    context "when parsing a line without jump instruction" do
      it "returns a separated array with dest and comp" do
        expect(@parser.parse_c_instruction('MD=D+1')).to eq ['MD', 'D+1']
      end
    end

    context "when parsing a line with jump instruction" do
      it "returns a separated array with dest, comp and jump" do
        expect(@parser.parse_c_instruction('MD=D+1;JQE')).to eq ['MD', 'D+1', 'JQE']
      end
    end
  end

  describe "#parse_c_instruction" do
    before do
      @parser = Parser.new('./test.asm')
    end

    context "when parsing a test file" do
      it "returns each parsed content into an array" do
        expect(@parser.parse).to eq [
          ["@", "2"],
          ["D", "A"],
          ["@", "3"],
          ["D", "D+A"],
          ["@", "0"],
          ["D", "JQE"]
        ]
      end
    end
  end
end
