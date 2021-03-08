require 'rails_helper'

RSpec.describe Task, type: :feature do
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

  describe "had a task already" do
    let!(:task) { FactoryBot.create(:task) }  # let! 表示在 before 就先做了

    it "view a task" do
      visit task_path(task)
  
      expect(page).to have_content(task[:title])
      expect(page).to have_content(task[:subject])
    end

    it "edit a task" do
      visit root_path
      click_link I18n.t('tasks.edit')
      fill_in I18n.t('tasks.title'), with: "test title3"
      fill_in I18n.t('tasks.subject'), with: "test subject3"
      find('input[name="commit"]').click
  
      expect(page).to have_content("#{I18n.t('tasks.update.notice')}")
      expect(page).to have_content "test title3"
      expect(page).to have_content "test subject3"
    end

    it "delete a task" do
      visit root_path
      
      expect{click_link I18n.t('tasks.delete')}.to change{Task.all.size}.by(-1)
      expect(page).to have_content("#{I18n.t('tasks.destroy.notice')}")
      expect(page).not_to have_content(task[:title])
      expect(page).not_to have_content(task[:subject])
    end
  end

  describe "order by created time" do
    before do
      1.upto(3) do |i|
        Task.create(title: "title #{i}", subject: "subject #{i}")
      end
      visit root_path
    end

    it "order by asc/desc" do
      expect(page).to have_content(/title 1.*title 2.*title 3/)

      click_link I18n.t('tasks.order_by_desc')
      expect(page).to have_content(/title 3.*title 2.*title 1/)

      click_link I18n.t('tasks.order_by_asc')
      expect(page).to have_content(/title 1.*title 2.*title 3/)
    end
  end
end
