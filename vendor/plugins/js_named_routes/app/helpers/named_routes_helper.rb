module NamedRoutesHelper
  def function_header(name, params)
    if use_scope?
      "#{name}: function(#{params}) {"
    else
      "function #{name}(#{params}) {"
    end
  end

  def end_function
    use_scope? ? "," : ";"
  end

  def use_scope?
    !JsNamedRoutes::Config::scope.blank?
  end

  def scope
    JsNamedRoutes::Config::scope
  end

  def scoped
    use_scope? ? "#{scope}." : ""
  end

  def host
    use_scope? ? "host" : "js_named_routes_server_host"
  end
end
