lita-onewheel-giphy
-------------------

.. image:: https://travis-ci.org/onewheelskyward/lita-onewheel-giphy.svg?branch=master
:target: https://travis-ci.org/onewheelskyward/lita-onewheel-giphy
.. image:: https://coveralls.io/repos/github/onewheelskyward/lita-onewheel-giphy/badge.svg?branch=master
:target: https://coveralls.io/github/onewheelskyward/lita-onewheel-giphy?branch=master

Deprecated
----

Description
----
Aimed to be a complete implementation of the Giphy api.  https://github.com/giphy/GiphyAPI
It turns out they're not as good at search as Google, so I've put this functionality into https://github.com/onewheelskyward/lita-onewheel-images

Installation
----
Add lita-onewheel-giphy to your Lita instance's Gemfile:

``gem 'lita-onewheel-giphy'``

Configuration
----
api_url: The url of the giphy api (default: http://api.giphy.com/)
api_key: The auth key for the API.  Check the giphy docs for the open beta key.
rating: Limit your results to a specific MPAA-style rating e.g.
Usage
----
Implementation list:
- search NOPE
- GIF by id NOPE
- GIFs by id NOPE
- translate NOPE
- random NOPE
- trending NOPE
- stickers (search, translate, random, trending) NOPE NOPE NOPE NOPE
