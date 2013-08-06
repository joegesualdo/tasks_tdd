require 'spec_helper'

describe "Tasks" do
  before :each do
    @task = Task.create task: 'go to bed'
  end
  describe "GET /tasks" do
    it "displays some tasks" do

      visit tasks_path
      expect(page).to have_content 'go to bed'
    end
  end

  describe "POST /tasks" do
    it "creates and new task" do
      visit tasks_path
      fill_in 'Task', :with => 'go to work'  # Looks for input or label that says task
      click_button 'Create Task'

      current_path.should == tasks_path
      page.should have_content 'go to work'
    end
    it "doens't save if input is blank" do
      visit tasks_path
      fill_in 'Task', with: ""
      expect{ click_button 'Create Task'}.to_not change(Task, :count).by(1)
    end
    it "generates notice if it doesn't create a new task if empty input" do
      visit tasks_path
      fill_in 'Task', with: ""
      click_button 'Create Task'

      expect(current_path).to eq tasks_path
      expect(page).to have_content "Task not created"
    end
  end

  describe "PUT /tasks" do
   it "edits a task" do
     visit tasks_path
     click_link "Edit"

     current_path.should == edit_task_path(@task)

     expect(find_field('Task').value).to eq 'go to bed'

     fill_in 'Task', :with => 'updated task'
     click_button 'Update Task'

     current_path.should == tasks_path

     page.should have_content 'updated task'
   end
    it "should not update empty task" do
      visit tasks_path
      click_link 'Edit'

      fill_in 'Task', with: ""
      click_button 'Update Task'
      expect(current_path).to eq edit_task_path(@task)

      expect(page).to have_content "There was an error updating your task"
    end
  end

  describe "Delete /tasks" do
    it "should delete task" do
      visit tasks_path
      find("#task_#{@task.id}").click_link 'Delete'

      expect(current_path).to eq tasks_path
      expect(page).to_not have_content "go to bed"
    end
  end

end
