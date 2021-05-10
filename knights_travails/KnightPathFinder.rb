require_relative "./00_tree_node.rb"

class KnightPathFinder
    attr_reader :considered_positions, :root

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
        @root = PolyTreeNode.new(pos)
        @start_pos = pos
        @considered_positions = [ @root ]
    end
    
    def find_path(pos)

    end

    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos)   #gets valid moves
        result = []
        new_moves.each do |pos|             #checks if that valid move is already in 
            if !in_considered_pos?(pos) 
                node = PolyTreeNode.new(pos)
                @considered_positions << node 
                result << node               
            end
        end
        result       
        #array of positions
        #what was placed on considered positions is the children
        #of the current node in the queue    
    end

    def in_considered_pos?(pos)
        @considered_positions.any? do |nodes|
            nodes.value == pos
        end
    end

    def build_move_tree
        queue = [ @root ]
        until queue.empty?

            node = queue.shift # current node that we're looking at
            
            neighbors = new_move_positions(node.value)
            queue += neighbors
            
            neighbors.each do |child|
                node.add_child(child)
                # child.parent=(node)
            end            
        end
    end

    def prints
        @considered_positions.each do |node|
            # p "parent: #{node.parent.value}" if node != @root
            # p node.value

            if node != @root
                print node.value, " parent: #{node.parent.value}"
                puts
            end

            # node.children.each { |child| }
        end
    end

    def repeats? #checks for repeats
        counter = Hash.new(0)
        @considered_positions.each do |ele|
            counter[ele.value] += 1
        end
        counter.values.any? { |v| v > 1}
    end


    def find_path(end_pos)
        queue = [@root]
        until queue.empty? 
            current = queue.shift
            if current.value == end_pos   
                return trace_path_back(current)
            else
                queue += current.children
            end
        end
        nil
    end

    def trace_path_back(end_node)
        path_back = [end_node]
        until path_back[-1].parent == nil 
            path_back << path_back[-1].parent
        end
        path_back.reverse.map(&:value)
    end
end

# game = KnightPathFinder.new([0,0])

# game.build_move_tree
# p game.find_path([7,7])

kpf = KnightPathFinder.new([0, 0])
kpf.build_move_tree
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
kpf.build_move_tree
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]