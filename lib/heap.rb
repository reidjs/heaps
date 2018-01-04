require 'pry'
require 'byebug'
class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []

  end

  def count
    @store.length
  end
  #extract the min value
  #swap to rightmost 
  def extract
   t = @store[-1]
   @store[-1] = @store[0]
   @store[0] = t
   val = @store.pop
   BinaryMinHeap.heapify_down(@store, 0)
   val 
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, @store.length-1)
  end

  public
  def self.child_indices(len, parent_index)
    #return child indices that fall within the array
    arr = []
    left =  2 * parent_index + 1
    right = 2 * parent_index + 2
    arr << left if left < len 
    arr << right if right < len 
    arr
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  # def self.heapify_down(array, parent_idx, len = array.length, &prc)
  #   prc ||= Proc.new {|a, b| a <=> b }
  #   # children_idxs = self
  #   #                   .child_indices(len, parent_idx)
  #   #                   .map{|v| array[v]}
  #   # smaller_child_idx = array.index(children_idxs.min)
  #   # return array if children_idxs.empty?
  #   # if children_idxs.length == 1 || prc.call(children_idxs[0], children_idxs[1]) < 0
  #   #   child_idx = children_idxs[0]
  #   # else 
  #   #   child_idx = children_idxs[1]
  #   # end 
  #   # binding.pry
  #   children_idxs = nil
  #   while  children_idxs.nil? || !children_idxs.empty?
  #     children_idxs = child_indices(len, parent_idx)
  #     if children_idxs.length == 1 || prc.call(children_idxs[0], children_idxs[1]) < 0
  #       child_idx = children_idxs[0]
  #     else 
  #       child_idx = children_idxs[1]
  #     end 
  #     if prc.call(array[parent_idx], array[child_idx]) > 0
  #       t = array[parent_idx]
  #       array[parent_idx] = array[child_idx]
  #       array[child_idx] = t
  #       # self.heapify_down(array, child_idx, len, &prc)
  #     end 
  #   end 
  #   array
  # end 

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    children_idxs = self.child_indices(len, parent_idx).map{|v| array[v]}
    smaller_child_idx = array.index(children_idxs.min)
    return array if smaller_child_idx.nil?
    # binding.pry 
    # if prc 
    #   prc.call(array[smaller_child_idx])

    # end 
    if (!prc.nil? && prc.call(array[parent_idx], array[smaller_child_idx]) > 0) || (prc.nil? && (array[parent_idx] > array[smaller_child_idx]))
      t = array[parent_idx]
      array[parent_idx] = array[smaller_child_idx]
      array[smaller_child_idx] = t
      # binding.pry
      self.heapify_down(array, smaller_child_idx, len, &prc)
      # byebug
    end 
    # prc ? array.reverse : array
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    parent_idx = self.parent_index(child_idx)
    if array[child_idx] < array[parent_idx]
      t = array[child_idx]
      array[child_idx] = array[parent_idx]
      array[parent_idx] = t
      self.heapify_up(array, parent_idx, len, &prc)
    end 
    array
  end
end
