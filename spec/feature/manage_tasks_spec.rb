require 'rails_helper'
def visit_fill
  visit todos_path

  # Enter description in the text field
  fill_in 'todo_title', with: 'Be Batman'

end

feature 'Manage tasks', js: true do
  scenario 'add a new task' do
    visit_fill

    # Press enter (to submit the form)
    page.execute_script("$('form').submit()")

    # Expect the new task to be displayed in the list of tasks
    expect(page).to have_content('Be Batman')
  end
  scenario 'counter changes' do
visit_fill
  page.execute_script("$('form').submit()")

  # Wait for 1 second so the counter can be updated
  sleep(1)

  expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end
  scenario 'complete a task' do
    visit_fill
  page.execute_script("$('form').submit()")

  check('todo-1')

  # Wait for 1 second so the counter can be updated
  sleep(1)

  expect( page.find(:css, 'span#todo-count').text ).to eq "0"
end
  scenario 'all counters' do
  visit_fill
  page.execute_script("$('form').submit()")
  fill_in 'todo_title', with: 'Be Batman2'
  page.execute_script("$('form').submit()")
  fill_in 'todo_title', with: 'Be Batman3'
  page.execute_script("$('form').submit()")
  check('todo-1')
  check('todo-2')
  sleep(1)
  expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  expect( page.find(:css, 'span#completed-count').text ).to eq "2"
  expect( page.find(:css, 'span#total-count').text ).to eq "3"
end
scenario 'all counters and clean' do
visit_fill
page.execute_script("$('form').submit()")
fill_in 'todo_title', with: 'Be Batman2'
page.execute_script("$('form').submit()")
fill_in 'todo_title', with: 'Be Batman3'
page.execute_script("$('form').submit()")
check('todo-1')
check('todo-2')
click_link('Clean up')
sleep(1)
expect( page.find(:css, 'span#todo-count').text ).to eq "1"
expect( page.find(:css, 'span#completed-count').text ).to eq "0"
expect( page.find(:css, 'span#total-count').text ).to eq "1"
end

end
