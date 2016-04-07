class AddWorkflowToLockets < ActiveRecord::Migration
  def change
    add_column :lockets, :workflow_state, :string
  end
end
