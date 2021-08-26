---
title: "TIL: Debugging maven surefire test in IDE"
date: 2021-08-26T21:19:00+02:00
---

Following command makes surefire wait with test execution until you connect on port 8000.

```
mvn -Dtest=SomeTest  \
-Dmaven.surefire.debug="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=8000 -Xnoagent -Djava.compiler=NONE" \
test -pl :some-module
```

