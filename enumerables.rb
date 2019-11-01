module Enumerable
    def my_each
        if block_given?
            item = 0
            while item < self.size
                yield(self[item])
             item+=1
            end
        end
    
    self
    end



    def my_each_with_index
        if block_given?
            index = 0
            while index < self.size
                yield(self[index], index)
                index+=1
            end
        end
        self
    end

    def my_select
        if block_given?
            filtered = []
            index = 0
            self.my_each { |x| filtered.push(x) if yield(x) }
        end
        filtered
    end
    
    def my_all?
        if block_given?
            not_all = 0
            index = 0
            while index < self.size
                not_all = 1 if !yield(self[index])
                index+=1
                break if not_all == 1
            end
            
        end
        not_all == 1 ? false : true
    end

    def my_any?
        if block_given?
            any = 0
            index = 0
            while index < self.size
                any = 1 if yield(self[index])
                index+=1
                break if any == 1
            end
        end
        any == 1 ? true : false
    end

    def my_none?
        if block_given?
            some = 0
            index = 0
            while index < self.size
                some = 1 if yield(self[index])
                index+=1
                break if some == 1
            end
        end
        some == 1 ? false : true
    end

    def my_count
        if block_given?
            count = 0
            index = 0
            while index < self.size
                count+=1 if yield(self[index])
                index+=1
            end
        end
        count
    end

    def my_map(proc = nil)
        new_array = []
        index = 0
        if proc 
            self.my_each { |x| new_array << proc.call(x)}
        end
        if block_given?
            self.my_each {|x| new_array << yield(x)}
        end             
        new_array
    end

    def my_inject
        if block_given?
            acumulator = self[0]
            index = 1
            while index < self.size
                acumulator = yield(acumulator, self[index])
                index+=1
            end

        end
        acumulator
    end

    def multiply_els

        self.my_inject{|a,b| a * b}
         
    end
end


# puts [12,3,4,4,33].my_map {|x| x ** 2}