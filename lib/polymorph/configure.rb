module Polymorph
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= OpenStruct.new
  end

  def self.configure
    yield configuration
  end
end
