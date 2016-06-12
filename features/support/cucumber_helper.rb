module CucumberHelper
  def read_example(example)
    possible_paths = [
      File.join(CUCUMBER_DIR_ROOT, "examples/raml/#{example}"),
      File.join(CUCUMBER_DIR_ROOT, "examples/rspec/#{example}"),
      File.join(CUCUMBER_DIR_ROOT, "examples/rspec/#{example}"),
      File.join(CUCUMBER_DIR_ROOT, "examples/yaml/#{example}")
    ]

    possible_paths.each do |path|
      return File.read(path) rescue next
    end
  end
end
