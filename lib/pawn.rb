require 'pry'

class Pawn
  attr_reader :position, :direction, :color

  DIRECTIONS= [:north, :east, :south, :west]
  COMMANDS= [:place, :left, :right, :report]
  COLORS = [:white, :black]

  def place(x, y, direction, color)
    raise TypeError, 'Invalid coordinates' unless x.is_a? Integer and y.is_a? Integer
    raise TypeError, 'Invalid direction' unless DIRECTIONS.include?(direction)
    raise TypeError, 'Invalid color' unless COLORS.include?(color)

    if check_valid_position?(x,y)
      @position = { x: x, y: y }
      @direction = direction
      @color = color
      @double_move = true
      true
    else
      false
    end
  end

  def move(value=1)
    return "Pawn is not placed yet, try running place command first" if @position.nil? or @direction.nil? or @color.nil?
    return false if @position.nil?
    return "you should not move 2 squares here after" if !@double_move && value.eql?(2)

    position = @position
    movement = nil

    case @direction
    when :north
      movement = value.eql?(1) ? { x: 0, y: 1} : { x: 0, y: 2 }
    when :east
      movement = value.eql?(1) ? { x: 1, y: 0} : { x: 2, y: 0 }
    when :south
      movement = value.eql?(1) ? { x: 0, y: -1} : { x: 0, y: -2 }
    when :west
      movement = value.eql?(1) ? { x: -1, y: 0} : { x: -2, y: 0 }
    end

    move_complete = true

    if check_valid_position?(position[:x] + movement[:x], position[:y] + movement[:y])
      @position = { x: position[:x] + movement[:x], y: position[:y] + movement[:y] }

      if value.odd?
        color_index = COLORS.index(@color)
        @color = COLORS.rotate()[color_index]
      end
    else
      move_complete = false
    end

    @double_move = false
    move_complete ? move_complete : "You should not move as Pawn will fell down"
  end

  def move_position(command)
    return "Pawn is not placed yet, try running place command first" if @position.nil? or @direction.nil? or @color.nil?
    return false if @direction.nil?
    position_index = DIRECTIONS.index(@direction)

    @direction = command.to_s.eql?("left") ? DIRECTIONS.rotate(-1)[position_index] : DIRECTIONS.rotate()[position_index]
    true
  end

  def report
    return "Pawn is not placed yet, try running place command first" if @position.nil? or @direction.nil? or @color.nil?

    "Current Position: #{@position[:x]},#{@position[:y]},#{@direction.to_s.upcase},#{@color.to_s.upcase}"
  end

  def execute(params)
    return if params.strip.empty?

    args = params.split(/\s+/)
    command = args.first.to_s.downcase.to_sym
    arguments = args.last

    raise ArgumentError, 'Invalid command' unless COMMANDS.include?(command) || command.to_s.include?("move")

    if command.to_s.eql?("move(2)")
      position = command.to_s.split("(")[1].gsub!(")","").to_i
      command = :move_with_position
    elsif command.to_s.eql?("move(1)")
      command = :move
    end

    case command
    when :place
      raise ArgumentError, 'Invalid command' if arguments.nil?

      tokens = arguments.split(/,/)

      raise ArgumentError, 'Invalid command' unless tokens.count > 3

      x = tokens[0].to_i
      y = tokens[1].to_i
      direction = tokens[2].downcase.to_sym
      color = tokens[3].downcase.to_sym

      place(x, y, direction, color)
    when :move
      move
    when :left
      move_position("left")
    when :right
      move_position("right")
    when :report
      report
    when :move_with_position
      move(position)
    else
      raise ArgumentError, 'Invalid command'
    end
  end

  private

  def check_valid_position?(x,y)
    (x>=0 && x<=7 && y>=0 && y<=7)
  end

end
