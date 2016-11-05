require 'board'

describe Board do 

  let(:board) { Board.new }

  describe "#check_guess" do 

    it "returns 4 exact & 0 close matches for code \"royg\" and guess \"royg\"" do
      board.maker_sequence = ['r','o','y','g']
      expect(board.check_guess(['r','o','y','g'])).to eq({ exact: 4, near: 0 })
    end

    it "returns 0 exact & 0 close matches for code \"royg\" and guess \"bpbp\"" do
      board.maker_sequence = ['r','o','y','g']
      expect(board.check_guess(['b','p','b','p'])).to eq({ exact: 0, near: 0 })
    end

    it "returns 0 exact & 4 close matches for code \"royg\" and guess \"groy\"" do
      board.maker_sequence = ['r','o','y','g']
      expect(board.check_guess(['g','r','o','y'])).to eq({ exact: 0, near: 4 })
    end

    it "returns 3 exact & 0 close matches for code \"bbbr\" and guess \"bbbb\"" do 
      board.maker_sequence = ['b','b','b','r']
      expect(board.check_guess(['b','b','b','b'])).to eq({ exact: 3, near: 0 })
    end

    it "returns 1 exact & 0 close matches for code \"bbbr\" and guess \"booo\"" do 
      board.maker_sequence = ['b','b','b','r']
      expect(board.check_guess(['b','o','o','o'])).to eq({ exact: 1, near: 0 })
    end

    it "returns 0 exact & 2 close matches for code \"bbbr\" and guess \"rrrb\"" do 
      board.maker_sequence = ['b','b','b','r']
      expect(board.check_guess(['r','r','r','b'])).to eq({ exact: 0, near: 2 })
    end

    it "returns 2 exact & 2 close matches for code \"bbbr\" and guess \"rbbb\"" do 
      board.maker_sequence = ['b','b','b','r']
      expect(board.check_guess(['r','b','b','b'])).to eq({ exact: 2, near: 2 })
    end

    it "returns 1 exact & 2 close matches for code \"obbr\" and guess \"orrb\"" do 
      board.maker_sequence = ['o','b','b','r']
      expect(board.check_guess(['o','r','r','b'])).to eq({ exact: 1, near: 2 })
    end

  end

end