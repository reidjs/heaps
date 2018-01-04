require_relative "heap"
require 'pry'
class Array
  def heap_sort!
    heap = BinaryMinHeap.new
    while self.length > 0 
      heap.push(self.pop)
    end 
    while heap.count > 0
      self.push(heap.extract)
    end 
    self
  end
end
