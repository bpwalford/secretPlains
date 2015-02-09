require 'rails_helper'

describe DifferenceBuilder do

  before do

    class SomeCalculationObject
      attr_accessor :original, :altered
      def initialize(original, altered)
        @original = original
        @altered = altered
      end
      def plugins_intersection
      end
      def plugins_distance
      end
      def user_agent_intersection
      end
      def user_agent_distance
      end
      def browser_intersection
      end
      def browser_distance
      end
      def fonts_intersection
      end
      def original_to_altered_font_match
      end
      def altered_to_original_font_match
      end
      def cookies
      end
      def language
      end
      def ip
      end
      def screen
      end
      def country
      end
    end
    @user = create_user
    @original = create_fingerprint(user: @user)
    @altered  = create_fingerprint(user: @user)
    @calculater = SomeCalculationObject.new(@original, @altered)
  end

  context 'inserts a new difference into the database' do
    it 'saves new difference' do
      DifferenceBuilder.new(@calculater).build
      expect(Difference.all.count).to eq(1)
    end

    it 'accoiates the new difference with the prints that produced it' do
      diff = DifferenceBuilder.new(@calculater).build
      expect(diff.original).to eq(@original)
      expect(diff.altered).to eq(@altered)
    end
  end

end
