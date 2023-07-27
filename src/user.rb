class User
    attr_reader :login, :email

    def initialize(login:, email:)
        @login = login
        @email = email
    end
end