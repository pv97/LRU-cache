require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    link = @map[key]

    if link
      return link.val
    else
      value = @prc.call(key)
      insert(key,value)
      return value
    end
  end

  def insert(key,val)
    eject! if count >= @max
    link = Link.new(key,val)
    update_link!(link)
  end

  def remove(key)
    @map.delete(key)
    @store.remove(key)
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.remove(link.key)
    link = @store.insert(link.key,link.val)
    @map[link.key] = link
  end

  def eject!
    first = @store.first
    @store.remove(first.key)
    @map.delete(first.key)
  end
end
