%
%  statsd.pl
%  statsd-deps
%

meta_pkg('statsd-standalone', [
    statsd,
    grapite
]).

meta_pkg(statsd, [
    nodejs,
    npm,
    '__clone statsd',
    graphite
]).

managed_pkg(nodejs).
managed_pkg(npm).

pkg(graphite).
met(graphite, _) :-
    isdir('~/graphite/env'),
    bash('~/graphite/env/bin/python ~/graphite/check-dependencies.py').

meet(graphite, _).
depends(graphite, _, [
    '__checkout graphite source',
    '__graphite virtualenv'
]).

pkg('__graphite virtualenv').
met('__graphite virtualenv', _) :- isdir('~/graphite/env').
meet('__graphite virtualenv', _) :-
    bash('virtualenv ~/graphite/env'),
    bash('~/graphite/env/bin/pip install -r ~/graphite/requirements.txt').
depends('__graphite virtualenv', _, [
    virtualenv,
    cairo
]).

pkg(cairo).
installs_with_apt(cairo, _, 'libcairo2-dev').

pip_pkg(virtualenv).

pkg('__checkout graphite source').
met('__checkout graphite source', _) :- isdir('~/graphite').
meet('__checkout graphite source', _) :-
    bash('bzr branch lp:graphite').
depends('__checkout graphite source', _, [bzr]).

managed_pkg(bzr).

git_step(
    '__clone statsd',
    'https://github.com/etsy/statsd',
    '~/statsd'
).
