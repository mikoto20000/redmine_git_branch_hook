Git Branch Hook Plugin for Redmine
==================================

Add issue related revision by branch name. If the branch name include 
**#xxxx**, this plugin relate the commit to issue **xxxx**. For example,
commits of following branches is related to issue **12345**.

* #12345
* hotfix/#12345
* hotfix/#12345/some-module
* hotfix/#12345/fix-somedescription
* fix-#12345

Close issue by Merge 
--------------------

Git Brnach Hook Plugin can close the ticket automatically
by Merge branch. For example, if you work on hotfix/#12345 branch.
When merge this branch with --no-ff option to master
(or something else),

```
$ git merge --no-ff hotfix/#12345
```

This command add commit log :

```
commit 6d30f57bbf423404fbe8a2a497039ead2e90bbbf
Merge: 98dd73e 59007a4
Author: XXXXX
Date:   XXX

    Merge branch 'hotfix/#12345'

```

Git Branch Hook Plugin add string "cloesed #12345"
to end of commit message. 

```
    Merge branch 'hotfix/#12345' (closes #12345)
```

If you enabled Remine's issue auto close option by the key 
word in the commit message, issue #12345 will be closed.

If you don't want close the issue by merge, disabled Redmine's
issue auto close function.

### NOTICE
When merge branch on fast-forward, Merge message is not commited
and auto close function does not work correctly. To use close by
merge function, ensure execute 'git merge' with **'--no-ff'** 
option.

Credits
=======

* ALMinium Project
 * https://github.com/alminium/alminium

