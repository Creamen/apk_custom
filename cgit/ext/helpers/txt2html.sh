#!/bin/sh
echo "<pre>"
sed "s|&|\\&amp;|g;s|'|\\&apos;|g;s|\"|\\&quot;|g;s|<|\\&lt;|g;s|>|\\&gt;|g"
echo "</pre>"

