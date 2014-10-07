class Game

  attr_accessor :grid, :tick, :size

  def initialize
    @tick = 0
    @grid = create_grid
    puts "init grid"
    print_grid
  end

  def play
    puts "---- tick one ----"
    loop_through_grid
    print_grid
    end_game_print_result
  end


  def create_grid
    puts "Please enter the size of the board:"
    @size = gets.chomp.to_i
    Array.new(@size) { |i| Array.new(@size) { |i| [true, nil].sample } }
  end

  def end_game_print_result
    #if row.include?("•")
    print "Days passed: #{@tick}"
    print "#{@tick} ticks were played, end of game."
  end

  def loop_through_grid
    @grid.each_index do |row|
      @grid[row].each_index do |col|
          #puts "row = #{row} col = #{col} value = #{@grid[row, col]}"
          next if @grid[row, col].empty?
          #puts "WRONG"
          count = count_neighbors(row, col)
          kill_or_let_live(count, row, col)
      end
    end
    @tick += 1
  end

  def print_grid
    @grid.each_index do |row|
      @grid[row].each_index do |col|
          case @grid[row][col]
          when true
            print ". |"
          when nil
            print "  |"
          when false
            print ", |"
          end
      end
      puts ""
    end
  end

  def count_neighbors(row, col)
    neighbors = [@grid[row, col-1],
     @grid[row, col+1],
     @grid[row-1, col-1],
     @grid[row+1, col-1],
     @grid[row-1, col-1],
     @grid[row-1, col+1],
     @grid[row+1,col-1],
     @grid[row+1,col+1],
     ]
     neighbors.compact.keep_if { |n| n }.count
  end

  def  kill_or_let_live(count, row, col)
      # Any live cell with two or three live neighbours lives on to the next generation.
      # do nothing
      # Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
      if count == 3
        revive(row, col)
      else count < 2 || count > 3
        # Any live cell with fewer than two live neighbours dies, as if caused by under-population.
        # Any live cell with more than three live neighbours dies, as if by overcrowding.
        kill(row, col)
      end
    end

    def kill(row, col)
      @grid[row][col] = false
    end

    def revive(row, col)
      @grid[row][col] = false
    end
end
