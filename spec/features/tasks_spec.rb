require 'rails_helper'

RSpec.describe Task, type: :feature do
  let(:password) { Faker::Internet.password }
  let!(:user) { FactoryBot.create(:user, password: password) }

  before do
    visit sign_in_users_path
    fill_in I18n.t('users.email'), with: user.email
    fill_in I18n.t('users.password'), with: password
    find('input[type="submit"]').click
  end
  
  describe "create a new task" do
    before do
      visit new_task_path
    end

    it "with title and subject" do
      # byebug
      fill_in I18n.t('tasks.title'), with: "test title"
      fill_in I18n.t('tasks.subject'), with: "test subject"
      fill_in I18n.t('tasks.start_time'), with: "2021/Mar/08 22:29:00"
      fill_in I18n.t('tasks.end_time'), with: "2021/Mar/23 22:35:00"
      
      expect{find('input[type="submit"]').click}.to change{Task.all.size}.by(1)
      expect(page).to have_content("#{I18n.t('tasks.create.notice')}")
      expect(page).to have_content "test title"
      expect(page).to have_content "test subject"
      expect(page).to have_content "2021 / Mar / 08 22:29:00"
      expect(page).to have_content "2021 / Mar / 23 22:35:00"
    end

    it "without title and subject" do
      fill_in I18n.t('tasks.title'), with: ""
      fill_in I18n.t('tasks.subject'), with: ""
      find('input[type="submit"]').click

      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.subject')} #{I18n.t('activerecord.errors.models.task.attributes.subject.blank')}")
    end

    it "without title " do
      fill_in I18n.t('tasks.title'), with: ""
      fill_in I18n.t('tasks.subject'), with: "test subject"
      find('input[type="submit"]').click

      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.title')} #{I18n.t('activerecord.errors.models.task.attributes.title.blank')}")
    end

    it "without subject" do
      fill_in I18n.t('tasks.title'), with: "test title"
      fill_in I18n.t('tasks.subject'), with: ""
      find('input[type="submit"]').click

      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.subject')} #{I18n.t('activerecord.errors.models.task.attributes.subject.blank')}")
    end

    it "without start time and end time" do
      fill_in I18n.t('tasks.title'), with: "test title"
      fill_in I18n.t('tasks.subject'), with: "test subject"
      fill_in I18n.t('tasks.start_time'), with: ""
      fill_in I18n.t('tasks.end_time'), with: ""
      find('input[type="submit"]').click

      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.start_time')} #{I18n.t('activerecord.errors.models.task.attributes.start_time.blank')}")
      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.end_time')} #{I18n.t('activerecord.errors.models.task.attributes.end_time.blank')}")
    end

    it "start time after end time" do
      fill_in I18n.t('tasks.title'), with: "test title"
      fill_in I18n.t('tasks.subject'), with: "test subject"
      fill_in I18n.t('tasks.start_time'), with: "2021/Mar/23 22:35:00"
      fill_in I18n.t('tasks.end_time'), with: "2021/Mar/08 22:29:00"
      find('input[type="submit"]').click

      expect(page).to have_content("#{I18n.t('activerecord.attributes.task.end_time')} #{I18n.t('activerecord.errors.models.task.attributes.end_time_after_start_time')}")
    end
  end

  describe "had a task already" do
    let!(:task) { FactoryBot.create(:task, user_id: user.id) }  # let! 表示在 before 就先做了

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
      find('input[type="submit"]').click
  
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

    it "change task state" do
      visit root_path
      
      expect(page).to have_content I18n.t('tasks.task_state.pending')
      click_link I18n.t('tasks.start')
      expect(page).to have_content I18n.t('tasks.task_state.processing')
      click_link I18n.t('tasks.complete')
      expect(page).to have_content I18n.t('tasks.task_state.completed')
    end

    it "search by state" do
      visit root_path
      click_button I18n.t('tasks.search_by_state')
      click_link I18n.t('tasks.task_state.pending')
      expect(page).to have_content(task[:title])
      expect(page).to have_content(task[:subject])
      expect(page).to have_content I18n.t('tasks.task_state.pending')

      click_link I18n.t('tasks.start')
      click_on I18n.t('tasks.search_by_state')
      click_on I18n.t('tasks.task_state.processing')
      expect(page).to have_content(task[:title])
      expect(page).to have_content(task[:subject])
      expect(page).to have_content I18n.t('tasks.task_state.processing')

      click_link I18n.t('tasks.complete')
      click_on I18n.t('tasks.search_by_state')
      click_on I18n.t('tasks.task_state.completed')
      expect(page).to have_content(task[:title])
      expect(page).to have_content(task[:subject])
      expect(page).to have_content I18n.t('tasks.task_state.completed')
    end

    it "search by title" do
      visit root_path

      find('input[name="keyword"]').set(task[:title])
      click_button I18n.t('tasks.search')

      expect(page).to have_content(task[:title])
      expect(page).to have_content(task[:subject])
    end

    it "search by subject" do
      visit root_path

      find('input[name="keyword"]').set(task[:subject])
      click_button I18n.t('tasks.search')

      expect(page).to have_content(task[:title])
      expect(page).to have_content(task[:subject])
    end
  end

  describe "sort" do
    before do
      0.upto(2) do |i|
        Task.create(title: "title #{i}", subject: "subject #{i}",priority: "#{i}".to_f, start_time: "2021/Mar/1#{i} 22:29:00", end_time: "2021/Mar/2#{i} 22:35:00", user_id: user.id)
      end
      visit root_path
    end

    it "sort by created_at" do
      expect(page).to have_content(/title 2.*title 1.*title 0/)
      
      click_link I18n.t('tasks.sort_by_asc')
      expect(page).to have_content(/title 0.*title 1.*title 2/)
      
      click_link I18n.t('tasks.sort_by_desc')
      expect(page).to have_content(/title 2.*title 1.*title 0/)
    end

    it "sort by end_time" do
      expect(page).to have_content(/title 2.*title 1.*title 0/)
      
      click_link I18n.t('tasks.sort_by_endtime_asc')
      expect(page).to have_content(/title 0.*title 1.*title 2/)

      click_link I18n.t('tasks.sort_by_endtime_desc')
      expect(page).to have_content(/title 2.*title 1.*title 0/)
    end

    it "sort by priority" do
      expect(page).to have_content(/title 2.*title 1.*title 0/)

      click_link I18n.t('tasks.sort_by_priority_asc')
      expect(page).to have_content(/title 0.*title 1.*title 2/)

      click_link I18n.t('tasks.sort_by_priority_desc')
      expect(page).to have_content(/title 2.*title 1.*title 0/)
    end
  end  
end
