class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList

  include Enumerable

  def initialize
    @head = Link.new()
    @tail = Link.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail || @tail.prev == @head
  end

  def get(key)
    each do |el|
      return el.val if el.key == key
    end
  end

  def include?(key)
    each do |el|
      return true if el.key == key
    end
    false
  end

  def insert(key, val)
    link = Link.new(key,val)
    before = last
    link.prev = before
    link.next = @tail
    before.next = link
    @tail.prev = link
    return link
  end

  def remove(key)
    current = nil
    each do |el|
      current = el if el.key == key
    end
    if current
      before = current.prev
      after = current.next
      before.next = after
      after.prev = before
    end
  end

  def each(&prc)
    current = first
    until current == @tail
      prc.call(current)
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
