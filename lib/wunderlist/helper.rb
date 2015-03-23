module Wunderlist
  module Helper

    def to_hash
      instance_variables = self.instance_variables
      instance_variables.delete(':@api')
      hash = {}
      instance_variables.each {|var| hash[var.to_s.delete("@")] = self.instance_variable_get(var) }
      return hash
    end

  end
end

class Hash

  def stringify_keys
    self.replace(self.inject({}){|a,(k,v)| a[k.to_s] = v; a})
  end

end

