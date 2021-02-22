require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  let!(:task) { Task.create(title: Faker::Lorem.sentence, subject: Faker::Lorem.paragraphs)}  # let! 表示在 before 就先做了

  scenario "create a new task" do
    visit root_path
    fill_in "標題", with: "test title"
    fill_in "主旨", with: "test subject"
    click_button "Create Task"

    expect(page).to have_content "任務建立成功"
    expect(page).to have_content "test title"
    expect(page).to have_content "test subject"
    expect(Task.all.size).to be 2
  end

  scenario "view a task" do
    visit task_path(task)

    expect(page).to have_content(task[:title])
    expect(page).to have_content(task[:subject])
  end

  scenario "edit a task" do
    visit root_path
    click_link "編輯"
    fill_in "標題", with: "test title3"
    fill_in "主旨", with: "test subject3"
    click_button "Update Task"

    expect(page).to have_content "任務修改成功"
    expect(page).to have_content "test title3"
    expect(page).to have_content "test subject3"
  end

  scenario "delete a task" do
    visit root_path
    click_link "刪除"

    expect(page).to have_content "任務刪除成功"
    expect(page).not_to have_content "test title1"
    expect(Task.all.size).to be 0
  end
end
