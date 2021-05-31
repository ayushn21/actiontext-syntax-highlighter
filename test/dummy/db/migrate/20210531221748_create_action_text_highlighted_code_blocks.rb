class CreateActionTextHighlightedCodeBlocks < ActiveRecord::Migration[6.1]
  def change
    create_table :action_text_highlighted_code_blocks do |t|
      t.text :content, size: :medium
      t.string :language
      t.references :rich_text, foreign_key: { to_table: :action_text_rich_texts, on_delete: :cascade }

      t.timestamps
    end
  end
end
