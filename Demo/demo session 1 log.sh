einsteinium$ cd /tmp
einsteinium$ mkdir demo
einsteinium$ cd demo
einsteinium$ git clone git@github.com:Macaulay2/Workshop-2016-Warwick.git
Cloning into 'Workshop-2016-Warwick'...
remote: Counting objects: 32, done.        
remote: Compressing objects:   4% (1/22)           
Receiving objects:   3% (1/32)   
Receiving objects:  37% (12/32)   
Resolving deltas:   0% (0/4)   
Checking connectivity... done.
einsteinium$ ls
Workshop-2016-Warwick
einsteinium$ cd Workshop-2016-Warwick/
einsteinium$ ls
InformativePDFs  README.md  RandomIdeals
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")
einsteinium$ git diff
diff --git a/README.md b/README.md
index 42c9f5f..055b0c6 100644
--- a/README.md
+++ b/README.md
@@ -10,3 +10,5 @@ Collaboration area for the Macaulay2 workshop at the University of Warwick, May
 - The other package, ResidualIntersection.m2, contains tests for many of the special properties of Cohen-Macaulay ideals that have been used in the theory of residual intersections; things such as "strongly Cohen-Macaulay" and "sliding depth" and "G_d"
 
 - Eisenbud hopes to use these two packages together to construct interesting new families of square-free monomial ideals for which these strong Cohen-Macaulay properties hold, and to try in this way to understand them combinatorially.
+
+- Dan Grayson adds something to this file
einsteinium$ git add README.md 
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	modified:   README.md

einsteinium$ git commit
Waiting for Emacs...
[master 54a58c5] Dan changed a file
 1 file changed, 2 insertions(+)
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
nothing to commit, working directory clean
einsteinium$ git push
Counting objects: 3, done.
Delta compression using up to 8 threads.
Compressing objects:  33% (1/3)   
Writing objects:  33% (1/3)   
Total 3 (delta 1), reused 0 (delta 0)
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
   e9dbcd8..54a58c5  master -> master
einsteinium$ mkdir Demo
einsteinium$ ls
Demo  InformativePDFs  README.md  RandomIdeals
einsteinium$ cd Demo
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	./

nothing added to commit but untracked files present (use "git add" to track)
einsteinium$ ls
README
einsteinium$ git add README 
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   README

einsteinium$ git commit
Waiting for Emacs...
[master 4a70a65] add a file
 1 file changed, 1 insertion(+)
 create mode 100644 Demo/README
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
nothing to commit, working directory clean
einsteinium$ git log 
commit 4a70a65f41e01a307dd99cafe5ed12411a148da5
Author: Daniel R. Grayson <dan@math.uiuc.edu>
Date:   Mon May 23 09:20:58 2016 +0100

    add a file

commit 54a58c5bc9abb88b141a3d9b9bc47d4c07e1ba5a
Author: Daniel R. Grayson <dan@math.uiuc.edu>
Date:   Mon May 23 09:18:50 2016 +0100

    Dan changed a file

commit e9dbcd88c03a4ea9a40b7031854b417468a2d9b8
Author: Thomas Kahle <thomas.kahle@jpberlin.de>
Date:   Sun May 22 12:59:01 2016 +0200

    Bring back intro to packages.

commit ef3abcc55fc343143413cf2972971de322958c02
Author: eisenbud <eisenbud@users.noreply.github.com>
Date:   Thu May 19 20:02:22 2016 -0700

    Create README.md

commit aa8e1ac235c206f83796454d7e51e00d2aea34b4
Author: David Eisenbud <de@msri.org>
Date:   Thu May 19 19:47:07 2016 -0700

    set up a directory for Warwick with materials created in Utah

commit d27b547692ec6e5344e3e1560208a430d713d647
Author: Thomas Kahle <thomas.kahle@jpberlin.de>
Date:   Tue Apr 12 19:15:13 2016 +0200

    Update README.md

commit 98f7887ed725afcdcadcdab282163dd68d5897aa
Author: Thomas Kahle <thomas.kahle@jpberlin.de>
Date:   Tue Apr 12 18:59:35 2016 +0200

    cleanup

