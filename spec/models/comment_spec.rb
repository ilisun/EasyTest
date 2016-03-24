require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation of Comment model' do
    it { should validate_presence_of :body }
  end

  describe 'аssociation of Comment model' do
    it { should belong_to(:post) }
    it { should belong_to(:user) }
  end

  describe '#ensure_can_change?' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    let(:comment) {create(:comment, post: post)}
    let(:comment_old) {create(:comment_old, post: post)}

    it 'return true if created_at < 15 minute' do
      expect(comment.ensure_can_change?).to eq true
    end

    it 'return false if created_at > 15 minute' do
      expect(comment_old.ensure_can_change?).to eq false
    end

  end
end
