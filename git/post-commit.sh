#!/bin/sh
 
# This file should always be located on .git/hooks/ and needs executable
# permissions
# NOTE: This is a .sh file, but most of the time no extension will be added
 
# Should this be used on an actual professional project? No, at least not yet
# 
# This still misses so many things that would be needed, for example, this 
# could be done after certain checks are done, like tests or a CI flow
# but at this current state it is really not a good idea to do this, like 
# how it is implemented right now
# 
# So in summary, this needs work

# Pretty basic implementation of pushing after the commit
git push origin $(git branch --show-current)