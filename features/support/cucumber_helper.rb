module CucumberHelper
  def read_example(example)
    possible_paths = [
      File.expand_path("../examples/raml/#{example}", __FILE__),
      File.expand_path("../examples/rspec/#{example}", __FILE__),
      File.expand_path("../examples/rspec/#{example}", __FILE__)
    ]

    possible_paths.each do |path|
      return File.read(path) rescue next
    end
  end
end
