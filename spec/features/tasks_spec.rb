require 'rails_helper'

RSpec.describe Task, type: :feature do
  let!(:task) { Task.create(title: Faker::Lorem.sentence, subject: Faker::Lorem.paragraphs)}  # let! 表示在 before 就先做了

  describe "create a new task" do
    it "with title and subject" do
      visit root_path
      fill_in "標題", with: "test title"
      fill_in "主旨", with: "test subject"
      
      expect{click_button "Create Task"}.to change{Task.all.size}.by(1)
      expect(page).to have_content "任務建立成功"
      expect(page).to have_content "test title"
      expect(page).to have_content "test subject"
    end

    it "without title and subject" do
      visit root_path
      fill_in "標題", with: ""
      fill_in "主旨", with: ""
      click_button "Create Task"

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Subject can't be blank"
    end

    it "without title " do
      visit root_path
      fill_in "標題", with: ""
      fill_in "主旨", with: "test subject"
      click_button "Create Task"

      expect(page).to have_content "Title can't be blank"
    end

    it "without title and subject" do
      visit root_path
      fill_in "標題", with: "test title"
      fill_in "主旨", with: ""
      click_button "Create Task"

      expect(page).to have_content "Subject can't be blank"
    end
  end

  describe "view a task" do
    it do
      visit task_path(task)
  
      expect(page).to have_content(task[:title])
      expect(page).to have_content(task[:subject])
    end
  end

  describe "edit a task" do
    it do
      visit root_path
      click_link "編輯"
      fill_in "標題", with: "test title3"
      fill_in "主旨", with: "test subject3"
      click_button "Update Task"
  
      expect(page).to have_content "任務修改成功"
      expect(page).to have_content "test title3"
      expect(page).to have_content "test subject3"
    end
  end

  describe "delete a task" do
    it do
      visit root_path
      
      expect{click_link "刪除"}.to change{Task.all.size}.by(-1)
      expect(page).to have_content "任務刪除成功"
      expect(page).not_to have_content(task[:title])
      expect(page).not_to have_content(task[:subject])
    end
  end
end
