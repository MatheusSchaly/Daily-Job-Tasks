**explorer .** Opens explorer

**code .** Opens visual studio code

**pwd** Shows current path

**ls -la** Lists table format and hidden files

**\--help** Shows details about a command

**\>\>** Appends to a file

**rm -rf** Removes a folder that has contents

**ls -la** Lists the files in the working directory

**ls -la .git/objects** Lists the files in local git repository

**find .git/objects -type f** Lists the files in the git repository

**cat .git/HEAD** Checks which branch or commit HEAD is pointing to

**cat .git/refs/heads/master** Checks which commit master branch is pointing to

**cat .git/refs/heads/BRANCH_NAME** Checks which commit BRANCH_NAME branch is pointing to

**Example of Git pointers**:

![head_main_origin-head_origin-main](https://user-images.githubusercontent.com/22715620/212566175-67ba595f-acb8-4719-ba92-00734a0c2a60.png)

- **HEAD:** A pointer, where my local repository is currently pointing at.
In this case, it's pointing to main which is pointing to the commit
16a000
- **main:** A pointer, the main local repository pointer. In this case,
main is pointing to the commit 16a000
- **origin/HEAD:** A pointer, where my remote repository is currently
pointing at. In this case, it's absent
- **origin/main:** A pointer, the main remote repository pointer. In this
case, main is pointing to the commit 16a000

**Git init:**

- **git init** Initiate git

**Git config:**

- **git config \--global user.name NAME** Set git author name
- **git config \--global user.email EMAIL** Set git author email
- **git config \--list** Lists currently set author name and email
- **git config credential.helper ""** Clean up credentials cache

**Git rm:**

- **git rm \--cached FILE_NAME** Remove file from staging area (states: staged -\> untracked)

**Git ls-files:**

- **git ls-files -s** Lists the files in the staging area

**Git cat-file:**

- **git cat-file -p HASH** Shows the content of the hash object

**Git merge:**

- **git merge FETCH_HEAD** Merges the checkouted branch updating local index and local working directory with the contents of local git repository

**Git fetch:**

- **git fetch** Updates local git repository with remote git repository contents

**Git show:**

- **git show COMMIT_HASH** Shows the changes of COMMIT_HASH commit

**Git remote:**

- **git remote show origin** Shows a summary of remote and local branches
- **git remote update origin \--prune** Prunes branches that are present locally but were deleted remotely
- **git remote add NAME HTTP_CLONING** Adds a remote repository with an easy to remember NAME using its HTTP cloning link
- **git remote -v** Lists all remote repositories

**Git pull:**

- **git pull** Performs git fetch followed by git merge FETCH_HEAD

**Git show-ref:**

- **git show-ref** Shows remote and local references, that is, which commits the branches are pointing to
- **git show-ref BRANCH_NAME** Shows remote and local references for the branch, that is, which commits the branches are pointing to

**Git stash:**

- **git stash** Saves uncommitted work in a stack
- **git stash pop** Applies the changes stored in the top of the stack into working directory

**Git add:**

- **git add FILE_NAME** Add file from working directory to staging area (states: untracked -\> staged)

**Git commit:**

- **git commit -m "COMMIT MESSAGE"** Add file from staging area to local git repository (states: staged -\> unmodified) and attaches a message to the commit
- **git commit -m -a "COMMIT MESSAGE"** Same as git add and git commit -m "COMMIT MESSAGE"
- **git commit \--amend** Modifies information about the last commit

**Git rebase:**

- **git rebase -i origin/main** Places the changes of current branch on top of origin/main

**Git push:**

- **git push origin vX.X.X** Pushes vX.X.X local tag to remote repository
- **git push \--tags** Pushes all local tags to remote repository
- **git push origin -d BRANCH_NAME** Deletes remote branch
- **git push -u origin BRANCH_NAME** Same as \--set-upstream, used to create remote branch of an already created local branch, modifying it to a tracking branch

**Git tag:**

- **git tag** Lists the tags in local git repository
- **git tag vX.X.X** Creates a lightweight tag with version vX.X.X
- **git tag show vX.X.X** Shows information about the commit referenced by tag vX.X.X
- **git tag -a vX.X.X -m \"Tag message\"** Creates an annotated tag with version v.X.X.X and message \"Tag message\"
- **git tag -v vX.X.X** Shows annotated tag details

**Git status:**

- **git status** Shows the state of the working directory and staging area
- **git status -v** Same as git status but also shows the changes made in each of file

**Git diff:**

- **git diff** Shows the changes made in each file

**Git branch:**

- **git branch** Lists local branches
- **git branch -r** Lists remote branches
- **git branch -a** Lists local and remote branches
- **git branch \--v** Lists tracking branches
- **git branch -d BRANCH_NAME** Deletes local branch

**Git reset:**

- **git reset \--soft COMMIT_HASH** Discards COMMIT_HASH following commits, keeps changes in staging area, and changes are also kept in working directory
- **git reset \--mixed COMMIT_HASH** Discards COMMIT_HASH following commits, unstages files, but changes are kept in working directory
- **git reset \--hard COMMIT_HASH** Discards COMMIT_HASH following commits, discard changes in staging area, and discard changes in working directory
- **git reset \--mixed HEAD\~5** Resets 5 last commits

**Git revert:**

- **git revert \--mixed COMMIT_HASH** Creates a new commit that reverts the changes of COMMIT_HASH commit

**Git switch:**

- **git switch -c BRANCH origin/BRANCH** Checks out to BRANCH and creates a new local BRANCH which tracks remote BRANCH

**Git cherry-pick:**

- **git cherry-pick COMMIT_HASH** Takes any commit and insert it and the currently checked out branch as the last commit
- **git cherry-pick --no-commit COMMIT_HASH** Takes any commit and insert it and the currently checked out branch without making a commit

**Git reflog:**

- **git reflog** Shows the entire history of all operations (commit, checkout, cherry-pick...) made in the local repository. Operations if the reflog are stored by default 90 days. Can be used to run git reset --hard COMMIT_HASH back-and-forth
- **git reflog show BRANCH_NAME** Shows reflog of a specific branch

**Git log:**

- **git log** Shows the commits logs

**Git lg alias possible options:**

- git config \--global alias.lg \"log \--color \--graph \--pretty=format:\'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)\<%an\>%Creset\' \--abbrev-commit\"
- git config \--global alias.lg \"log \--oneline \--graph \--decorate \--all\"

More info: https://devhints.io/git-log-format

**Rebase:**

1. git checkout main
2. git pull
3. git checkout BRANCH_NAME
4. git pull
5. git rebase -i origin/main (if VIM, use \"i\" to insert, \"esc\" to stop insert, \":x\" to exit and
save)
6. git push \--force-with-lease origin BRANCH-NAME

**Pull into forked from original repository (Azure DevOps, Azure Databricks):**

1. git remote add EASY_NAME ORIGINAL_HTTP_CLONING
2. git remote -v
3. git switch -c BRANCH_NAME origin/BRANCH_NAME
4. git rebase -i EASY_NAME/main
5. git push \--force-with-lease origin BRANCH_NAME
6. Do this twice: Go to another random branch and come back to your
BRANCH_NAME
