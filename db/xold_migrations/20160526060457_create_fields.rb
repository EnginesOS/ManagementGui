class CreateFields < ActiveRecord::Migration[5.0]
  def change
    create_table :fields do |t|
      t.integer :field_consumer_id
      t.string  :field_consumer_type
      t.string  :method_name
      t.string  :value
      t.string  :label
      t.string  :as
      t.string  :title
      t.boolean :horizontal
      t.boolean :compact
      t.integer :left
      t.integer :width
      t.integer :right
      t.text    :collection
      t.string  :tooltip
      t.string  :hint
      t.string  :placeholder
      t.text    :comment
      t.string  :validate_regex
      t.string  :validate_invalid_message
      t.string  :depend_on_input
      t.string  :depend_on_regex
      t.string  :depend_on_value
      t.string  :depend_on_property
      t.string  :depend_on_display
      t.boolean :required
      t.boolean :read_only
    end
  end
end
