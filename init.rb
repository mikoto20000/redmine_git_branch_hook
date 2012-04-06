require 'redmine'
require 'dispatcher'
require 'git_adapter_patch'

Dispatcher.to_prepare do
end

Redmine::Plugin.register :redmine_git_branch_hook do
  name 'Redmine Git Branch Hook plugin'
  author 'Takashi Okamoto'
  description 'Relate the commit to the issue from git branch name'
  version '0.1.1'
end
