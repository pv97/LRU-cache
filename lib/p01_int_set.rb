class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @length = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num >= 0 && num < @length
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num].push(num) unless include?(num)
  end

  def remove(num)
    self[num].delete(num) if include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num%20]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count >= num_buckets
    unless include?(num)
      self[num_buckets].push(num)
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      self[num_buckets].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old = @store
    @store = Array.new(num_buckets*2) { Array.new }
    @count = 0
    old.each do |arr|
      arr.each do |el|
        self.insert(el)
      end
    end
  end
end
