require 'redmine/scm/adapters/git_adapter'

module GitBranchHookPlugin
  module GitAdapterPatch
    def self.included(base) # :nodoc:
      base.send(:include, InstanceMethods)
      base.class_eval do
        alias_method_chain :revisions, :git_branch_hook
      end
    end

    module InstanceMethods
      def extract_branch(commit)
        branches = nil
        latest_line = ''
        cmd_brargs = %w|branch --contains|
        cmd_brargs << commit
        if Redmine::Scm::Adapters::GitAdapter.private_method_defined?(:git_cmd)
          git_cmd(cmd_brargs) do |io|
            io.each_line do |line|
              latest_line = line
              if (line =~ /\* ([^#]*#([0-9]+).*)$/) && ($2 != nil)
                return $1,$2
              end
            end
          end
        else
          scm_cmd *cmd_brargs do |io|
            io.each_line do |line|
              latest_line = line
              if (line =~ /\* ([^#]*#([0-9]+).*)$/) && ($2 != nil)
                return $1,$2
              end
            end
          end
        end
        if (latest_line =~ /  ([^#]*#([0-9]+).*)$/) && ($2 != nil)
          return $1,$2
        end
        [nil,nil]
      end

      def revisions_with_git_branch_hook(path, identifier_from, identifier_to, options={})
        revs = revisions_without_git_branch_hook(path, identifier_from, identifier_to, options)
        revs.each do |rev|
          branch,issue_id = extract_branch(rev.identifier)

          if branch
            issue_pattern = Regexp.new('#' + issue_id + '([^\d]|$)')
            if (rev.message =~ issue_pattern) == nil
              logger.info(rev.identifier + " : RELATE #" + issue_id + " by Branch " + branch + "\n")
              rev.message.insert(0, '(refs #' << issue_id << ")")
            end
          end
          if rev.message =~ /Merge branch '([^']+)'/
            branch = $1
            issue_pattern = Regexp.new('(#[\d+])')
            if branch =~ issue_pattern
              logger.info(rev.identifier + " : CLOSE " + $1 + " by Merge " + branch + "\n")
              rev.message << '(closes ' << $1 << ')'
            end
          end
          if block_given?
            yield rev
          end
        end
        revs
      end

    end
    def logger
      Rails.logger
    end
  end
end

Redmine::Scm::Adapters::GitAdapter.send(:include, GitBranchHookPlugin::GitAdapterPatch)
