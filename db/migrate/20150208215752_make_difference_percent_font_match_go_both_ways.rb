class MakeDifferencePercentFontMatchGoBothWays < ActiveRecord::Migration
  def change
    rename_column :differences, :percent_font_match, :original_to_altered_font_match
    add_column :differences, :altered_to_original_font_match, :decimal, precision: 3, scale: 2
  end
end
