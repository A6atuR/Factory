class Factory

  def self.new(*attributes, &block)
    Class.new do

      attributes.each do |attribute|
        define_method("#{attribute}") { instance_variable_get("@#{attribute}") }
        define_method("#{attribute}=") { |a| instance_variable_set("@#{attribute}", a) }
      end

      define_method ("[]") do |attribute|
        attribute.class == Fixnum ? instance_variable_get("@#{attributes[attribute]}") : instance_variable_get("@#{attribute}")
      end

      define_method :initialize do |*values|
        attributes.length.times do |i|
          instance_variable_set("@#{attributes[i]}", values[i])
        end
      end

      class_eval(&block) if block_given?

    end
  end

end

MyClass = Factory.new(:name, :status) do
  def greeting
    "Hello #{name}!"
  end
end

test = MyClass.new("StaseG", "Ok")

puts test.name
puts test["name"]
puts test[:name]
puts test[0]
puts test.greeting