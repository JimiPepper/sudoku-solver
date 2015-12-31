class Matrix
  def initialize(size)
    @matrix = Array.new()
    @size = size

    for i in 1..size
      array = Array.new(3, 0)
      start = 3 * i - 2
      array[0] = start
      array[1] = start + 1
      array[2] = start + 2
      @matrix.push(array)
    end
  end

  def get(i, j)
    return @matrix[i - 1][j - 1]
  end

  def set(i, j, newValue)
    @matrix[i - 1][j - 1] = newValue
  end

  def line(i)
    return @matrix[i - 1]
  end

  def column(j)
    col = Array.new(@size - 1)

    @size.times do |i|
      col[i] = @matrix[i - 1][j - 1]
    end

    return col
  end

  def to_s()
    resp = ""

    for i in 0..(@size  - 1)
      @matrix[i].each { |elem| resp += "#{elem} " }
      resp += "\n"
    end

    return resp
  end
end
