require_relative 'pawn'

class PawnSimulator
  def initialize
    @pawn = Pawn.new
  end

  def process(command)
    puts @pawn.execute(command)
  end
end
