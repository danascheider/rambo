Given(/^a file named "([^"]*)" like "([^"]*)"$/) do |file, example|
  text = File.read(File.expand_path("../../support/examples/#{example}", __FILE__))
  steps %Q{
    Given a file named "#{file}" with:
      """
      #{text}
      """
  }
end

Then(/^the file "([^"]*)" should be like "([^"]*)"$/) do |file, example|
  text = File.read(File.expand_path("../../support/examples/#{example}", __FILE__))
  steps %Q{
    the file "#{file}" should contain:
      """
      #{text}
      """
  }
end
