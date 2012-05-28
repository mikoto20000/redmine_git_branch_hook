require 'redmine'
require 'git_adapter_patch'

begin
  require 'dispatcher'
  def dispatch(plugin, &block)
    Dispatcher.to_prepare(plugin, &block)
  end
rescue LoadError # Rails 3
  def dispatch(plugin, &block)
    Rails.configuration.to_prepare(&block)
  end
end

Redmine::Plugin.register :redmine_git_branch_hook do
  name 'Redmine Git Branch Hook plugin'
  author 'Takashi Okamoto'
  description 'Relate the commit to the issue from git branch name'
  version '0.1.2'
end
