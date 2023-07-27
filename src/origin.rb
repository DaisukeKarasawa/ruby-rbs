class Student
    attr_reader :name, :number
    attr_accessor :grade, :credit

    def initialize(name, grade, number, credit)
        @name = name
        @grade = grade
        @number = number
        @credit = credit
    end

    def up_grade
        base = 40
        @grade += 1 if @credit > (base * @grade)
    end

    def get_credit(n)
        @credit += n
        "単位が#{n}増えました"
    end

    def get_student(str)
        if str == @number
            "#{@name}は、現在#{@grade}年生です"
        else
            nil
        end
    end
end