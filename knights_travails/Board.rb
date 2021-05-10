class Board

    def initialize
        @board = Array.new(8) { Array.new(8 , :X) }

    end

    def print
        puts "  #{(0..7).to_a.join(" ")}"
        @board.each_with_index do |row, i|
            puts "#{i} #{row.join(" ")}"
        end
    end

    def [](pos)
        row, col = pos
        @board[row][col]
    end

    def build_move_tree(target)
        checked = [] #00, 12
        queue = [self] # , [2,1]
        until queue.empty?
            node = queue.shift 
            check = node
            return checked if target == node.value # 12 == 12
            queue += node.valid_pos # 
        end
        nil
    end

end

board = Board.new
board.print
p board.get_neighbors([1,2])
p board.get_neighbors([0,0])

=begin 
[0,0] => [[1,2] 
          [2,1]]
                 
[1,2] => [[0,0], [-1,-2]``
          [0,4], [-1, +2]``
          [2,4], [+1,+2]``
          [3,3], [+2, +1]``
          [3,1], [+2, -1]``
          [2,0] [+1, -2]``
          [-1,1] [-2,-1]``
          [-1,3] [-2, +1]
          *** PATTERN IS PERMUTATIONS OF possible nums = [-1,1,-2,2]
          output = []
          (0...possible_nums.length).each do |i|
            inner = []
            (i + 1...possible_nums.length).each do |j|
                inner << possible_nums[i][j]
                if inner.length == 2
                    output << inner
                    inner = []
                end
            end


=end

#        -1, +2    +1, +2
# -2, -1                  -1, +2
#                K
# -1, -2                  +1, +2
#        2, -1    +2, +1


# 00 01 02
# 10 11 12
# 20 21 22
     

    
                


    