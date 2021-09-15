require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'after create' do
    let(:task) { FactoryBot.create(:task) }

    it 'has status "new"' do
      expect(task.status).to eq(1)
    end
  end

  context 'validates' do
    it 'has a empty title' do
      expect(FactoryBot.build(:task, title: '')).to_not be_valid
    end

    it 'has a empty description' do
      task = FactoryBot.build(:task, description: '')
      expect(task).to_not be_valid
    end
  end

  context 'the name of the person who assigned the task' do
    let(:assigned_user) { FactoryBot.create(:user) }
    let(:parent_user) { FactoryBot.create(:user, first_name: 'parent', last_name: 'last') }
    it 'a method parent_name' do
      task = FactoryBot.create(:task, user_id: assigned_user.id, parent_id: parent_user.id)
      expect(task.parent_name).to eq('parent last')
    end
  end

  context 'change status' do
    it 'send method complete!' do
      task = FactoryBot.create(:task)
      task.complete!
      expect(task.status).to eq(3)
    end
  end
end
