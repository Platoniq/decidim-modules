# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = "0.30.2"

gem "decidim", DECIDIM_VERSION
gem "decidim-conferences", DECIDIM_VERSION
gem "decidim-design", DECIDIM_VERSION
# decidim-elections has no 0.30 release; it returns in 0.31
# gem "decidim-elections", DECIDIM_VERSION
gem "decidim-initiatives", DECIDIM_VERSION
gem "decidim-templates", DECIDIM_VERSION
# release/0.30-stable (0.13.2) breaks assets:precompile on a .deface override, and main is
# now 0.14.x which requires decidim-core >= 0.31. Pinned to the last commit that builds.
gem "decidim-decidim_awesome", git: "https://github.com/decidim-ice/decidim-module-decidim_awesome", ref: "60da172ca1ef7f278eaa2600aecdda8ac8369dcf"
gem "decidim-superspaces", git: "https://github.com/Platoniq/decidim-superspace", branch: "release/0.30-stable"
gem "decidim-time_tracker", git: "https://github.com/Platoniq/decidim-module-time_tracker", branch: "release/0.30-stable"
gem "decidim-alternative_landing", git: "https://github.com/Platoniq/decidim-module-alternative_landing", branch: "release/0.30-stable"
# decidim-comparative_stats pins graphlient < 0.6, which needs faraday < 1.0 and conflicts with Decidim 0.30
# gem "decidim-comparative_stats", git: "https://github.com/Platoniq/decidim-module-comparative_stats", branch: "release/0.30-stable"
gem "decidim-direct_verifications", git: "https://github.com/Platoniq/decidim-verifications-direct_verifications", branch: "release/0.30-stable"
gem "decidim-navigation_maps", git: "https://github.com/Platoniq/decidim-module-navigation_maps", branch: "release/0.30-stable"
gem "decidim-notify", git: "https://github.com/Platoniq/decidim-module-notify", branch: "release/0.30-stable"
gem "decidim-social_crowdfunding", git: "https://github.com/Platoniq/decidim-module-social_crowdfunding", branch: "release/0.30-stable"
gem "decidim-term_customizer", git: "https://github.com/openpoke/decidim-module-term_customizer", branch: "release/0.30-stable"
gem "decidim-ub", git: "https://github.com/Platoniq/decidim-module-ub", branch: "release/0.30-stable"

gem "bootsnap", "~> 1.3"

gem "puma", ">= 6.3.1"
gem "rack-attack", "~> 6.7"

gem "wicked_pdf", "~> 2.1"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "brakeman", "~> 5.4"
  gem "decidim-dev", DECIDIM_VERSION
  gem "net-imap", "~> 0.2.3"
  gem "net-pop", "~> 0.1.1"
  gem "net-smtp", "~> 0.5.0"
end

group :development do
  gem "letter_opener_web", "~> 2.0"
  gem "listen", "~> 3.1"
  gem "web-console", "~> 4.2"
end

group :production do
  gem "aws-sdk-s3", require: false
  gem "sidekiq"
end

gem "decidim-ai", "~> 0.30.2"
