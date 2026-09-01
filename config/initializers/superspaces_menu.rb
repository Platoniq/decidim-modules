# frozen_string_literal: true

# decidim-superspace registers an admin menu entry but no public one.
[:menu, :mobile_menu].each do |menu_name|
  Decidim.menu menu_name do |menu|
    menu.add_item :superspaces,
                  I18n.t("menu.superspaces", scope: "decidim", default: "Superspaces"),
                  Decidim::Superspaces::Engine.routes.url_helpers.superspaces_path,
                  position: 2.5,
                  if: Decidim::Superspaces::Superspace.where(organization: current_organization).any?,
                  active: %r{^/superspaces}
  end
end
