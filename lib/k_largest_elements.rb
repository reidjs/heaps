require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new
  array.each do |el|
    heap.push(el)
  end 
  while heap.count > k
    heap.extract 
  end 
  heap.store.sort 
end
