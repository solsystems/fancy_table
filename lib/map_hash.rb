module Enumerable
  def map_hash(&block)
    inject({}) do |memo, *args|
      results = block.call(*args)
      unless results.nil?
        k, v = results
        memo[k]=v
      end
      memo
    end
  end

  def slice_hash
    hash={}
    each_slice(2) { |k,v| hash[k]=v }
    hash
  end
end
