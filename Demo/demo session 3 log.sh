einsteinium$ pwd
/tmp/demo/Workshop-2016-Warwick-2/Demo
einsteinium$ ls
README	demo session 1 log.sh  demo session 2 log.sh
einsteinium$ mkdir foo
einsteinium$ cd foo
einsteinium$ touch a b c e
einsteinium$ ls
a  b  c  e
einsteinium$ cd ..
einsteinium$ ls
README	demo session 1 log.sh  demo session 2 log.sh  foo
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	foo/

nothing added to commit but untracked files present (use "git add" to track)
einsteinium$ git add foo
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   foo/a
	new file:   foo/b
	new file:   foo/c
	new file:   foo/e

einsteinium$ 
einsteinium$ git reset HEAD foo/a
einsteinium$ 
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   foo/b
	new file:   foo/c
	new file:   foo/e

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	foo/a

einsteinium$ # now we add .gitignore
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   foo/b
	new file:   foo/c
	new file:   foo/e

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	.gitignore

einsteinium$ git add .gitignore 
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   .gitignore
	new file:   foo/b
	new file:   foo/c
	new file:   foo/e

einsteinium$ git commit -m 'add some files'
[master adbac9d] add some files
 4 files changed, 1 insertion(+)
 create mode 100644 Demo/.gitignore
 create mode 100644 Demo/foo/b
 create mode 100644 Demo/foo/c
 create mode 100644 Demo/foo/e
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   .gitignore

no changes added to commit (use "git add" and/or "git commit -a")
einsteinium$ git commit -a -m 'update .gitignore'
[master 8733368] update .gitignore
 1 file changed, 1 insertion(+)
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
remote: Total 6 (delta 4), reused 6 (delta 4), pack-reused 0        
Unpacking objects:  16% (1/6)   
From github.com:Macaulay2/Workshop-2016-Warwick
   bdbf9d1..1da842c  master     -> origin/master
Removing RandomIdeals/demo.m2~
Removing RandomIdeals/#demo.m2#~
Waiting for Emacs...
Merge made by the 'recursive' strategy.
 RandomIdeals/#demo.m2#~ |  0
 RandomIdeals/demo.m2~   | 47 -----------------------------------------------
 2 files changed, 47 deletions(-)
 delete mode 100644 RandomIdeals/#demo.m2#~
 delete mode 100644 RandomIdeals/demo.m2~
einsteinium$ git push
Counting objects: 11, done.
Delta compression using up to 8 threads.
Compressing objects:  11% (1/9)   
Writing objects:   9% (1/11)   
Total 11 (delta 5), reused 0 (delta 0)
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
   1da842c..e93e65a  master -> master
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean
einsteinium$ ls
README	demo session 1 log.sh  demo session 2 log.sh  foo
einsteinium$ cd foo
einsteinium$ ls
a  b  c  e
einsteinium$ git rm b
rm 'Demo/foo/b'
einsteinium$ ls
a  c  e
einsteinium$ git rm --cached c
rm 'Demo/foo/c'
einsteinium$ ls
a  c  e
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	deleted:    b
	deleted:    c

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	c

einsteinium$ git commit -m 'remove some files'
[master 6b45280] remove some files
 2 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 Demo/foo/b
 delete mode 100644 Demo/foo/c
einsteinium$ git pull && git push
Already up-to-date.
Counting objects: 4, done.
Delta compression using up to 8 threads.
Compressing objects:  33% (1/3)   
Writing objects:  25% (1/4)   
Total 4 (delta 2), reused 0 (delta 0)
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
   e93e65a..6b45280  master -> master
einsteinium$ pwd
/tmp/demo/Workshop-2016-Warwick-2/Demo/foo
einsteinium$ cd ../../../Workshop-2016-Warwick
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean
einsteinium$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   Demo/README

