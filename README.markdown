Summary
=======

A command line password generator.

genpwd allows you to use a master password to generate derived passwords, which
you can then use for any service that requires a password.  Since you never
expose the master password, this means that if any derived password is
compromised, none of your other passwords are.

This also allows you to generate *strong* passwords from a *weak* master
password.


Requirements
============

* Ruby 1.8.7 or higher 

However, earlier versions of ruby are likely to work.


Installation
============

From Source
-----------

With rake installed, run
	rake install

to have the genpwd binary copied to $HOME/bin and bash completion copied to
/etc/bash_completion.d


Once installed, be sure to edit ~/.genpwd/password with your master password.


Usage
=====

Passwords are generated from 3-tuples consisting of key, alphabet and size.
Alphabet and size have sensible defaults, so all that is needed is to specify
the key.  

Use whatever key convention you prefer.  A suggested one is user@servce. So if
you have a username 'foo' at service 'slashdot.org', you could use the key
'foo@slashdot.org'.


To add a key and generate a new password, run the following command
	genpwd --add KEY

To add a password of size N
	genpwd --size=SIZE --add KEY

To add a password with a restricted alphabet (note, ascii characters and digits
are always included)
	genpwd --alpha=SPECIAL_CHARACTERS KEY

e.g.
	genpwd --alpha="[]{}" someone@example.com


To retrieve existing passwords, run the command:
	genpwd KEY

Note that it is not necessry to specify either --alpha or --size, even if the
password was initially created with those options.

If you have bash completion installed, keys will be autocompleted.  So, with the
prompt reading
	genpwd 

Hitting tab should display a list of keys with normal bash completion.


Feedback
========

Feedback, suggestions, bugs, etc. gratefully accepted at <genpwd@hjdivad.com>.

