require 'rails_helper'

RSpec.describe ShowBuilderService do
  describe 'build' do
    it 'creates show models' do
      ShowBuilderService.build.each do |show|
        expect(show).to be_a Show
      end
    end
  end
end
