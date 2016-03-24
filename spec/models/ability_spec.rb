require 'rails_helper'

RSpec.describe Ability, type: :model do

  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Post }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create :user }
    let(:other) { create :user }
    let(:post) { create(:post, user: user) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Post }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, create(:post, user: user), user: user }
    it { should_not be_able_to :update, create(:post, user: other), user: user }
    it { should be_able_to :update, create(:comment, user: user), user: user }
    it { should_not be_able_to :update, create(:comment, user: other), user: user }

    it { should be_able_to :destroy, create(:post, user: user), user: user }
    it { should_not be_able_to :destroy, create(:post, user: other), user: user }
    it { should be_able_to :destroy, create(:comment, user: user), user: user }
    it { should_not be_able_to :destroy, create(:comment, user: other), user: user }
  end

end