require 'yaml'

class ConstantsManagement
  def initialize(source = self.class.source)
    create_const(YAML.load(File.open(source)))
  end

  def create_const(date)
    date.each do |klass, value|
      name = value.keys.first.upcase
      const = value.values.first
      self.class.const_set(klass, Class.new { |k|
        const_set(name, const)
      })
    end
  end

  class << self
    def source(value = nil)
      @source ||= value
    end
  end
end
