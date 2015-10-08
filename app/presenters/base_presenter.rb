require 'representable/json'

class BasePresenter < Representable::Decorator
  include Representable::JSON
end
