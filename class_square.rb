class Square
  attr_accessor :children, :pos, :parent
  @@N = 0
  def initialize(pos, parent = nil)
    @pos = pos
    @children = nil
    @parent = parent
    @@N += 1
  end

  def self.N()
    @@N
  end
end