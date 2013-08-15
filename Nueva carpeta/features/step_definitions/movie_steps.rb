# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    @movie = Movie.create!(movie)
	# create(movie)
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  first_position = page.body.index(e1)
  second_position = page.body.index(e2)
  first_position.should < second_position
  # /*(e1)*(e2)*/
  # flunk "Unimplemented"
end



# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  @v = rating_list.split(',')
  # debugger
  if uncheck
    @v.each do |rating|
      uncheck("ratings_#{rating}")
      # step("When I uncheck ratings_#{rating}")
    end
  else
    @v.each do |rating|
      check("ratings_#{rating}")
      # step("When I check ratings_#{rating}")
    end
  end
  
end

Then /the director of "(.*)" should be "(.*)"/ do |f, d|
  Movie.find_by_title(f).director.should == d
end