no changes added to commit (use "git add" and/or "git commit -a")
einsteinium$ git commit -a -m 'modify Demo/README'
[master 81f9b76] modify Demo/README
 1 file changed, 2 insertions(+)
einsteinium$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
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
remote: Counting objects: 537, done.        
remote: Compressing objects:   1% (1/98)           
Receiving objects:   0% (1/537)   
Receiving objects:  55% (296/537), 4.64 MiB | 4.56 MiB/s   
Resolving deltas:   0% (0/284)   
From github.com:Macaulay2/Workshop-2016-Warwick
   4a70a65..6b45280  master     -> origin/master
Auto-merging Demo/README
CONFLICT (content): Merge conflict in Demo/README
Automatic merge failed; fix conflicts and then commit the result.
einsteinium$ git status
On branch master
Your branch and 'origin/master' have diverged,
and have 1 and 144 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)
You have unmerged paths.
  (fix conflicts and run "git commit")

Changes to be committed:

	new file:   Demo/.gitignore
	new file:   Demo/demo session 1 log.sh
	new file:   Demo/demo session 2 log.sh
	new file:   Demo/foo/e
	new file:   Dmodules/Kashiwara.m2
	new file:   Numerical/.circle.m2.swp
	new file:   Numerical/PHCpack.m2
	new file:   Numerical/PHCpack/PHCpackDoc.m2
	new file:   Numerical/PHCpack/examples/_is__Witness__Set__Member.out
	new file:   Numerical/PHCpack/examples/_mixed__Volume.out
	new file:   Numerical/PHCpack/examples/_non__Zero__Filter.out
	new file:   Numerical/PHCpack/examples/_numerical__Irreducible__Decomposition.out
	new file:   Numerical/PHCpack/examples/_refine__Solutions.out
	new file:   Numerical/PHCpack/examples/_solve__Rational__System.out
	new file:   Numerical/PHCpack/examples/_solve__System.out
	new file:   Numerical/PHCpack/examples/_t__Degree.out
	new file:   Numerical/PHCpack/examples/_to__Laurent__Polynomial.out
	new file:   Numerical/PHCpack/examples/_top__Witness__Set.out
	new file:   Numerical/PHCpack/examples/_track__Paths.out
	new file:   Numerical/PHCpack/examples/_zero__Filter.out
	new file:   Numerical/README
	new file:   Numerical/circle.m2
	new file:   Numerical/phc
	new file:   Numerical/sweep_real.m2
	new file:   RandomIdeals/.gitignore
	new file:   RandomIdeals/CMtesting/CMtesting.m2
	modified:   RandomIdeals/RandomIdeal.m2
	modified:   RandomIdeals/ResidualIntersections.m2
	new file:   RandomIdeals/SCMtesting/SCMexamples.m2
	new file:   RandomIdeals/brandens-demo.m2
	new file:   ToricStuff/MLBundles.m2
	new file:   ToricStuff/NormalToricVarieties.m2
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties.txt
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties5.txt
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties6.txt
	new file:   ToricStuff/ToricVectorBundles.m2
	new file:   Tropical/OldFileFromDianesSummerStudent.docx
	new file:   Tropical/PolyhedralObjects.m2
	new file:   Tropical/ProjectBrainstorming
	new file:   Tropical/Tropical.m2
	new file:   Tropical/gfanInterface2.m2
	new file:   Visualize/README.md
	new file:   memoryLeaks/memoryLeak.m2

Unmerged paths:
  (use "git add <file>..." to mark resolution)

	both modified:   Demo/README

einsteinium$ cat Demo/README 
This file is in a directory that Dan made.
<<<<<<< HEAD

Let's add a different line here.
||||||| merged common ancestors
=======

I made a change.

Add a line.

In emacs I used C-x v v to add and commit the file.
>>>>>>> 6b45280f8061751487ef12606c931ac520174258
einsteinium$ # edit it
einsteinium$ cat Demo/README 
This file is in a directory that Dan made.

Let's add a different line here.

