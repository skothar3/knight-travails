class Knight
  attr_accessor :square

  def initialize(initial_pos)
    validate_input(initial_pos)
    @square = Square.new(initial_pos)
    build_tree()
  end

  def knight_moves(dest_pos)
    validate_input(dest_pos)

    queue = [@square]
    shortest_path = []

    until queue.empty?
      square = queue.shift()
      break if square.pos == dest_pos

      queue += square.children unless square.children.nil?
    end

    until square.nil?
      shortest_path.unshift(square.pos)
      square = square.parent
    end

    puts "You made it in #{shortest_path.length} moves! =>"
    p shortest_path
  end
  
  def level_order(root = @square, &block)
    return if root.nil?

    queue = []

    queue.push(root)

    level_ordered_array = []

    while queue.length > 0
      yield queue[0] if block_given?
            
      level_ordered_array.push(queue[0].pos)
        
      node = queue.shift()

      queue += node.children unless node.children.nil?
    end

    return level_ordered_array unless block_given?
  end

  private

  def build_tree()
    queue = [@square]
    count = 1
    until queue.empty?
      current_square = queue.shift()
      current_square.children += get_possible_moves(current_square)
      queue += current_square.children
      count += 1
      break if count > 585
    end
  end

  def get_possible_moves(parent_square)
    perms = [[-1, -2], [-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2]]

    poss_moves = []

    perms.each do |tuple|
      new_square = Square.new([parent_square.pos[0] + tuple[0], parent_square.pos[1] + tuple[1]], parent_square)
      
      poss_moves.push(new_square) if new_square.pos.all? { |coord| coord >= 0 && coord <= 7 } && (parent_square.parent.nil? || new_square.pos != parent_square.parent.pos)
    end

    return poss_moves
  end

  def validate_input(input)
    if !input.is_a?(Array) || input.length != 2 || input.all? { |coord| coord.negative? && coord > 7 }
      raise 'Invalid input!'
    end
  end

end