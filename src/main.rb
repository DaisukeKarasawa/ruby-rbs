require 'date'

# Class Peron
person = Person.new(name: 'hoge', gender: 'man')
person.call_gender
person.name
person.gender

# Class Test
Test.myfunc('Hello World')
Test.foo(30)
Test.foo(2)

# Class FizzBuzz
FizzBuzz.run(Date.today.day)

# Class Student
student = Student.new('Ken', 1, 'LP041', 35)
student.get_credit(10)
student.up_grade
student.get_student('LP041')
student.get_student('KP001')