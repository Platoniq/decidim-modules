# frozen_string_literal: true

# This migration comes from decidim_ub (originally 20240709154301)
class AddUbRolesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_users, :ub_roles, :jsonb, default: []
  end
end
