class Person
    attr_reader :name, :gender

    def initialize(name:, gender:)
        @name = name
        @gender = gender
    end

    def call_gender
        "#{@gender}です"
    end
end
