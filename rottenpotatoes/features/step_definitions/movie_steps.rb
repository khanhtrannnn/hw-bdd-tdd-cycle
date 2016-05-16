# Add a declarative step here for populating the DB with movies.

num = 0
Given /the following movies exist/ do |movies_table|
  num = 0
  movies_table.hashes.each {|i|
    Movie.create(i)
    num += 1
  }
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then(/^I should see "(.*?)" before "(.*?)"$/)  do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1)).to be < (page.body.index(e2)) 
end

Then /I should see all of the movies/ do
  page.should have_css("table#movies tbody tr",:count => num.to_i)
end

Then /I should not see all of the movies/ do
  page.should have_no_css("table#movies tbody tr")
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.delete!("\"")
  if uncheck.nil?
    rating_list.split(',').each {|i|
      check("ratings["+i.strip+"]")
    }
  else
    rating_list.split(',').each {|i|
      uncheck("ratings["+i.strip+"]")
    }
  end
end

#Add new scenario
Then /the director of (.+) should be (.+)$/ do |e1, e2|
  expect(Movie.where(title: e1, director: e2)).not_to eq(nil)
end

