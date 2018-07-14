# Moab-Use-R

A repository for the Moab Use-R! group


# Tips

When you add files, edit files, or delete files the workflow will always be:

1. Commit the change, with a message
2. Pull changes from the remote server
3. Push changes to the remote server

The Git Desktop GUI combines the Pull and Push steps into one single "Sync" button. 

# Merge Conflicts

If you have a merge conflict, the offending files will have edits that highlight where two versions of the same file diverge e.g.

```
<<<<<<< HEAD
data <- read.csv(...)
=======
my_Data <- read.csv(...)
>>>>>>> cb1abc6bd98cfc84317f8aa95a7662815417802d
```

* HEAD = YOUR version of the file
* The long hexadecimal string is the version of the file on the Remote Server
* In order to resolve the conflict and successfully merge the versions of the file, you must remove all of the lines with angled brackets (e.g. <<<< HEAD, >>>>), the line with the equals sign, and the line of code you don't want to save. 
* After you remove those tags, you can continue the merging process