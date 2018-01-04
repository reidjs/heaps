require_relative "heap"
require 'pry'
class Array
  def heap_sort!
    heap = BinaryMinHeap.new
    while self.length > 0 
      heap.push(self.pop)
    end 
    # self.each do |val|
    #   heap.push(val)
    # end 
    # binding.pry
    # sorted = []
    while heap.count > 0
      self.push(heap.extract)
    end 
    self
  end
end
