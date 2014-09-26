# dotfiles Sync Script

This script is designed to help maintain the dotfiles.

The whole reason I went over to installing with ansible was because I can
template some of the files that need special sections depending on what OS they
are installed on.

The large majority of files however are not templated; but they are _copied_
into place. The goal of this script is to pull their changes back into the repo
so the dotfiles repo can be kept in-sync with the rest of the live world.

This will not sync templated files, this will delete files that have been
deleted!


# This is as of yet ... un-tested
