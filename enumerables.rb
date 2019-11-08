# frozen_string_literal: true

# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity:
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    if block_given?
      item = 0
      while item < size
        yield(self[item])
        item += 1
      end
    end

    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    if block_given?
      index = 0
      while index < size
        yield(self[index], index)
        index += 1
      end
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    if block_given?
      filtered = []
      my_each { |x| filtered.push(x) if yield(x) }
    end
    filtered
  end

  def my_all?(pattern = nil)
    not_all = 0
    if pattern.class == Regexp
      my_each { |x| not_all = 1 if pattern.match(x).nil? }
      not_all != 1
    else
      my_each { |x| not_all = 1 if x != pattern }
    end
    if block_given?
      index = 0
      while index < size
        not_all = 1 unless yield(self[index])
        index += 1
        break if not_all == 1
      end
    end
    not_all != 1
  end

  def my_any?(pattern = nil, &block)
    any = 0
    if !block_given? && pattern.nil?
      my_each { |x| any = 1 if x == true || !x.nil? }
    end
    if pattern.class == Regexp
      my_each { |x| any = 1 unless pattern.match(x).nil? }
      any == 1
    else
      my_each { |x| any = 1 unless x != pattern }
    end
    if block_given?
      any = 1 unless my_none?(pattern = nil, &block)
      any == 1
    end
    any == 1
  end

  def my_none?(pattern = nil)
    some = 0
    if pattern.class == Regexp
      my_each { |x| some = 1 unless pattern.match(x).nil? }
      some == 1
    end
    if block_given?
      index = 0
      while index < size
        some = 1 if yield(self[index])
        index += 1
        break if some == 1
      end
    end
    some != 1
  end

  def my_count(j = nil)
    count = 0
    return size if j.nil? && !block_given?
    if block_given?
      index = 0
      while index < size
        count += 1 if yield(self[index])
        index += 1
      end
    end
    my_each { |x| count += 1 if x == j } unless j.nil?
    count
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?
    new_array = []
    my_each { |x| new_array << proc.call(x) } if proc
    my_each { |x| new_array << yield(x) } if block_given?
    new_array
  end

  def my_inject(*args)
    array_self = self.class == Range ? to_a : self
    if block_given?
      acumulator = 0
      array_self.my_each { |x| acumulator = yield(acumulator, x) }
      acumulator += args[0] if args[0].class == Integer
      acumulator += array_self[0] if args[0].nil?
      return acumulator
    end
    if args[1].class == Symbol && args[0].class == Integer
      acumulator = args[0]
      array_self.my_each { |x| acumulator = acumulator.send(args[1], x) }
      return acumulator
    elsif args[0].class == Symbol
      acumulator = 0
      my_each { |x| acumulator = acumulator.send(args[0], x) }
      return acumulator
    end
  end
end

def multiply_els(x)
  x.my_inject([x]) { |a, b| a * b }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity:
