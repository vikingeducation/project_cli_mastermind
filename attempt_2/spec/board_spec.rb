require 'board'

describe Board do 

  let(:board) { Board.new }

  describe "#compare" do 

    it "returns 4 exact & 0 close matches for code \"royg\" and guess \"royg\"" do
      board.code = "royg"
      board.guess = "royg"
      expect(board.compare).to eq({ exact: 4, close: 0 })
    end

    it "returns 0 exact & 0 close matches for code \"royg\" and guess \"bpbp\"" do
      board.code = "royg"
      board.guess = "bpbp"
      expect(board.compare).to eq({ exact: 0, close: 0 })
    end

    it "returns 0 exact & 4 close matches for code \"royg\" and guess \"groy\"" do
      board.code = "royg"
      board.guess = "groy"
      expect(board.compare).to eq({ exact: 0, close: 4 })
    end

    it "returns 3 exact & 0 close matches for code \"bbbr\" and guess \"bbbb\"" do 
      board.code = "bbbr"
      board.guess = "bbbb"
      expect(board.compare).to eq({ exact: 3, close: 0 })
    end

    it "returns 1 exact & 0 close matches for code \"bbbr\" and guess \"booo\"" do 
      board.code = "bbbr"
      board.guess = "booo"
      expect(board.compare).to eq({ exact: 1, close: 0 })
    end

    it "returns 0 exact & 2 close matches for code \"bbbr\" and guess \"rrrb\"" do 
      board.code = "bbbr"
      board.guess = "rrrb"
      expect(board.compare).to eq({ exact: 0, close: 2 })
    end

    it "returns 2 exact & 2 close matches for code \"bbbr\" and guess \"rbbb\"" do 
      board.code = "bbbr"
      board.guess = "rbbb"
      expect(board.compare).to eq({ exact: 2, close: 2 })
    end

    it "returns 1 exact & 2 close matches for code \"obbr\" and guess \"orrb\"" do 
      board.code = "obbr"
      board.guess = "orrb"
      expect(board.compare).to eq({ exact: 1, close: 2 })
    end

  end

end