require 'spec_helper.rb'

describe Pawn do
  let(:pawn) { Pawn.new }

  context 'before place command' do
    it 'should return the pawn not placed message' do
      expect(pawn.execute("REPORT")).to eq("Pawn is not placed yet, try running place command first")
      expect(pawn.execute("MOVE")).to eq("Pawn is not placed yet, try running place command first")
      expect(pawn.execute("LEFT")).to eq("Pawn is not placed yet, try running place command first")
      expect(pawn.execute("RIGHT")).to eq("Pawn is not placed yet, try running place command first")
    end
  end

  context 'during place command' do
    it 'should place the pawn properly' do
      expect(pawn.execute('PLACE 1,2,NORTH,WHITE')).to eq(true)
      expect(pawn.position).to eq({:x=>1, :y=>2})
      expect(pawn.direction).to eq(:north)
      expect(pawn.color).to eq(:white)
    end

    it 'should change the color when a single move happens' do
      expect(pawn.execute('PLACE 6,4,SOUTH,WHITE')).to eq(true)
      expect(pawn.execute('MOVE')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 6,3,SOUTH,BLACK")
    end

    it 'should not change the color when a double move happens' do
      expect(pawn.execute('PLACE 5,5,EAST,WHITE')).to eq(true)
      expect(pawn.execute('MOVE(2)')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 7,5,EAST,WHITE")
    end
  end

  context 'after place command' do
    before do
      expect(pawn.execute('PLACE 3,3,EAST,BLACK')).to eq(true)
    end

    it 'move the pawn correspondingly' do
      expect(pawn.execute('MOVE(2)')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 5,3,EAST,BLACK")
      expect(pawn.execute('MOVE(2)')).to eq("you should not move 2 squares here after")
      expect(pawn.execute('MOVE')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 6,3,EAST,WHITE")
    end

    it 'try moving left direction' do
      expect(pawn.execute('LEFT')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 3,3,NORTH,BLACK")
    end

    it 'try moving right direction' do
      expect(pawn.execute('RIGHT')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 3,3,SOUTH,BLACK")
    end

    it 'move 2 squares should not come after normal move command' do
      expect(pawn.execute('MOVE')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 4,3,EAST,WHITE")
      expect(pawn.execute('MOVE(2)')).to eq("you should not move 2 squares here after")
    end

    it 'should accept the place command again' do
      expect(pawn.execute('PLACE 7,7,WEST,WHITE')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 7,7,WEST,WHITE")
    end

    it 'pawn should not fell down' do
      expect(pawn.execute('PLACE 0,0,SOUTH,BLACK')).to eq(true)
      expect(pawn.execute('MOVE')).to eq("You should not move as Pawn will fell down")
      expect(pawn.execute('PLACE 7,7,NORTH,WHITE')).to eq(true)
      expect(pawn.execute('MOVE')).to eq("You should not move as Pawn will fell down")
    end

    it 'out of range co-ordinates' do
      expect(pawn.execute('PLACE 0,-2,EAST,BLACK')).to eq(false)
      expect(pawn.execute('PLACE 9,6,SOUTH,WHITE')).to eq(false)
    end

    it 'Invalid commands' do
      expect{pawn.execute('REPORTT')}.to raise_error(ArgumentError)
      expect{pawn.execute('LEEFFTT')}.to raise_error(ArgumentError)
    end
  end

  context 'Miscellaneous testing' do
    it 'play around with the pawn for some time' do
      expect(pawn.execute('PLACE 7,4,WEST,WHITE')).to eq(true)
      expect(pawn.execute('MOVE(2)')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 5,4,WEST,WHITE")
      expect(pawn.execute('MOVE')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 4,4,WEST,BLACK")
      expect(pawn.execute('LEFT')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 4,4,SOUTH,BLACK")
      expect(pawn.execute('MOVE')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 4,3,SOUTH,WHITE")
      expect(pawn.execute('MOVE')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 4,2,SOUTH,BLACK")
      expect(pawn.execute('LEFT')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 4,2,EAST,BLACK")
      expect(pawn.execute('LEFT')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 4,2,NORTH,BLACK")
      expect(pawn.execute('MOVE')).to eq(true)
      expect(pawn.execute('REPORT')).to eq("Current Position: 4,3,NORTH,WHITE")
    end
  end
end 
