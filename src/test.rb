class Test
    def self.myfunc(str)
        str
    end

    def self.foo(n)
        base = 10
        if n > base
            n.to_s
        else
            nil
        end
    end
end