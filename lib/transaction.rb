class Transaction

  attr_accessor :id, :customer, :product, :invoice

  @@transactions = []
  @@transaction_count = 0

  def initialize customer, product
    @@transaction_count +=1
    @id = @@transaction_count
    @customer = customer
    @product = product
    @invoice = generate_invoice
    add_to_transcations_list
    stock_update
    credit_loyalty_points
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

  def credit_loyalty_points
    if @product.price < 30
      @customer.loyalty_points = @customer.loyalty_points + 10
    else
      @customer.loyalty_points = @customer.loyalty_points + 100
    end
  end

  def fill_theinvoice(file)
      file.puts ("------------------------------------------------------------------------------")
      file.puts ("Transaction date : #{Time.now}          Transaction id:#{@id}")
      file.puts ("Customer :#{@customer.name}      Loyalty points:#{@customer.loyalty_points}")
      file.puts ("Item #{@product.title}    unit price: #{@product.price}$   ")
      file.puts ("")
      file.puts ("                          Total:#{@product.price}$                                      ")
  end

  def generate_invoice
    file = File.new("Invoice_#{Time.now}_#{@customer.name}.txt", "w+")
    fill_theinvoice(file)
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
