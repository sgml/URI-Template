# URI Escaping

The spec defines 3 special groups of characters - "unreserved", "reserved" and
"pct-encoded". These are defined in a grammar in section 1.5.

Literals get lenient output escaping (anything in the 3 groups above is passed
through, the rest is UTF+%xx'ed).

The process of getting a variable's value into an output URI:

* Apply NFC
* Encode as UTF-8
* Escape the resulting bytes. Which ones need to be escaped depends on the
  template type:

  - Expressions "+" and "#" allow all 3 groups through, like literals.
  - Everything else only allows unreserved through unencoded.
