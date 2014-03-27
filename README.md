# generator-library [![Build Status](https://secure.travis-ci.org/ianwremmel/generator-library.png?branch=master)](https://travis-ci.org/ianwremmel/generator-library) [![Dependencies](https://david-dm.org/ianwremmel/generator-library.png)](https://david-dm.org/ianwremmel/generator-library)



A generator for [Yeoman](http://yeoman.io).


## Getting Started

Make sure you've install Yeoman.

```bash
$ npm install -g yo
```

To install generator-library, fork this repository, clone your repository, and, in the new directory, run:

```bash
$ npm link
```

Finally, invoke the generator from your new project directory:

```bash
$ yo library
```

### generator-library

generator-library is a yeoman generator built for ianwremmel's workflow preferences. At its core, it's a very lightweight set of preferences, but overtime will expand for many of the various project types he works on.

It is unlikely to ever end up in npm.

#### Assumptions

- If you're doing anything in the frontend, you'll be using browserify.
- Your name is `Ian W. Remmel` and all your projects will be `Copyright (c) Ian W. Remmel`.

## License

[MIT License](http://en.wikipedia.org/wiki/MIT_License)
