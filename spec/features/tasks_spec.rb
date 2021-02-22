require 'rails_helper'

RSpec.feature "Tasks", type: :feature do
  # let(:title) { Faker::Lorem.sentence }
  # let(:subject) { Faker::Lorem.paragraphs }
  before(:all) do
    @task = Task.create(title: 'test title', subject: 'test subject')
  end

  scenario "create a new task" do
    visit root_path
    fill_in "標題", with: "test title2"
    fill_in "主旨", with: "test subject2"
    click_button "Create Task"

    expect(page).to have_content "任務建立成功"
    expect(page).to have_content "test title2"
    expect(page).to have_content "test subject2"
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
  end
end
