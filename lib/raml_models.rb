Dir["#{File.dirname(__FILE__)}/raml_models/**/*"].each {|file| require file if /\.rb\z/.match file }
