By default, APIs do not restrict/limit the HTTP Verbs/Methods by which they can be accessed. In rare occasions, depending on how secure the server was or is setup, a sophisticated attacker may be able to use HEAD to leak information/secrets on the server.

API developers should ensure that APIs they build can only be accessed by the prescribed and specified HTTP verbs. All other verbs should not be permitted.  

Nathan Aw
(Singapore)
