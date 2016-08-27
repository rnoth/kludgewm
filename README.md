# kludgewm

kludgewm is a collection of wmutils scripts that maintain a simplistic window environment, hence the 'wm'. The scripts are typically hacked together ina single sitting, and rely on quirks in each others behavior in order to function properly, hence the kludge.

## environment

kludgewm scripts currently pay attention to the 'TMPDIR' environment variable, which tells it where to put its '.wid' files. If you want to play with kludgewm, add this to your xinitrc: `export TMPDIR=/tmp`

## mark

mark is most interesting script in this collection. it implements a mark-and-recall interface for your windows. In common wm parlance, you can think of it has a group manage where the groups can only hold one window.

it maintains a set of '.wid' files in the hidden '.marks' subdirectory of your $TMPDIR.

mark has three core subcommands

### mark

running `mark mark` requires dmenu. it will propt the user for a string and save the id of the currect window ina plaintext file in $TMPDIR/.marks/$string.wid. if the supplied string is already in use, it is overwritten

a variant of mark, qmark, can be run by executing `mark qmark`. It requires a single string argument, and saves a quickmark with that name. quickmarks are different from normal marks by being hiddens files, and hence `mark recall` cannot see them. Quickmarks must be loaded with the `mark qmark` command.

### recall

running `mark recall` requires dmenu. it dump the current existing quickmarks in the dmenu's stdin, alowing you to quickly select the mark. recall returns an error if the selected mark does not exist

a variant of recall, qrecall exists, and takes a string argument, behaving identically to recall except loading quickmarks instead of normal marks.

An example sxhkd setup to handle quickmarks:

    hyper + apostrophe; {a-z}
    	mark qmark {a-z}
    
    hyper + slash; {a-z}
    	mark qrecall {a-z}

### unmark

the behavior of unmark should be evident

a variant of unmark, qunmark, exists for quickmarks

### hide

hide propts the user (again via dmenu) for the name of a mark. It then hides that mark. If the mark does not exist, hide marks the current window and hides it.

qhide does the same, but for quickmarks

# TODO

- document the rest of the scripts  
