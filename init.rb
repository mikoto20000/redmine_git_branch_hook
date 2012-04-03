require 'redmine'
require 'dispatcher'
require 'git_adapter_patch'
require 'cleanup_tmp'

# require_dependency 'attachment_hook'

Dispatcher.to_prepare do
end

Redmine::Plugin.register :redmine_git_branch_hook do
  name 'Redmine Git Branch Hook plugin'
  author 'Takashi Okamoto'
  description 'Attach several screenshots from clipboard directly to a Redmine issue'
  version '0.0.1'
end
