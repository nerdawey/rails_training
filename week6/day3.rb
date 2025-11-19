 Singleton Pattern.

require 'singleton'

class AppConfig
  include Singleton

  def initialize
    @settings = { env: "production" }
  end

  def [](key)
    @settings[key]
  end

  def []=(key, value)
    @settings[key] = value
  end
end

c1 = AppConfig.instance
c2 = AppConfig.instance

puts c1.object_id == c2.object_id 

begin
  AppConfig.new
rescue NoMethodError => e
  puts "Cannot call new: #{e.message}"  
end

begin
  c1.dup
rescue TypeError => e
  puts "Cannot clone: #{e.message}"  
end

begin
  c1.clone
rescue TypeError => e
  puts "Cannot duplicate: #{e.message}"  
end

#BRIDGE PATTERN

class NotificationType
    def send(message)
      raise NotImplementedError
    end
  end
  
  class Email < NotificationType
    def send(message)
      puts "Sending Email: #{message}"
    end
  end
  
  class SMS < NotificationType
    def send(message)
      puts "Sending SMS: #{message}"
    end
  end
  
  class Push < NotificationType
    def send(message)
      puts "Sending Push: #{message}"
    end
  end
  
  class Notification
    def initialize(type)
      @type = type
    end
  
    def send(message)
      @type.send(message)
    end
  end
  
  class AlertNotification < Notification
    def send(message)
      super("ALERT: #{message}")
    end
  end
  
  class ReportNotification < Notification
    def send(message)
      super("REPORT: #{message}")
    end
  end
  
  email = Email.new
  notif = AlertNotification.new(email)
  notif.send("Hello Wrold")


class ShippingStrategy
    def calculate(order)
      raise NotImplementedError, "Subclasses must implement calculate method"
    end
  end
  
  class FedExStrategy < ShippingStrategy
    def calculate(order)
      order.weight * 10 + 15
    end
  end
  
  class AramexStrategy < ShippingStrategy
    def calculate(order)
      order.weight * 8 + 10
    end
  end
  
  class DHLStrategy < ShippingStrategy
    def calculate(order)
      order.weight * 12 + 20
    end
  end
  
  class ShippingCalculator
    def initialize(strategy)
      @strategy = strategy
    end
  
    def calculate(order)
      @strategy.calculate(order)
    end
  end
  
  order = OpenStruct.new(weight: 5)
  
  puts "=== Using Strategy Pattern ==="
  fedex_calc = ShippingCalculator.new(FedExStrategy.new)
  puts "FedEx shipping cost: $#{fedex_calc.calculate(order)}"
  
  aramex_calc = ShippingCalculator.new(AramexStrategy.new)
  puts "Aramex shipping cost: $#{aramex_calc.calculate(order)}"
  
  dhl_calc = ShippingCalculator.new(DHLStrategy.new)
  puts "DHL shipping cost: $#{dhl_calc.calculate(order)}"
  
  puts "\n=== Easy to Add New Strategy ==="
  class UPSStrategy < ShippingStrategy
    def calculate(order)
      order.weight * 9 + 12
    end
  end
  
  ups_calc = ShippingCalculator.new(UPSStrategy.new)
  puts "UPS shipping cost: $#{ups_calc.calculate(order)}"