I made a change.

Add a line.

In emacs I used C-x v v to add and commit the file.
einsteinium$ git status
On branch master
Your branch and 'origin/master' have diverged,
and have 1 and 144 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)
You have unmerged paths.
  (fix conflicts and run "git commit")

Changes to be committed:

	new file:   Demo/.gitignore
	new file:   Demo/demo session 1 log.sh
	new file:   Demo/demo session 2 log.sh
	new file:   Demo/foo/e
	new file:   Dmodules/Kashiwara.m2
	new file:   Numerical/.circle.m2.swp
	new file:   Numerical/PHCpack.m2
	new file:   Numerical/PHCpack/PHCpackDoc.m2
	new file:   Numerical/PHCpack/examples/_is__Witness__Set__Member.out
	new file:   Numerical/PHCpack/examples/_mixed__Volume.out
	new file:   Numerical/PHCpack/examples/_non__Zero__Filter.out
	new file:   Numerical/PHCpack/examples/_numerical__Irreducible__Decomposition.out
	new file:   Numerical/PHCpack/examples/_refine__Solutions.out
	new file:   Numerical/PHCpack/examples/_solve__Rational__System.out
	new file:   Numerical/PHCpack/examples/_solve__System.out
	new file:   Numerical/PHCpack/examples/_t__Degree.out
	new file:   Numerical/PHCpack/examples/_to__Laurent__Polynomial.out
	new file:   Numerical/PHCpack/examples/_top__Witness__Set.out
	new file:   Numerical/PHCpack/examples/_track__Paths.out
	new file:   Numerical/PHCpack/examples/_zero__Filter.out
	new file:   Numerical/README
	new file:   Numerical/circle.m2
	new file:   Numerical/phc
	new file:   Numerical/sweep_real.m2
	new file:   RandomIdeals/.gitignore
	new file:   RandomIdeals/CMtesting/CMtesting.m2
	modified:   RandomIdeals/RandomIdeal.m2
	modified:   RandomIdeals/ResidualIntersections.m2
	new file:   RandomIdeals/SCMtesting/SCMexamples.m2
	new file:   RandomIdeals/brandens-demo.m2
	new file:   ToricStuff/MLBundles.m2
	new file:   ToricStuff/NormalToricVarieties.m2
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties.txt
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties5.txt
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties6.txt
	new file:   ToricStuff/ToricVectorBundles.m2
	new file:   Tropical/OldFileFromDianesSummerStudent.docx
	new file:   Tropical/PolyhedralObjects.m2
	new file:   Tropical/ProjectBrainstorming
	new file:   Tropical/Tropical.m2
	new file:   Tropical/gfanInterface2.m2
	new file:   Visualize/README.md
	new file:   memoryLeaks/memoryLeak.m2

Unmerged paths:
  (use "git add <file>..." to mark resolution)

	both modified:   Demo/README

einsteinium$ git add Demo/README 
einsteinium$ git status
On branch master
Your branch and 'origin/master' have diverged,
and have 1 and 144 different commits each, respectively.
  (use "git pull" to merge the remote branch into yours)
All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)

