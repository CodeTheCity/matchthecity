Great to have you here! Here are a few ways you can help out with [MatchTheCity](http://github.com/CodeTheCity/matchthecity).

# Where should I start?

You can start learning about MatchTheCity by reading the [README](https://github.com/CodeTheCity/matchthecity/blob/master/README.md). If you want, you can also read about [CodeTheCity](http://codethecity.org) that spawned the project.

## Your first commits

If you’re interested in contributing to MatchTheCity, that’s awesome! We’d love your help.

## Tackle some small problems

We track [small
bugs and features](https://github.com/CodeTheCity/matchthecity/issues?labels=small&state=open) so that anyone who wants to help can start with something that's not too overwhelming. If nothing on those lists looks good, though, just talk to us.


# Development setup

To work on MatchTheCity, you'll probably want to do a couple of things.

  1. Install the current data set

        $ rake import:rebuild_all

  2. Run the test suite (once it has been created!!), to make sure things are working

        $ rake spec

# Bug triage

Triage is the work of processing tickets that have been opened into actionable issues, feature requests, or bug reports. That includes verifying bugs, categorizing the ticket, and ensuring there's enough information to reproduce the bug for anyone who wants to try to fix it.

We've created an [issues guide](https://github.com/CodeTheCity/matchthecity/blob/master/ISSUES.md) to walk MatchTheCity users through the process of troubleshooting issues and reporting bugs.

If you'd like to help, great! You can [report a new bug](https://github.com/CodeTheCity/matchthecity/issues/new) or browse our [existing open tickets](https://github.com/CodeTheCity/matchthecity/issues).

Not every ticket will point to a bug in the code, but open tickets usually mean that there is something we could improve to help that user. Sometimes that means writing additional documentation, or sometimes that means making error messages clearer.

When you're looking at a ticket, here are the main questions to ask:

  * Can I reproduce this bug myself?
  * Are the steps to reproduce clearly stated in the ticket?
  * Which operating systems (OS X, Windows, Ubuntu, CentOS, etc.) manifest this bug?
  * Which rubies (MRI, JRuby, Rubinius, etc.) and which versions (1.8.7, 1.9.3, etc.) have this bug?

If you can't reproduce an issue, chances are good that the bug has been fixed (hurrah!). That's a good time to post to the ticket explaining what you did and how it worked.

If you can reproduce an issue, you're well on your way to fixing it. :) Fixing issues is similar to adding new features:

  1. Discuss the fix on the existing issue. Coordinating with everyone else saves duplicate work and serves as a great way to get suggestions and ideas if you need any.
  2. Base your commits on the correct branch. 
  3. Commit the code and at least one test covering your changes to a named branch in your fork.
  4. Put a line in the [CHANGELOG](https://github.com/CodeTheCity/matchthecity/blob/master/CHANGELOG.md) summarizing your changes under the next release under the “Bugfixes” heading.
  5. Send us a [pull request](https://help.github.com/articles/using-pull-requests) from your bugfix branch.

Finally, the ticket may be a duplicate of another older ticket. If you notice a ticket is a duplicate, simply comment on the ticket noting the original ticket’s number. For example, you could say “This is a duplicate of issue #42, and can be closed”.


# Adding new features

If you would like to add a new feature to MatchTheCity, please follow these steps:

  1. [Create an issue](https://github.com/CodeTheCity/matchthecity/issues/new) to discuss your feature.
  2. Base your commits on the master branch.
  3. Commit the code and at least one test covering your changes to a feature branch in your fork.
  4. Put a line in the [CHANGELOG](https://github.com/CodeTheCity/matchthecity/blob/master/CHANGELOG.md) summarizing your changes under the next release under the "Features" heading.
  5. Send us a [pull request](https://help.github.com/articles/using-pull-requests) from your feature branch.

If you don't hear back immediately, don’t get discouraged! We all have day jobs, but we respond to most tickets within a day or two.


# Beta testing

There may not always be prereleases or beta versions of MatchTheCity. That said, you are always welcome to try checking out master and having a play yourself if you want to try out the latest changes.


# Translations

We don't currently have any translations, but please reach out to us if you would like to help get this going. We know that there are multitude of languages spoken in Aberdeen and other cities.


# Documentation

Code needs explanation, and sometimes those who know the code well have trouble explaining it to someone just getting into it. Because of that, we welcome documentation suggestions and patches from everyone, especially if they are brand new to using MatchTheCity.

MatchTheCity has two main sources of documentation: the built-in auto generated documentation and the [README](https://github.com/CodeTheCity/matchthecity/blob/master/README.md).


# Community

Sharing your experiences and discoveries by writing them up is a valuable way to help others who have similar problems or experiences in the future. You can write a blog post, create an example and commit it to Github, take screenshots, or make videos.

If you let someone on the core team know you wrote about MatchTheCity, we will add your post to a list on the Github project wiki.

Feel free to contact the MatchTheCity core team via Twitter [@MatchTheCity](https://twitter.com/matchthecity)
