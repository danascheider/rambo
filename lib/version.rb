module Rambo
  MAJOR = '0'
  MINOR = '3'
  PATCH = '0'

  def self.version
    [Rambo::MAJOR, Rambo::MINOR, Rambo::PATCH].join('.')
  end
end