Changes to be committed:

	new file:   Demo/.gitignore
	modified:   Demo/README
	new file:   Demo/demo session 1 log.sh
	new file:   Demo/demo session 2 log.sh
	new file:   Demo/foo/e
	new file:   Dmodules/Kashiwara.m2
	new file:   Numerical/.circle.m2.swp
	new file:   Numerical/PHCpack.m2
	new file:   Numerical/PHCpack/PHCpackDoc.m2
	new file:   Numerical/PHCpack/examples/_is__Witness__Set__Member.out
	new file:   Numerical/PHCpack/examples/_mixed__Volume.out
	new file:   Numerical/PHCpack/examples/_non__Zero__Filter.out
	new file:   Numerical/PHCpack/examples/_numerical__Irreducible__Decomposition.out
	new file:   Numerical/PHCpack/examples/_refine__Solutions.out
	new file:   Numerical/PHCpack/examples/_solve__Rational__System.out
	new file:   Numerical/PHCpack/examples/_solve__System.out
	new file:   Numerical/PHCpack/examples/_t__Degree.out
	new file:   Numerical/PHCpack/examples/_to__Laurent__Polynomial.out
	new file:   Numerical/PHCpack/examples/_top__Witness__Set.out
	new file:   Numerical/PHCpack/examples/_track__Paths.out
	new file:   Numerical/PHCpack/examples/_zero__Filter.out
	new file:   Numerical/README
	new file:   Numerical/circle.m2
	new file:   Numerical/phc
	new file:   Numerical/sweep_real.m2
	new file:   RandomIdeals/.gitignore
	new file:   RandomIdeals/CMtesting/CMtesting.m2
	modified:   RandomIdeals/RandomIdeal.m2
	modified:   RandomIdeals/ResidualIntersections.m2
	new file:   RandomIdeals/SCMtesting/SCMexamples.m2
	new file:   RandomIdeals/brandens-demo.m2
	new file:   ToricStuff/MLBundles.m2
	new file:   ToricStuff/NormalToricVarieties.m2
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties.txt
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties5.txt
	new file:   ToricStuff/NormalToricVarieties/smoothFanoToricVarieties6.txt
	new file:   ToricStuff/ToricVectorBundles.m2
	new file:   Tropical/OldFileFromDianesSummerStudent.docx
	new file:   Tropical/PolyhedralObjects.m2
	new file:   Tropical/ProjectBrainstorming
	new file:   Tropical/Tropical.m2
	new file:   Tropical/gfanInterface2.m2
	new file:   Visualize/README.md
	new file:   memoryLeaks/memoryLeak.m2

einsteinium$ git commit
Waiting for Emacs...
[master 1fd0e85] Merge branch 'master' of github.com:Macaulay2/Workshop-2016-Warwick
einsteinium$ git log -1
commit 1fd0e85c161b5365eec877b6440f2ddba9d4121a
Merge: 81f9b76 6b45280
Author: Daniel R. Grayson <dan@math.uiuc.edu>
Date:   Tue May 24 09:25:41 2016 +0100

    Merge branch 'master' of github.com:Macaulay2/Workshop-2016-Warwick
    
    I had a painful conflict. uggh.
einsteinium$ git pull && git push
Already up-to-date.
Counting objects: 8, done.
Delta compression using up to 8 threads.
Compressing objects:  14% (1/7)   
Writing objects:  12% (1/8)   
Total 8 (delta 5), reused 0 (delta 0)
To git@github.com:Macaulay2/Workshop-2016-Warwick.git
   6b45280..1fd0e85  master -> master
einsteinium$ git config --global merge.conflictstyle diff3
einsteinium$ cat ~/.gitconfig 
[user]
	name = Daniel R. Grayson
	email = dan@math.uiuc.edu
[push]
	default = matching
[filter "media"]
	required = true
	clean = git media clean %f
	smudge = git media smudge %f
[merge]
	conflictstyle = diff3
[filter "lfs"]
	required = true
	clean = git-lfs clean %f
	smudge = git-lfs smudge %f
einsteinium$ printenv EDITOR
emacsclient
einsteinium$ git config --global core.editor emacs
einsteinium$ cat ~/.gitconfig 
[user]
	name = Daniel R. Grayson
	email = dan@math.uiuc.edu
[push]
	default = matching
[filter "media"]
	required = true
	clean = git media clean %f
	smudge = git media smudge %f
[merge]
	conflictstyle = diff3
[filter "lfs"]
	required = true
	clean = git-lfs clean %f
	smudge = git-lfs smudge %f
[core]
	editor = emacs
einsteinium$ grep EDITOR ~/.emacs
(server-start) (setenv "EDITOR" "emacsclient")
einsteinium$ 