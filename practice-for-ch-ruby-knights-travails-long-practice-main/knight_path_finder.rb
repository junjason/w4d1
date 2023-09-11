require_relative "./tree_node.rb"
require "byebug"
class KnightPathFinder

    attr_reader :considered_positions, :root_node

    def self.valid_moves(position)
        valid_moves = []
        start_r, start_c = position
        # move 1 
        r_1 = start_r-1
        c_1 = start_c-2
        valid_moves << [r_1, c_1] if valid_pos([r_1,c_1])
        # move 2
        r_2 = start_r-2
        c_2 = start_c-1
        valid_moves << [r_2, c_2] if valid_pos([r_2, c_2])
        # move 3
        r_3 = start_r-2
        c_3 = start_c+1
        valid_moves << [r_3, c_3] if valid_pos([r_3,c_3])
        # move 4
        r_4 = start_r-1
        c_4 = start_c+2
        valid_moves << [r_4, c_4] if valid_pos([r_4, c_4])
        # move 5
        r_5 = start_r+1
        c_5 = start_c+2
        valid_moves << [r_5, c_5] if valid_pos([r_5,c_5])
        # move 6
        r_6 = start_r+2
        c_6 = start_c+1
        valid_moves << [r_6, c_6] if valid_pos([r_6, c_6])
        # move 7
        r_7 = start_r+2
        c_7 = start_c-1
        valid_moves << [r_7, c_7] if valid_pos([r_7,c_7])
        # move 8
        r_8 = start_r+1
        c_8 = start_c-2
        valid_moves << [r_8, c_8] if valid_pos([r_8, c_8])

        valid_moves
    end


    # returns boolean on whether it is a valid board position (not off the board) on an 8x8 board
    def self.valid_pos(position)
        r, c = position
        r >= 0 && r < 8 && c >= 0 && c < 8
    end

    def initialize(start_position)
        @root_node = PolyTreeNode.new(start_position)
        @considered_positions = [start_position]
        build_move_tree(@root_node)
    end

    def build_move_tree(root_node)
        queue = [root_node]
        while !queue.empty?
            current_node = queue.shift
            current_pos = current_node.value
            new_positions = new_move_positions(current_pos)
            new_positions.each do |pos|
                node = PolyTreeNode.new(pos)
                node.parent = current_node
                @considered_positions << pos
                #debugger
                queue << node
            end
        end
    end

    def find_path(end_position)
        #use dfs from root_node to end position
        #if found, call trace_path_back
        queue = [@root_node]
        found = false
        end_node = nil
        while !queue.empty? && !found 
            current_node = queue.shift
            current_pos = current_node.value
            if current_pos == end_position
                found = true
                end_node = current_node
            end
            current_node.children.each do |children|
                queue << children
            end
        end

        trace_path_back(end_node) if found
    end

    def trace_path_back(end_node)
        path = []
        curr_node = end_node
        while curr_node != @root_node
            path.unshift(curr_node.value)
            curr_node = curr_node.parent
        end
        path.unshift(curr_node.value)
        path
    end

    def new_move_positions(position)
        new_possible_positions = KnightPathFinder.valid_moves(position)
        @considered_positions.each do |visited|
            new_possible_positions.delete(visited)
        end 
        new_possible_positions
    end
end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
p kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]