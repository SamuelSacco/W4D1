class KnightPathFinder
    attr_reader :considered_positions

    MOVES = [
        [-1, 2], 
        [1, 2], 
        [-2, 1], 
        [1, -2], 
        [2, 1], 
        [2, -1], 
        [-2,-1], 
        [-1,-2]
    ]

    def self.valid_moves(pos)
        row, col = pos
        result_array = []
        # coordinates = [[-1, 2], [1, 2], [-2, 1], [1, -2], [2, 1], [2, -1], [-2,-1], [-1,-2]]
        (0..7).each do |i|
            new_row = row + MOVES[i][0]
            new_col = col + MOVES[i][1]
            if (0..7).to_a.include?(new_row) && (0..7).to_a.include?(new_col)
                result_array << [new_row, new_col]
            end
        end
        result_array
    end

    def initialize(pos)
        @root = pos
        @considered_positions = [pos]
    end
    
    def find_path(pos)

    end

    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos)
        @considered_positions += new_moves.select do |ele| 
            !@considered_positions.include?(ele) 
        end
        #what was placed on considered positions is the children
        #of the current node in the queue       
    end

    def build_move_tree
        queue = [ @root ]
        until queue.empty?
            position = queue.shift 
            node = PolyTreeNode.new(position)
            queue += new_move_positions(node.position)
            #set child and parents
        end
        nil
    end

end

game = KnightPathFinder.new([0,0])
# p game.find_path([0,0])

# p game.considered_positions
# p game.new_move_positions([0,0])
# p game.considered_positions

p game.build_move_tree([1,2])
p game.build_move_tree([2,5])