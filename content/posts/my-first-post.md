---
title: "TIL: Debugging frozen JVM"
date: 2021-07-28T07:35:48+02:00
---

When `kill -3 <pid>` and `jconsole <pid>` don't work as vm froze it is still possible
to get some info about the process.

```
gdb -p <pid>
(gdb) generate-core-file
Saved corefile core.<pid>
(gdb) quit
```


To extract the stacktrace:
```
jhsdb jstack \
--exe /home/jrubin/.sdkman/candidates/java/current/bin/java \
--core core.<pid>
```

To extract the heap dump:
```
jhsdb jmap --binaryheap \
--dumpfile dump.hprof \
--exe /home/jrubin/.sdkman/candidates/java/current/bin/java \
--core core.<pid>
```

Note that `jhsbd jmap` took couple of minutes to run. It is worth to observe size of `dump.hprof` as I interrupted the command twice thinking it hanged.
