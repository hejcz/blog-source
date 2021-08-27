---
title: "TIL: org.reflections vs ClassGraph"
date: 2021-08-27T07:02:00+02:00
---

Many applications perform some kind of a classpath scan. Think of spring
finding all classes annotated with `@RestController` or implementing specific 
interface.

In work we use patched [org.reflections](https://github.com/ronmamo/reflections)
 in version `9.11`. Upgrade to `9.12`
failed due to a [bug](https://github.com/ronmamo/reflections/issues/297) so
we considered changing reflection library. The only reasonable candidate was
[ClassGraph](https://github.com/classgraph/classgraph).

Both libraries work in similar maneer:
1. Determine jars and directories on classpath.
2. Iterate over their content.
3. If specific class or resource matches user-defined rules add them to result set.
4. If matched resources extend some class or implement an interface add them to result set.

In all tests ClassGraph required significantly more time than reflections. 
It seems reflections test each resource against user-defined pattern in step 3
and if it doesn't match it is skipped. On the other hand ClassGraph stores
all found resources in a map. This approach allows to query all unmatched
and not rejected resources but lengthens scan. In particular ClassGraph spends
a lot of time calculating String's hashCode on inserting found resource to a map.

The other problem is that ClassGraph produces significantly more garbage
during scan. For now it seems we need to have our fingers crossed for `org.reflections`
`9.13` version.