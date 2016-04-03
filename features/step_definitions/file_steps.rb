Given(/^a file named "([^"]*)" like "([^"]*)"$/) do |file, example|
  text = read_example(example)
  steps %Q{
    Given a file named "#{file}" with:
      """
      #{text}
      """
  }
end

Given(/^a spec_helper\.rb file that requires rack\/test but not JSON$/) do
  step 'a file named "spec/spec_helper.rb" like "spec_helper_only_rack_test.rb.ex"'
end

Given(/^a spec_helper\.rb file that requires JSON but not rack\/test$/) do
  step 'a file named "spec/spec_helper.rb" like "spec_helper_only_json.rb.ex"'
end

Given(/a spec_helper.rb file that requires both JSON and rack\/test$/) do
  step 'a file named "spec/spec_helper.rb" like "good_spec_helper.rb.ex"'
end

Then(/^the file "([^"]*)" should be like "([^"]*)"$/) do |file, example|
  text = read_example(example)
  steps %Q{
    the file "#{file}" should contain:
      """
      #{text}
      """
  }
end
