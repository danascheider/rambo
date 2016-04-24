Dir["#{File.dirname(__FILE__)}/rspec/**/*"].each {|file| require file if /\.rb\z/.match file }
