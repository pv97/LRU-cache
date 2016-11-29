require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap

  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count >= num_buckets
    list = bucket(key)
    unless list.include?(key)
      @count += 1
    else
      list.remove(key)
    end
    list.insert(key,val)
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    list = bucket(key)
    if list.include?(key)
      list.remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    @store.each do |list|
      list.each do |el|
        prc.call(el.key,el.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old = @store
    @store = Array.new(num_buckets*2) { LinkedList.new }
    @count = 0
    old.each do |list|
      list.each do |el|
        self[el.key] = el.val
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
