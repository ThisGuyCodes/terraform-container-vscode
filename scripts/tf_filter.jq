.diagnostics[] |
.range.start as $st |
.range.end as $en |
.range.filename as $file |
.severity as $sev |
.summary as $code |
(.detail | split("\n") | join("\\n")) as $msg |
([$st.line,$st.column,$en.line,$en.column] | join(",")) as $loc |
["./" + $file, $loc, $sev, $code, $msg] |
join(":")