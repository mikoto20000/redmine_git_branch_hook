require 'redmine'
require 'git_adapter_patch'

Redmine::Plugin.register :redmine_git_branch_hook do
  name 'Redmine Git Branch Hook plugin'
  author 'Takashi Okamoto'
  description 'Relate the commit to the issue from git branch name'
  version '0.2.1'
  
  settings :default => {
    'merge_branch' => 'master',
    'close_by_merge' => '1'
  }, :partial =>'settings/redmine_git_branch_hook_settings'
end
