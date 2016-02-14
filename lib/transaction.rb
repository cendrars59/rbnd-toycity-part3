class Transaction

  attr_accessor :id, :customer, :product
  @@transactions = []
  @@transaction_count = 0

  def initialize customer, product
    @@transaction_count +=1
    @id = @@transaction_count
    @customer = customer
    @product = product
    add_to_transcations_list
    stock_update
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions.find { |transaction| transaction.id == id }
  end



  def stock_update
    if @product.in_stock?
      @product.stock -=1
    else
      raise OutOfStockError, " '#{@product.title}' is out of stock."
    end
  end

  def find_by_id(id)
    @@transactions.find { |transaction| transaction.id == id }
  end

  def not_exist_in_list?
    find_by_id(id)==nil
  end

  private

  def add_to_transcations_list
    if not_exist_in_list?
      @@transactions << self
    else
      raise DuplicateTransactionError, "'#{self.id}' already exists."
    end
  end

end
