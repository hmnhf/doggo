# README

This is a simple project for exploring images of different dog breeds using [dog.ceo](https://dog.ceo/dog-api/) API.

The project is made with Ruby on Rails and Tailwind CSS.

It also depends on:

* [httpx](https://honeyryderchuck.gitlab.io/httpx/) for making API calls to [dog.ceo](https://dog.ceo/dog-api/)
* [hotwire_combobox](https://github.com/josefarias/hotwire_combobox) for breed selection
* [turbo](https://github.com/hotwired/turbo) for async streaming of the selected breed's image
* [redis](https://github.com/redis/redis-rb) for caching "List All Breeds" API response
* [rspec-rails](https://github.com/rspec/rspec-rails) for unit and request specs
* [vcr](https://github.com/vcr/vcr/) for capturing and re-using [dog.ceo](https://dog.ceo/dog-api/) API responses in specs
* [icons8.com](https://icons8.com/) for the favicon
