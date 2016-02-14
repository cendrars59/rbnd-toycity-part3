class Customer

    attr_accessor :name
    @@customers = []

    def initialize customer
      @name = customer[:name]
      add_to_customers_list
    end

    def self.all
      @@customers
    end

    def self.find_by_name(name)
      @@customers.find { |customer| customer.name == name }
    end

    def find_by_name(name)
      @@customers.find { |customer| customer.name == name }
    end

    def not_exist_in_list?
      find_by_name(name)==nil
    end

    def purchase(product)
      transaction = Transaction.new(product)
    end

    private

    def add_to_customers_list
      if not_exist_in_list?
        @@customers << self
      else
        raise DuplicateCustomerError, "'#{self.name}' already exists."
      end
    end

end
