module CucumberHelper
  def read_example(example)
    possible_paths = [
      File.expand_path("../examples/raml/#{example}", __FILE__),
      File.expand_path("../examples/rspec/#{example}", __FILE__)
    ]

    File.read(possible_paths.first) rescue File.read(possible_paths.last)
  end
end
