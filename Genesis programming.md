Think of each program as defining not just a language, but a world.

Have pre-built worlds as well as pre-built types: for example, POSIX, web, SDL.

Also orientations, for example filter, event-driven, physical.

So for example, an arcade game might be time-based SDL, while a command-line utility might be POSIX filter. A network server could be event-driven POSIX. A dynamic web site could be event-driven web, while a static site might be filter POSIX→web: more than one world might be in play.

Just as languages are considered over an alphabet, so worlds define a set of fundamental types and orientations their interaction styles. (Another way in which multiple worlds might typically be in play is that one might always expect access to a “computational” world in which there are basic machine types.)

A filter orientation implies immutable, timelessness, stateless; a physical world would be mutable and stateful; an event-driven orientation could be stateful and immutable, or stateless and immutable.

In each case, the orientation sets up the basic execution units (parallel or serial? termination condition?), and the world gives both the types and the I/O channels.

Composable layers of environment: for example, one could enhance the basic POSIX filter to be line-oriented, or tree-oriented, or graph-oriented, or (more concretely) JSON-oriented or XML-oriented. In the latter two cases, one would expect concrete query languages, for example.

Another higher-level orientation would be “database”, which would introduce querying and (in the appropriate cases) transactions.

In each case, the relevant features should appear as language features, making the program natural, but also be recognisable and composable, like types, so not leading to each program being incomprehensible to anyone but its author.

One might think of environments’/worlds’ effect on the code as a bit like paragraph styles in a word-processor: it affects its interpretation, much like heading/quotation &c.