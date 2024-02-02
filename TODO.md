* TODO: Add new split word translation
* TODO: Add missing Arabic search layer
* TODO: Complete RnD and deploy ES "cross_field" field types https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-multi-match-query.htmla


Collisions:

Phonetic: Sky -> سَقَیۡتَ

* Searching for soul also includes یعقوب in Arabic Translation layer
* Searching for "beauty" collides with and highlights ذات with translation layers




Issues:

* Unicode: دهر != دھر (%u062F%u0647%u0631 != %u062F%u06BE%u0631)
* "<em>"" tag and other HTML entities get highlighted some times and show up in Etymology section. These should be filtered out
* Searching for word "amazing" results in confusing results because translation mapping from Talal
* Work loop is matching Chapter 3 for some reason.
