#test comment - this is awesome
require 'byebug'

class PolyTreeNode
    attr_reader :parent, :children, :pos

    def initialize(pos)
        @position = position
        @parent = nil
        @children = [] 
        #childred = KPF.valid_moves.map { |pos| PolyTreeNode.new(pos) }
    end

    def parent=(p_node)
        if self.parent != nil   #remove parent if p_node = nil
            idx = self.parent.children.index(self)
            self.parent.children.delete_at(idx)
        end

        @parent = p_node
        if p_node != nil && !p_node.children.include?(self)
            p_node.children << self 
        end
    end

    def add_child(child)
        child.parent = self
        self.children << child if !self.children.include?(child)
    end

    def remove_child(child)
        raise error if !self.children.include?(child)
        child.parent = nil
    end

    def dfs(target) 
        # debugger
        # return nil if self == nil
        return self if self.value == target # root = "a"
        self.children.each do |child| #
            search_result = child.dfs(target)   
            return search_result if search_result != nil
        end
        nil
    end

    def bfs(target)
        queue = [self]
        until queue.empty? # ["a"]
            ele = queue.shift # ele = "a"
            return ele if target == ele.value # "a" == 
            queue += ele.children
            # self.children.each do |child|
            #     queue << child
            # end
        end
        nil
    end
end

def fib(n)
    if n == 1
        return 1
    end
    if n == 2
        return 1
    end

    fib(n - 1) + fib(n - 2)
end


def fib_array(n)
    if n == 1
        return [1]
    elsif n == 2
        return [1,1]
    end
    seq = fib_array(n - 1)
    seq << seq[-1] + seq[-2]
end

p fib_array(5)

# 0,0 => [1,2],[]

# root = a
# a children = [b,c]

# b parent of d
# d child

# d.parent = b
# d.parent = nil

root = PolyTreeNode.new("a")

b = PolyTreeNode.new("b")
c = PolyTreeNode.new("c")
d = PolyTreeNode.new("d")
e = PolyTreeNode.new("e")
f = PolyTreeNode.new("f")
g = PolyTreeNode.new("g")
        #    a
        #   b c 
        # d e f g
root.add_child(b)    
root.add_child(c)  
b.add_child(d)
b.add_child(e)  
c.add_child(f)  
c.add_child(g)

p root.bfs(g)
# ----------------------------------------------------------
=begin 
----------------------------------------------------------
STACK 1: "a"
    def dfs("d")
        return nil if self.value == nil
        return self.value if self.value == "d" # root = "a"
        self.children.each do |child| # child = "b"
            search_result = child.dfs("d")
            return search_result if search_result != nil
        end
        nil
    end
----------------------------------------------------------
STACK 2: "a"
----------------------------------------------------------
def dfs("d")
    return nil if self.value == nil
    return self.value if self.value == "d" # root = "a"
    self.children.each do |child| #
        search_result = child.dfs("d")
        return search_result if search_result != nil
    end
    nil
end
----------------------------------------------------------
STACK 3: "a"
----------------------------------------------------------
def dfs("d")
    return nil if self.value == nil
    return self.value if self.value == "d" # root = "a"
    self.children.each do |child| #
        search_result = child.dfs("d")
        return search_result if search_result != nil
    end
    nil
end
----------------------------------------------------------
STACK 1: "a"
----------------------------------------------------------
def dfs("d")
    return nil if self.value == nil
    return self.value if self.value == "d" # root = "a"
    self.children.each do |child| #
        search_result = child.dfs("d")
        return search_result if search_result != nil
    end
    nil
end
----------------------------------------------------------
STACK 1: "a"
----------------------------------------------------------
def dfs("d")
    return nil if self.value == nil
    return self.value if self.value == "d" # root = "a"
    self.children.each do |child| #
        search_result = child.dfs("d")
        return search_result if search_result != nil
    end
    nil
end
=end
