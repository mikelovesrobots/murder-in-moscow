module MimScreen
  module Dimensions
    # Returns the number of columns wide this screen is
    def cols
      rows_and_cols.last
    end

    # Returns the number of rows wide this screen is
    def rows
      rows_and_cols.first
    end

    private
   
    def rows_and_cols
      rows, cols = [], []
      @screen.getmaxyx(rows, cols)
      [rows.first, cols.first]
    end
  end
end
    
