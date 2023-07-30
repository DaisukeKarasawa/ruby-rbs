class Student
    attr_reader :name, :number
    attr_accessor :grade, :credit

    # 生徒名, 学年, 学籍番号, 取得単位
    def initialize(name, grade, number, credit)
        @name = name
        @grade = grade
        @number = number
        @credit = credit
    end

    # 取得単位が 40 * 学年 より多ければ、進級できる
    def up_grade
        base = 40
        @grade += 1 if @credit > (base * @grade)
    end

    # 単位数の増加
    def get_credit(n)
        @credit += n
        "単位が#{n}増えました"
    end

    # 学生情報の取得
    def get_student(str)
        if str == @number
            "#{@name}は、現在#{@grade}年生です"
        else
            nil
        end
    end
end