---
layout: post
title: "Git: foe or friend?"
tags: git branch merge development code "source tree"
---

Git, the Source Code Management(SCM) software, has always been a double edged
sword for me. On one hand, it is a handy tool that seems to magically track changes of
a code base across multiple developers allowing concurrent work. On the other
hand, there are those occurances where commits conflicted, merges were botched,
pulling origin changes messed up current work, commits and stashes
were lost, and the list goes on.  If StackOverflow is any indication, git might
appear to be this tempramental monster with which encounters should be avoided at
all costs. Perhaps it was the thought of being a cowardly knight that encouraged
me to work towards a better understanding of the beast. Although this
is still a journey in progress, I'd like to share some of my lessons learnt from
being burnt.

- structuring code locally
- structring code as a project
- merging/rebasing
- internals
- using git for software development / research

Cooperating with Upstream
------
It is inevitable. Upstream will change before you are ready to merge in your
commits. Usually this comes to realization when you make a change or two and run
`git push` and are met with the following message:

```
! [rejected]        master -> master (non-fast forward)
error: failed to push some refs to 'git@github.com...'
```

First a discussion of what git is complaing about is in order. Before you began
making changes, your git repo might have looked some like this.

```
A -> B -> C
           origin/master
		   master
```

Where origin/master and master are synced together. Now before going further, I
would like to explain the annotation used here.  Those familure can skip ahead.

Here capital letters denote commits which themselves symbolize a changes made to
a code base along with some extra meta data such as date, author and a commit
message. Except for the genesis commit, all commits have a parent as denoted by
the arrow pointing from the child to the parent. In addition to commmits, we
have branches. Although any name can be used for a branch, master is the default
name for the first branch created.  A good way to think of branches are as
pointers to specific commits. In the above diagram, we have two branches both
pointing at commit C.  

Also notice that one branch seems to be named a bit strange: 'origin/master'.
This branch is also named master, however it is from a remote repository called
origin. 

Then you made some changes which were commited into D.

```
o -> A -> B -> C -> D
```

Now, while you were working on commit D, another developer made commit E and
pushed it to origin.

```
o -> A -> B -> C -> E
                 -> D
```

At this point you ran git push. Now before deciphering the error message git
gives us, it is necessary to understand the difference between a merge and a
fast-forward merge.

In the typical merge case, two branches share at least one commmon parent and
have at least commit not in the other branch.  This is exactly the case we have
presently with origin/master and master 


TODO
-----
- capitalize occurances of git
