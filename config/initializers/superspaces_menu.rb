# frozen_string_literal: true

# decidim-superspace registers an admin menu entry but no public one.
{ menu: 2.5, mobile_menu: 2.5, home_content_block_menu: 40 }.each do |menu_name, position|
  Decidim.menu menu_name do |menu|
    menu.add_item :superspaces,
                  I18n.t("menu.superspaces", scope: "decidim", default: "Superspaces"),
                  Decidim::Superspaces::Engine.routes.url_helpers.superspaces_path,
                  position:,
                  if: Decidim::Superspaces::Superspace.where(organization: current_organization).any?,
                  active: %r{^/superspaces}
  end
end
