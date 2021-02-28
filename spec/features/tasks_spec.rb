require 'rails_helper'

RSpec.describe Task, type: :feature do
  let!(:task) { Task.create(title: Faker::Lorem.sentence, subject: Faker::Lorem.paragraphs)}  # let! 表示在 before 就先做了

  describe "create a new task" do
    it "with title and subject" do
      visit root_path
      fill_in I18n.t('tasks.title'), with: "test title"
      fill_in I18n.t('tasks.subject'), with: "test subject"
      
      expect{find('input[name="commit"]').click}.to change{Task.all.size}.by(1)
      expect(page).to have_content("#{I18n.t('tasks.create.notice')}")
      expect(page).to have_content "test title"
      expect(page).to have_content "test subject"
    end

    it "without title and subject" do
      visit root_path
      fill_in I18n.t('tasks.title'), with: ""
      fill_in I18n.t('tasks.subject'), with: ""
      find('input[name="commit"]').click

      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.subject')} #{I18n.t('activerecord.errors.models.task.attributes.subject.blank')}")
    end

    it "without title " do
      visit root_path
      fill_in I18n.t('tasks.title'), with: ""
      fill_in I18n.t('tasks.subject'), with: "test subject"
      find('input[name="commit"]').click

      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
    end

    it "without title and subject" do
      visit root_path
      fill_in I18n.t('tasks.title'), with: "test title"
      fill_in I18n.t('tasks.subject'), with: ""
      find('input[name="commit"]').click

      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.subject')} #{I18n.t('activerecord.errors.models.task.attributes.subject.blank')}")
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
      click_link I18n.t('tasks.edit')
      fill_in I18n.t('tasks.title'), with: "test title3"
      fill_in I18n.t('tasks.subject'), with: "test subject3"
      find('input[name="commit"]').click
  
      expect(page).to have_content("#{I18n.t('tasks.update.notice')}")
      expect(page).to have_content "test title3"
      expect(page).to have_content "test subject3"
    end
  end

  describe "delete a task" do
    it do
      visit root_path
      
      expect{click_link I18n.t('tasks.delete')}.to change{Task.all.size}.by(-1)
      expect(page).to have_content("#{I18n.t('tasks.destroy.notice')}")
      expect(page).not_to have_content(task[:title])
      expect(page).not_to have_content(task[:subject])
    end
  end
end
