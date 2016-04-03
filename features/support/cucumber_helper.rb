module CucumberHelper
  def read_example(example)
    File.read(File.expand_path("../examples/#{example}", __FILE__))
  end
end
