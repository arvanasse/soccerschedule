module JsNamedRoutes
  class Config
    def self.scope
      @@scope ||= ""
    end
  
    def self.scope=(scope)
      @@scope = scope
    end
  end
end
