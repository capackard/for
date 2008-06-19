require 'app/configuration'
module RubyAMF
  module Configuration
    ClassMappings.translate_case = true
    ParameterMappings.scaffolding = true
  
    ClassMappings.register(
      :actionscript  => 'User',
      :ruby          => 'User',
      :type          => 'active_record',
      :attributes    => ["id", "login", "email", "created_at", "updated_at"])
  end
end