commit 968fc97ac9380af43348d8ec968d452ee37b5891
Author: Thomas Kahle <thomas.kahle@jpberlin.de>
Date:   Tue Apr 12 18:59:17 2016 +0200

    add pdf about packages

commit 3f00093e7c8345a8f8cb28ab67385b82fffcd36e
Author: Thomas Kahle <thomas.kahle@jpberlin.de>
Date:   Tue Apr 12 17:55:27 2016 +0200

    Add a category

commit 6baa74bc1ac4f33ecf1aacf56d7802dab9d0075c
Author: Thomas Kahle <thomas.kahle@jpberlin.de>
Date:   Tue Apr 12 11:00:32 2016 +0200

    Welcome

commit 0d42aa996828517a8e65f17566b6e4a0ba4d4ae9
Author: Daniel R. Grayson <dan@math.uiuc.edu>
Date:   Tue Mar 29 21:26:07 2016 -0500

    Initial commit
einsteinium$ git push
Counting objects: 4, done.
Delta compression using up to 8 threads.
Compressing objects:  50% (1/2)   
Writing objects:  25% (1/4)   
Total 4 (delta 1), reused 0 (delta 0)
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
   54a58c5..4a70a65  master -> master
einsteinium$ git pull
Already up-to-date.
einsteinium$ pwd
/tmp/demo/Workshop-2016-Warwick/Demo
einsteinium$ cd ..
einsteinium$ pwd
/tmp/demo/Workshop-2016-Warwick
einsteinium$ cd ..
einsteinium$ ls
Workshop-2016-Warwick
einsteinium$ git clone git@github.com:Macaulay2/Workshop-2016-Warwick.git Workshop-2016-Warwick-2
Cloning into 'Workshop-2016-Warwick-2'...
remote: Counting objects: 43, done.        
remote: Compressing objects:   3% (1/29)           
Receiving objects:   2% (1/43)   
Receiving objects:  51% (22/43)   
Resolving deltas:   0% (0/7)   
Checking connectivity... done.
einsteinium$ ls
Workshop-2016-Warwick  Workshop-2016-Warwick-2
einsteinium$ cd Workshop-2016-Warwick-2/
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	Demo/#README#
	Demo/.#README

nothing added to commit but untracked files present (use "git add" to track)
einsteinium$ cd Workshop-2016-Warwick-2/
bash: cd: Workshop-2016-Warwick-2/: No such file or directory
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   Demo/README

no changes added to commit (use "git add" and/or "git commit -a")
einsteinium$ git diff
diff --git a/Demo/README b/Demo/README
index c5e0d46..59bf965 100644
--- a/Demo/README
+++ b/Demo/README
@@ -3,3 +3,5 @@ This file is in a directory that Dan made.
 I made a change.
 
 Add a line.
+
+In emacs I used C-x v v to 
\ No newline at end of file
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 2 commits.
  (use "git push" to publish your local commits)
nothing to commit, working directory clean
einsteinium$ git push
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'git@github.com:Macaulay2/Workshop-2016-Warwick.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
einsteinium$ git pull
remote: Counting objects: 6, done.        
remote: Compressing objects:  50% (1/2)           
remote: Total 6 (delta 3), reused 6 (delta 3), pack-reused 0        
Unpacking objects:  16% (1/6)   
From github.com:Macaulay2/Workshop-2016-Warwick
   357baa6..d7d033d  master     -> origin/master
Waiting for Emacs...
Merge made by the 'recursive' strategy.
 RandomIdeals/RandomIdeal.m2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
einsteinium$ pushd /tmp
/tmp /tmp/demo/Workshop-2016-Warwick-2
einsteinium$ git status
fatal: Not a git repository (or any of the parent directories): .git
einsteinium$ popd
/tmp/demo/Workshop-2016-Warwick-2
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 3 commits.
  (use "git push" to publish your local commits)
nothing to commit, working directory clean
einsteinium$ git push
Counting objects: 10, done.
Delta compression using up to 8 threads.
Compressing objects:  12% (1/8)   
Writing objects:  10% (1/10)   
Total 10 (delta 4), reused 0 (delta 0)
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
   d7d033d..5548845  master -> master
einsteinium$ exit

Process shell finished