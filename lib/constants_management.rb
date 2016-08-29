require 'yaml'
require 'open-uri'

class ConstantsManagement
  def initialize
    date = YAML.load(File.open("spec/sample.yml"))
    date.each do |key, value|
      name = value.keys.first.upcase
      const = value.values.first
      if const.is_a?(Array)
        eval <<-EOS
          class #{key}
            #{name} = #{const}
          end
        EOS
      else
        eval <<-EOS
          class #{key}
            #{name} = "#{const}"
          end
        EOS
      end
    end
  end
end
