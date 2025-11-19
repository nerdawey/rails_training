InvoiceItem = Struct.new(:price, :quantity)
class TaxCalculator
  def tax_for(_user, _subtotal)
    raise NotImplementedError
  end
end

class EgyptianTax < TaxCalculator
  RATE = 0.14

  def tax_for(_user, subtotal)
    subtotal * RATE
  end
end

class DefaultTax < TaxCalculator
  RATE = 0.20

  def tax_for(_user, subtotal)
    subtotal * RATE
  end
end

class TaxCalculatorFactory
  def self.for(country)
    country == "EG" ? EgyptianTax.new : DefaultTax.new
  end
end
class PaymentMethod
  def pay(amount)
    raise NotImplementedError
  end
end

class VisaPayment < PaymentMethod
  def pay(amount); end
end

class PaypalPayment < PaymentMethod
  def pay(amount); end
end

class CashPayment < PaymentMethod
  def pay(amount); end
end
class Logger
  def log(_message)
    raise NotImplementedError
  end
end

class FileLogger < Logger
  def initialize(writer)
    @writer = writer
  end

  def log(message)
    @writer.call(message)
  end
end

class InMemoryLogger < Logger
  attr_reader :messages

  def initialize
    @messages = []
  end

  def log(message)
    @messages << message
  end
end
class Notifier
  def notify(_user, _message)
    raise NotImplementedError
  end
end

class EmailNotifier < Notifier
  def initialize(client)
    @client = client
  end

  def notify(user, message)
    @client.deliver(to: user.email, body: message)
  end
end
class InvoiceProcessor
  def initialize(tax_calculator_factory:, logger:, notifier:)
    @tax_calculator_factory = tax_calculator_factory
    @logger = logger
    @notifier = notifier
  end

  def process(user:, items:, payment_method:)
    subtotal = items.sum { |i| i.price * i.quantity }
    tax = @tax_calculator_factory.for(user.country).tax_for(user, subtotal)
    total = subtotal + tax

    payment_method.pay(total)

    @logger.log("User: #{user.name}, Total: #{total}")
    @notifier.notify(user, "Thanks for your purchase. Amount: #{total}")

    total
  end
end
user = OpenStruct.new(name: "Ahmed", country: "EG", email: "ahmed@mail.com")
items = [InvoiceItem.new(10, 2), InvoiceItem.new(30, 1)]
payment = VisaPayment.new
logger = InMemoryLogger.new
mailer = EmailNotifier.new(MockMailClient.new)
processor = InvoiceProcessor.new(
  tax_calculator_factory: TaxCalculatorFactory,
  logger: logger,
  notifier: mailer
)

processor.process(user: user, items: items, payment_method: payment)