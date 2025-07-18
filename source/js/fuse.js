/*
 *!
 * Fuse.js v3.2.0 - Lightweight fuzzy-search (http://fusejs.io)
 *
 * Copyright (c) 2012-2017 Kirollos Risk (http://kiro.me)
 * All Rights Reserved. Apache Software License 2.0
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 */
(function webpackUniversalModuleDefinition(root, factory) {
  if (typeof exports === 'object' && typeof module === 'object') module.exports = factory();
  else if (typeof define === 'function' && define.amd) define('Fuse', [], factory);
  else if (typeof exports === 'object') exports['Fuse'] = factory();
  else root['Fuse'] = factory();
})(this, () => {
  return /******/ (function (modules) {
    // webpackBootstrap
    /******/ // The module cache
    /******/ var installedModules = {};
    /** *** */
    /******/ // The require function
    /******/ function __webpack_require__(moduleId) {
      /** *** */
      /******/ // Check if module is in cache
      /******/ if (installedModules[moduleId]) {
        /******/ return installedModules[moduleId].exports;
        /******/
      }
      /******/ // Create a new module (and put it into the cache)
      /******/ var module = (installedModules[moduleId] = {
        /******/ i: moduleId,
        /******/ l: false,
        /******/ exports: {},
        /******/
      });
      /** *** */
      /******/ // Execute the module function
      /******/ modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
      /** *** */
      /******/ // Flag the module as loaded
      /******/ module.l = true;
      /** *** */
      /******/ // Return the exports of the module
      /******/ return module.exports;
      /******/
    }
    /** *** */
    /** *** */
    /******/ // expose the modules object (__webpack_modules__)
    /******/ __webpack_require__.m = modules;
    /** *** */
    /******/ // expose the module cache
    /******/ __webpack_require__.c = installedModules;
    /** *** */
    /******/ // identity function for calling harmony imports with the correct context
    /******/ __webpack_require__.i = function (value) {
      return value;
    };
    /** *** */
    /******/ // define getter function for harmony exports
    /******/ __webpack_require__.d = function (exports, name, getter) {
      /******/ if (!__webpack_require__.o(exports, name)) {
        /******/ Object.defineProperty(exports, name, {
          /******/ configurable: false,
          /******/ enumerable: true,
          /******/ get: getter,
          /******/
        });
        /******/
      }
      /******/
    };
    /** *** */
    /******/ // getDefaultExport function for compatibility with non-harmony modules
    /******/ __webpack_require__.n = function (module) {
      /******/ var getter =
        module && module.__esModule
          ? /******/ function getDefault() {
              return module['default'];
            }
          : /******/ function getModuleExports() {
              return module;
            };
      /******/ __webpack_require__.d(getter, 'a', getter);
      /******/ return getter;
      /******/
    };
    /** *** */
    /******/ // Object.prototype.hasOwnProperty.call
    /******/ __webpack_require__.o = function (object, property) {
      return Object.prototype.hasOwnProperty.call(object, property);
    };
    /** *** */
    /******/ // __webpack_public_path__
    /******/ __webpack_require__.p = '';
    /** *** */
    /******/ // Load entry module and return exports
    /******/ return __webpack_require__((__webpack_require__.s = 8));
    /******/
  })(
    /** ********************************************************************* */
    /******/ [
      /* 0 */
      /***/ function (module, exports, __webpack_require__) {
        'use strict';

        module.exports = function (obj) {
          return Object.prototype.toString.call(obj) === '[object Array]';
        };

        /***/
      },
      /* 1 */
      /***/ function (module, exports, __webpack_require__) {
        'use strict';

        var _createClass = (function () {
          function defineProperties(target, props) {
            for (var i = 0; i < props.length; i++) {
              var descriptor = props[i];
              descriptor.enumerable = descriptor.enumerable || false;
              descriptor.configurable = true;
              if ('value' in descriptor) descriptor.writable = true;
              Object.defineProperty(target, descriptor.key, descriptor);
            }
          }
          return function (Constructor, protoProps, staticProps) {
            if (protoProps) defineProperties(Constructor.prototype, protoProps);
            if (staticProps) defineProperties(Constructor, staticProps);
            return Constructor;
          };
        })();

        function _classCallCheck(instance, Constructor) {
          if (!(instance instanceof Constructor)) {
            throw new TypeError('Cannot call a class as a function');
          }
        }

        var bitapRegexSearch = __webpack_require__(5);
        var bitapSearch = __webpack_require__(7);
        var patternAlphabet = __webpack_require__(4);

let Bitap = function () {
          function Bitap(pattern, _ref) {
            var _ref$location = _ref.location;
        var location = _ref$location === undefined ? 0 : _ref$location;
        var _ref$distance = _ref.distance;
        var distance = _ref$distance === undefined ? 100 : _ref$distance;
        var _ref$threshold = _ref.threshold;
        var threshold = _ref$threshold === undefined ? 0.6 : _ref$threshold;
        var _ref$maxPatternLength = _ref.maxPatternLength;
        var maxPatternLength = _ref$maxPatternLength === undefined ? 32 : _ref$maxPatternLength;
        var _ref$isCaseSensitive = _ref.isCaseSensitive;
        var isCaseSensitive = _ref$isCaseSensitive === undefined ? false : _ref$isCaseSensitive;
        var _ref$tokenSeparator = _ref.tokenSeparator;
        var tokenSeparator = _ref$tokenSeparator === undefined ? / +/g : _ref$tokenSeparator;
        var _ref$findAllMatches = _ref.findAllMatches;
        var findAllMatches = _ref$findAllMatches === undefined ? false : _ref$findAllMatches;
        var _ref$minMatchCharLeng = _ref.minMatchCharLength;
        var minMatchCharLength = _ref$minMatchCharLeng === undefined ? 1 : _ref$minMatchCharLeng;

            _classCallCheck(this, Bitap);

            this.options = {
              location,
              distance: distance,
              threshold,
              maxPatternLength: maxPatternLength,
              isCaseSensitive,
              tokenSeparator,
              findAllMatches,
              minMatchCharLength: minMatchCharLength,
            };

            this.pattern = this.options.isCaseSensitive ? pattern : pattern.toLowerCase();

            if (this.pattern.length <= maxPatternLength) {
              this.patternAlphabet = patternAlphabet(this.pattern);
            }
          }

          _createClass(Bitap, [
            {
              key: 'search',
              value: function search(text) {
                if (!this.options.isCaseSensitive) {
                  text = text.toLowerCase();
                }

                // Exact match
                if (this.pattern === text) {
                  return {
                    isMatch: true,
                    score: 0,
                    matchedIndices: [[0, text.length - 1]],
                  };
                }

                // When pattern length is greater than the machine word length, just do a a regex comparison
                var _options = this.options;
          var maxPatternLength = _options.maxPatternLength;
          var tokenSeparator = _options.tokenSeparator;

                if (this.pattern.length > maxPatternLength) {
                  return bitapRegexSearch(text, this.pattern, tokenSeparator);
                }

                // Otherwise, use Bitap algorithm
                var _options2 = this.options;
          var location = _options2.location;
          var distance = _options2.distance;
          var threshold = _options2.threshold;
          var findAllMatches = _options2.findAllMatches;
          var minMatchCharLength = _options2.minMatchCharLength;

                return bitapSearch(text, this.pattern, this.patternAlphabet, {
                  location: location,
                  distance: distance,
                  threshold: threshold,
                  findAllMatches: findAllMatches,
                  minMatchCharLength: minMatchCharLength,
                });
              },
            },
          ]);

          return Bitap;
        })();

        // let x = new Bitap("od mn war", {})
        // let result = x.search("Old Man's War")
        // console.log(result)

        module.exports = Bitap;

        /***/
      },
      /* 2 */
      /***/ function (module, exports, __webpack_require__) {
        'use strict';

        var isArray = __webpack_require__(0);

        var deepValue = function deepValue(obj, path, list) {
          if (!path) {
            // If there's no path left, we've gotten to the object we care about.
            list.push(obj);
          } else {
            var dotIndex = path.indexOf('.');
            let firstSegment = path;
            var remaining = null;

            if (dotIndex !== -1) {
              firstSegment = path.slice(0, dotIndex);
              remaining = path.slice(dotIndex + 1);
            }

            let value = obj[firstSegment];

            if (value !== null && value !== undefined) {
              if (!remaining && (typeof value === 'string' || typeof value === 'number')) {
                list.push(value.toString());
              } else if (isArray(value)) {
                // Search each item in the array.
                for (let i = 0, len = value.length; i < len; i += 1) {
                  deepValue(value[i], remaining, list);
                }
              } else if (remaining) {
                // An object. Recurse further.
                deepValue(value, remaining, list);
              }
            }
          }

          return list;
        };

        module.exports = function (obj, path) {
          return deepValue(obj, path, []);
        };

        /***/
      },
      /* 3 */
      /***/ function (module, exports, __webpack_require__) {
        'use strict';

        module.exports = function () {
          let matchmask = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : [];
  let minMatchCharLength = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 1;

          let matchedIndices = [];
          let start = -1;
          let end = -1;
          var i = 0;

          for (let len = matchmask.length; i < len; i += 1) {
            var match = matchmask[i];
            if (match && start === -1) {
              start = i;
            } else if (!match && start !== -1) {
              end = i - 1;
              if (end - start + 1 >= minMatchCharLength) {
                matchedIndices.push([start, end]);
              }
              start = -1;
            }
          }

          // (i-1 - start) + 1 => i - start
          if (matchmask[i - 1] && i - start >= minMatchCharLength) {
            matchedIndices.push([start, i - 1]);
          }

          return matchedIndices;
        };

        /***/
      },
      /* 4 */
      /***/ function (module, exports, __webpack_require__) {
        'use strict';

        module.exports = function (pattern) {
          var mask = {};
          var len = pattern.length;

          for (let i = 0; i < len; i += 1) {
            mask[pattern.charAt(i)] = 0;
          }

          for (let _i = 0; _i < len; _i += 1) {
            mask[pattern.charAt(_i)] |= 1 << (len - _i - 1);
          }

          return mask;
        };

        /***/
      },
      /* 5 */
      /***/ function (module, exports, __webpack_require__) {
        'use strict';

        var SPECIAL_CHARS_REGEX = /[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g;

        module.exports = function (text, pattern) {
  let tokenSeparator = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : / +/g;

  let regex = new RegExp(pattern.replace(SPECIAL_CHARS_REGEX, '\\$&').replace(tokenSeparator, '|'));
          let matches = text.match(regex);
          var isMatch = !!matches;
          var matchedIndices = [];

          if (isMatch) {
            for (let i = 0, matchesLen = matches.length; i < matchesLen; i += 1) {
              var match = matches[i];
              matchedIndices.push([text.indexOf(match), match.length - 1]);
            }
          }

          return {
            // TODO: revisit this score
            score: isMatch ? 0.5 : 1,
            isMatch: isMatch,
            matchedIndices: matchedIndices,
          };
        };

        /***/
      },
      /* 6 */
      /***/ function (module, exports, __webpack_require__) {
        'use strict';

        module.exports = function (pattern, _ref) {
          var _ref$errors = _ref.errors;
      var errors = _ref$errors === undefined ? 0 : _ref$errors;
      var _ref$currentLocation = _ref.currentLocation;
      var currentLocation = _ref$currentLocation === undefined ? 0 : _ref$currentLocation;
      var _ref$expectedLocation = _ref.expectedLocation;
      var expectedLocation = _ref$expectedLocation === undefined ? 0 : _ref$expectedLocation;
      var _ref$distance = _ref.distance;
      var distance = _ref$distance === undefined ? 100 : _ref$distance;

          var accuracy = errors / pattern.length;
          var proximity = Math.abs(expectedLocation - currentLocation);

          if (!distance) {
            // Dodge divide by zero error.
            return proximity ? 1.0 : accuracy;
          }

          return accuracy + proximity / distance;
        };

        /***/
      },
      /* 7 */
      /***/ function (module, exports, __webpack_require__) {
        'use strict';

        var bitapScore = __webpack_require__(6);
        var matchedIndices = __webpack_require__(3);

        module.exports = function (text, pattern, patternAlphabet, _ref) {
          var _ref$location = _ref.location;
      var location = _ref$location === undefined ? 0 : _ref$location;
      var _ref$distance = _ref.distance;
      var distance = _ref$distance === undefined ? 100 : _ref$distance;
      var _ref$threshold = _ref.threshold;
      var threshold = _ref$threshold === undefined ? 0.6 : _ref$threshold;
      var _ref$findAllMatches = _ref.findAllMatches;
      var findAllMatches = _ref$findAllMatches === undefined ? false : _ref$findAllMatches;
      var _ref$minMatchCharLeng = _ref.minMatchCharLength;
      var minMatchCharLength = _ref$minMatchCharLeng === undefined ? 1 : _ref$minMatchCharLeng;

          var expectedLocation = location;
          // Set starting location at beginning text and initialize the alphabet.
          var textLen = text.length;
          // Highest score beyond which we give up.
          var currentThreshold = threshold;
          // Is there a nearby exact match? (speedup)
          let bestLocation = text.indexOf(pattern, expectedLocation);

          var patternLen = pattern.length;

          // a mask of the matches
          var matchMask = [];
          for (let i = 0; i < textLen; i += 1) {
            matchMask[i] = 0;
          }

          if (bestLocation !== -1) {
            let score = bitapScore(pattern, {
              errors: 0,
              currentLocation: bestLocation,
              expectedLocation: expectedLocation,
              distance: distance,
            });
            currentThreshold = Math.min(score, currentThreshold);

            // What about in the other direction? (speed up)
            bestLocation = text.lastIndexOf(pattern, expectedLocation + patternLen);

            if (bestLocation !== -1) {
              var _score = bitapScore(pattern, {
                errors: 0,
                currentLocation: bestLocation,
                expectedLocation: expectedLocation,
                distance: distance,
              });
              currentThreshold = Math.min(_score, currentThreshold);
            }
          }

          // Reset the best location
          bestLocation = -1;

          var lastBitArr = [];
          var finalScore = 1;
          let binMax = patternLen + textLen;

  let mask = 1 << patternLen - 1;

          for (let _i = 0; _i < patternLen; _i += 1) {
            // Scan for the best match; each iteration allows for one more error.
            // Run a binary search to determine how far from the match location we can stray
            // at this error level.
            var binMin = 0;
            var binMid = binMax;

            while (binMin < binMid) {
              var _score3 = bitapScore(pattern, {
                errors: _i,
                currentLocation: expectedLocation + binMid,
                expectedLocation,
                distance: distance,
              });

              if (_score3 <= currentThreshold) {
                binMin = binMid;
              } else {
                binMax = binMid;
              }

              binMid = Math.floor((binMax - binMin) / 2 + binMin);
            }

            // Use the result from this iteration as the maximum for the next.
            binMax = binMid;

            let start = Math.max(1, expectedLocation - binMid + 1);
    let finish = findAllMatches ? textLen : Math.min(expectedLocation + binMid, textLen) + patternLen;

            // Initialize the bit array
            var bitArr = Array(finish + 2);

            bitArr[finish + 1] = (1 << _i) - 1;

            for (let j = finish; j >= start; j -= 1) {
              let currentLocation = j - 1;
              var charMatch = patternAlphabet[text.charAt(currentLocation)];

              if (charMatch) {
                matchMask[currentLocation] = 1;
              }

              // First pass: exact match
              bitArr[j] = ((bitArr[j + 1] << 1) | 1) & charMatch;

              // Subsequent passes: fuzzy match
              if (_i !== 0) {
                bitArr[j] |= ((lastBitArr[j + 1] | lastBitArr[j]) << 1) | 1 | lastBitArr[j + 1];
              }

              if (bitArr[j] & mask) {
                finalScore = bitapScore(pattern, {
                  errors: _i,
                  currentLocation: currentLocation,
                  expectedLocation,
                  distance: distance,
                });

                // This match will almost certainly be better than any existing match.
                // But check anyway.
                if (finalScore <= currentThreshold) {
                  // Indeed it is
                  currentThreshold = finalScore;
                  bestLocation = currentLocation;

                  // Already passed `loc`, downhill from here on in.
                  if (bestLocation <= expectedLocation) {
                    break;
                  }

                  // When passing `bestLocation`, don't exceed our current distance from `expectedLocation`.
                  start = Math.max(1, 2 * expectedLocation - bestLocation);
                }
              }
            }

            // No hope for a (better) match at greater error levels.
            var _score2 = bitapScore(pattern, {
              errors: _i + 1,
              currentLocation: expectedLocation,
              expectedLocation: expectedLocation,
              distance: distance,
            });

            if (_score2 > currentThreshold) {
              break;
            }

            lastBitArr = bitArr;
          }

          // Count exact matches (those with a score of 0) to be "almost" exact
          return {
            isMatch: bestLocation >= 0,
            score: finalScore === 0 ? 0.001 : finalScore,
            matchedIndices: matchedIndices(matchMask, minMatchCharLength),
          };
        };

        /***/
      },
      /* 8 */
      /***/ function (module, exports, __webpack_require__) {
        'use strict';

        var _createClass = (function () {
          function defineProperties(target, props) {
            for (var i = 0; i < props.length; i++) {
              var descriptor = props[i];
              descriptor.enumerable = descriptor.enumerable || false;
              descriptor.configurable = true;
              if ('value' in descriptor) descriptor.writable = true;
              Object.defineProperty(target, descriptor.key, descriptor);
            }
          }
          return function (Constructor, protoProps, staticProps) {
            if (protoProps) defineProperties(Constructor.prototype, protoProps);
            if (staticProps) defineProperties(Constructor, staticProps);
            return Constructor;
          };
        })();

        function _classCallCheck(instance, Constructor) {
          if (!(instance instanceof Constructor)) {
            throw new TypeError('Cannot call a class as a function');
          }
        }

        var Bitap = __webpack_require__(1);
        var deepValue = __webpack_require__(2);
        var isArray = __webpack_require__(0);

let Fuse = function () {
          function Fuse(list, _ref) {
            var _ref$location = _ref.location;
        var location = _ref$location === undefined ? 0 : _ref$location;
        var _ref$distance = _ref.distance;
        var distance = _ref$distance === undefined ? 100 : _ref$distance;
        var _ref$threshold = _ref.threshold;
        var threshold = _ref$threshold === undefined ? 0.6 : _ref$threshold;
        var _ref$maxPatternLength = _ref.maxPatternLength;
        var maxPatternLength = _ref$maxPatternLength === undefined ? 32 : _ref$maxPatternLength;
        var _ref$caseSensitive = _ref.caseSensitive;
        var caseSensitive = _ref$caseSensitive === undefined ? false : _ref$caseSensitive;
        var _ref$tokenSeparator = _ref.tokenSeparator;
        var tokenSeparator = _ref$tokenSeparator === undefined ? / +/g : _ref$tokenSeparator;
        var _ref$findAllMatches = _ref.findAllMatches;
        var findAllMatches = _ref$findAllMatches === undefined ? false : _ref$findAllMatches;
        var _ref$minMatchCharLeng = _ref.minMatchCharLength;
        var minMatchCharLength = _ref$minMatchCharLeng === undefined ? 1 : _ref$minMatchCharLeng;
        var _ref$id = _ref.id;
        var id = _ref$id === undefined ? null : _ref$id;
        var _ref$keys = _ref.keys;
        var keys = _ref$keys === undefined ? [] : _ref$keys;
        var _ref$shouldSort = _ref.shouldSort;
        var shouldSort = _ref$shouldSort === undefined ? true : _ref$shouldSort;
        var _ref$getFn = _ref.getFn;
        var getFn = _ref$getFn === undefined ? deepValue : _ref$getFn;
        var _ref$sortFn = _ref.sortFn;
        var sortFn = _ref$sortFn === undefined ? function (a, b) {
      return a.score - b.score;
    } : _ref$sortFn;
        var _ref$tokenize = _ref.tokenize;
        var tokenize = _ref$tokenize === undefined ? false : _ref$tokenize;
        var _ref$matchAllTokens = _ref.matchAllTokens;
        var matchAllTokens = _ref$matchAllTokens === undefined ? false : _ref$matchAllTokens;
        var _ref$includeMatches = _ref.includeMatches;
        var includeMatches = _ref$includeMatches === undefined ? false : _ref$includeMatches;
        var _ref$includeScore = _ref.includeScore;
        var includeScore = _ref$includeScore === undefined ? false : _ref$includeScore;
        var _ref$verbose = _ref.verbose;
        var verbose = _ref$verbose === undefined ? false : _ref$verbose;

            _classCallCheck(this, Fuse);

            this.options = {
              location,
              distance,
              threshold: threshold,
              maxPatternLength: maxPatternLength,
              isCaseSensitive: caseSensitive,
              tokenSeparator: tokenSeparator,
              findAllMatches: findAllMatches,
              minMatchCharLength: minMatchCharLength,
              id: id,
              keys: keys,
              includeMatches,
              includeScore: includeScore,
              shouldSort: shouldSort,
              getFn: getFn,
              sortFn: sortFn,
              verbose: verbose,
              tokenize: tokenize,
              matchAllTokens: matchAllTokens,
            };

            this.setCollection(list);
          }

          _createClass(Fuse, [
            {
              key: 'setCollection',
              value: function setCollection(list) {
                this.list = list;
                return list;
              },
            },
            {
              key: 'search',
              value: function search(pattern) {
                this._log(`---------\nSearch pattern: "${  pattern  }"`);

                var _prepareSearchers2 = this._prepareSearchers(pattern);
          var tokenSearchers = _prepareSearchers2.tokenSearchers;
          var fullSearcher = _prepareSearchers2.fullSearcher;

                var _search2 = this._search(tokenSearchers, fullSearcher);
          var weights = _search2.weights;
          var results = _search2.results;

                this._computeScore(weights, results);

                if (this.options.shouldSort) {
                  this._sort(results);
                }

                return this._format(results);
              },
            },
            {
              key: '_prepareSearchers',
              value: function _prepareSearchers() {
      let pattern = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : '';

                var tokenSearchers = [];

                if (this.options.tokenize) {
                  // Tokenize on the separator
                  let tokens = pattern.split(this.options.tokenSeparator);
                  for (let i = 0, len = tokens.length; i < len; i += 1) {
                    tokenSearchers.push(new Bitap(tokens[i], this.options));
                  }
                }

                let fullSearcher = new Bitap(pattern, this.options);

                return { tokenSearchers, fullSearcher };
              },
            },
            {
              key: '_search',
              value: function _search() {
      let tokenSearchers = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : [];
                var fullSearcher = arguments[1];

                let list = this.list;
                let resultMap = {};
                var results = [];

                // Check the first item in the list, if it's a string, then we assume
                // that every item in the list is also a string, and thus it's a flattened array.
                if (typeof list[0] === 'string') {
                  // Iterate over every item
                  for (let i = 0, len = list.length; i < len; i += 1) {
                    this._analyze(
                      {
                        key: '',
                        value: list[i],
                        record: i,
                        index: i,
                      },
                      {
                        resultMap: resultMap,
                        results: results,
                        tokenSearchers,
                        fullSearcher: fullSearcher,
                      }
                    );
                  }

                  return { weights: null, results };
                }

                /*
       * Otherwise, the first item is an Object (hopefully), and thus the searching
       * is done on the values of the keys of each item.
       */
                var weights = {};
                for (let _i = 0, _len = list.length; _i < _len; _i += 1) {
                  var item = list[_i];
                  // Iterate over every key
                  for (let j = 0, keysLen = this.options.keys.length; j < keysLen; j += 1) {
                    var key = this.options.keys[j];
                    if (typeof key !== 'string') {
                      weights[key.name] = {
                        weight: 1 - key.weight || 1,
                      };
                      if (key.weight <= 0 || key.weight > 1) {
                        throw new Error('Key weight has to be > 0 and <= 1');
                      }
                      key = key.name;
                    } else {
                      weights[key] = {
                        weight: 1,
                      };
                    }

                    this._analyze(
                      {
                        key: key,
                        value: this.options.getFn(item, key),
                        record: item,
                        index: _i,
                      },
                      {
                        resultMap: resultMap,
                        results: results,
                        tokenSearchers: tokenSearchers,
                        fullSearcher: fullSearcher,
                      }
                    );
                  }
                }

                return { weights, results };
              },
            },
            {
              key: '_analyze',
              value: function _analyze(_ref2, _ref3) {
                var key = _ref2.key;
          var _ref2$arrayIndex = _ref2.arrayIndex;
          var arrayIndex = _ref2$arrayIndex === undefined ? -1 : _ref2$arrayIndex;
          var value = _ref2.value;
          var record = _ref2.record;
          var index = _ref2.index;
                let _ref3$tokenSearchers = _ref3.tokenSearchers;
          var tokenSearchers = _ref3$tokenSearchers === undefined ? [] : _ref3$tokenSearchers;
          var _ref3$fullSearcher = _ref3.fullSearcher;
          var fullSearcher = _ref3$fullSearcher === undefined ? [] : _ref3$fullSearcher;
          var _ref3$resultMap = _ref3.resultMap;
          var resultMap = _ref3$resultMap === undefined ? {} : _ref3$resultMap;
          var _ref3$results = _ref3.results;
          var results = _ref3$results === undefined ? [] : _ref3$results;

                // Check if the texvaluet can be searched
                if (value === undefined || value === null) {
                  return;
                }

                let exists = false;
                let averageScore = -1;
                var numTextMatches = 0;

                if (typeof value === 'string') {
                  this._log(`\nKey: ${  key === '' ? '-' : key}`);

                  var mainSearchResult = fullSearcher.search(value);
                  this._log(`Full text: "${  value  }", score: ${  mainSearchResult.score}`);

                  if (this.options.tokenize) {
                    var words = value.split(this.options.tokenSeparator);
                    var scores = [];

                    for (let i = 0; i < tokenSearchers.length; i += 1) {
                      var tokenSearcher = tokenSearchers[i];

                      this._log(`\nPattern: "${  tokenSearcher.pattern  }"`);

                      // let tokenScores = []
                      let hasMatchInText = false;

                      for (let j = 0; j < words.length; j += 1) {
                        var word = words[j];
                        let tokenSearchResult = tokenSearcher.search(word);
                        var obj = {};
                        if (tokenSearchResult.isMatch) {
                          obj[word] = tokenSearchResult.score;
                          exists = true;
                          hasMatchInText = true;
                          scores.push(tokenSearchResult.score);
                        } else {
                          obj[word] = 1;
                          if (!this.options.matchAllTokens) {
                            scores.push(1);
                          }
                        }
                        this._log(`Token: "${  word  }", score: ${  obj[word]}`);
                        // tokenScores.push(obj)
                      }

                      if (hasMatchInText) {
                        numTextMatches += 1;
                      }
                    }

                    averageScore = scores[0];
                    var scoresLen = scores.length;
                    for (let _i2 = 1; _i2 < scoresLen; _i2 += 1) {
                      averageScore += scores[_i2];
                    }
                    averageScore /= scoresLen;

                    this._log('Token score average:', averageScore);
                  }

                  let finalScore = mainSearchResult.score;
                  if (averageScore > -1) {
                    finalScore = (finalScore + averageScore) / 2;
                  }

                  this._log('Score average:', finalScore);

        let checkTextMatches = this.options.tokenize && this.options.matchAllTokens ? numTextMatches >= tokenSearchers.length : true;

                  this._log(`\nCheck Matches: ${  checkTextMatches}`);

                  // If a match is found, add the item to <rawResults>, including its score
                  if ((exists || mainSearchResult.isMatch) && checkTextMatches) {
                    // Check if the item already exists in our results
                    var existingResult = resultMap[index];
                    if (existingResult) {
                      // Use the lowest score
                      // existingResult.score, bitapResult.score
                      existingResult.output.push({
                        key: key,
                        arrayIndex: arrayIndex,
                        value: value,
                        score: finalScore,
                        matchedIndices: mainSearchResult.matchedIndices,
                      });
                    } else {
                      // Add it to the raw result list
                      resultMap[index] = {
                        item: record,
                        output: [
                          {
                            key: key,
                            arrayIndex,
                            value: value,
                            score: finalScore,
                            matchedIndices: mainSearchResult.matchedIndices,
                          },
                        ],
                      };

                      results.push(resultMap[index]);
                    }
                  }
                } else if (isArray(value)) {
                  for (let _i3 = 0, len = value.length; _i3 < len; _i3 += 1) {
                    this._analyze(
                      {
                        key,
                        arrayIndex: _i3,
                        value: value[_i3],
                        record: record,
                        index: index,
                      },
                      {
                        resultMap: resultMap,
                        results: results,
                        tokenSearchers: tokenSearchers,
                        fullSearcher: fullSearcher,
                      }
                    );
                  }
                }
              },
            },
            {
              key: '_computeScore',
              value: function _computeScore(weights, results) {
                this._log('\n\nComputing score:\n');

                for (let i = 0, len = results.length; i < len; i += 1) {
                  var output = results[i].output;
                  var scoreLen = output.length;

                  var totalScore = 0;
                  let bestScore = 1;

                  for (let j = 0; j < scoreLen; j += 1) {
                    var weight = weights ? weights[output[j].key].weight : 1;
                    let score = weight === 1 ? output[j].score : output[j].score || 0.001;
                    var nScore = score * weight;

                    if (weight !== 1) {
                      bestScore = Math.min(bestScore, nScore);
                    } else {
                      output[j].nScore = nScore;
                      totalScore += nScore;
                    }
                  }

                  results[i].score = bestScore === 1 ? totalScore / scoreLen : bestScore;

                  this._log(results[i]);
                }
              },
            },
            {
              key: '_sort',
              value: function _sort(results) {
                this._log('\n\nSorting....');
                results.sort(this.options.sortFn);
              },
            },
            {
              key: '_format',
              value: function _format(results) {
                var finalOutput = [];

                this._log('\n\nOutput:\n\n', JSON.stringify(results));

                var transformers = [];

                if (this.options.includeMatches) {
                  transformers.push((result, data) => {
                    var output = result.output;
                    data.matches = [];

                    for (let i = 0, len = output.length; i < len; i += 1) {
                      var item = output[i];

                      if (item.matchedIndices.length === 0) {
                        continue;
                      }

                      let obj = {
                        indices: item.matchedIndices,
                        value: item.value,
                      };
                      if (item.key) {
                        obj.key = item.key;
                      }
                      if (item.hasOwnProperty('arrayIndex') && item.arrayIndex > -1) {
                        obj.arrayIndex = item.arrayIndex;
                      }
                      data.matches.push(obj);
                    }
                  });
                }

                if (this.options.includeScore) {
                  transformers.push((result, data) => {
                    data.score = result.score;
                  });
                }

                for (let i = 0, len = results.length; i < len; i += 1) {
                  var result = results[i];

                  if (this.options.id) {
                    result.item = this.options.getFn(result.item, this.options.id)[0];
                  }

                  if (!transformers.length) {
                    finalOutput.push(result.item);
                    continue;
                  }

                  var data = {
                    item: result.item,
                  };

                  for (let j = 0, _len2 = transformers.length; j < _len2; j += 1) {
                    transformers[j](result, data);
                  }

                  finalOutput.push(data);
                }

                return finalOutput;
              },
            },
            {
              key: '_log',
              value: function _log() {
                if (this.options.verbose) {
                  var _console;

                  (_console = console).log.apply(_console, arguments);
                }
              },
            },
          ]);

          return Fuse;
        })();

        module.exports = Fuse;

        /***/
      },
      /******/
    ]
  );
});
// # sourceMappingURL=fuse.js.map
