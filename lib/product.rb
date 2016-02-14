class Product

  attr_accessor :title, :price, :stock
  attr_reader :in_stock
  @@products = []

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products_list
  end

  def self.all
    @@products
  end

  def self.find_by_title(title)
    @@products.find { |product| product.title == title }
  end

  def self.in_stock
    @@products.select { |product| product.stock > 0 }
  end


  def in_stock?
    @stock > 0
  end

  def find_by_title(title)
    @@products.find { |product| product.title == title }
  end

  def not_exist_in_list?
    find_by_title(title)==nil
  end

  private

  def add_to_products_list
    if not_exist_in_list?
      @@products << self
    else
      raise DuplicateProductError, "'#{self.title}' already exists."
    end
  end
end
