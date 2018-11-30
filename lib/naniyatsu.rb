require 'naniyatsu/version'
require 'active_support/core_ext/string/inflections'

module Naniyatsu
  attr_reader :root_naniyatsu_class

  def self.extended(klass)
    klass.instance_variable_set :@root_naniyatsu_class, klass
    klass.send(:define_method, klass.naniyatsu_method_name(klass), -> { true })
  end

  def inherited(klass)
    root_naniyatsu_class = klass.superclass.root_naniyatsu_class
    klass.instance_variable_set :@root_naniyatsu_class, root_naniyatsu_class
    klass.send(:define_method, naniyatsu_method_name(klass), -> { true })
    root_naniyatsu_class.send(:define_method, naniyatsu_method_name(klass), -> { false })
    super
  end

  def naniyatsu_method_name(klass)
    klass.to_s.underscore + '?'
  end
end
