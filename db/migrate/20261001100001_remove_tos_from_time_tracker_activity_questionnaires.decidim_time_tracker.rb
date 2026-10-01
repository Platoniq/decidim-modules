# frozen_string_literal: true

# This migration comes from decidim_time_tracker (originally 20260527115226)
class RemoveTosFromTimeTrackerActivityQuestionnaires < ActiveRecord::Migration[7.0]
  def up
    Decidim::Forms::Questionnaire.where(questionnaire_for_type: "Decidim::TimeTracker::TimeTracker").each do |questionnaire|
      questionnaire.update!(tos: {}) if questionnaire.tos.present?
    end
  end

  def down
    # No reverse migration needed as data might not be perfectly restorable
  end
end
