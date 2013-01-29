Then /^I should be on the new project page$/ do
  current_path.should == new_project_path
end

Then /^I should be on the project show page for "(.*?)"$/ do |title|
  project = Project.find_by_name(title)
  current_path.should == project_path(project)
end