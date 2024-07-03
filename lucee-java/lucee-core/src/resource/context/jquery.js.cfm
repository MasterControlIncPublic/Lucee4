<cfcontent type="text/javascript"><cfsetting showdebugoutput="no">
/*!
* jQuery JavaScript Library v3.7.0
* https://jquery.com/
*
* Copyright OpenJS Foundation and other contributors
* Released under the MIT license
* https://jquery.org/license
*
* Includes Sizzle.js
* http://sizzlejs.com/
* Copyright 2011, The Dojo Foundation
* Released under the MIT, BSD, and GPL Licenses.
*
* Date: 2023-05-11T18:29Z
*/
( function( global, factory ) {

"use strict";

if ( typeof module === "object" && typeof module.exports === "object" ) {

// For CommonJS and CommonJS-like environments where a proper `window`
// is present, execute the factory and get jQuery.
// For environments that do not have a `window` with a `document`
// (such as Node.js), expose a factory as module.exports.
// This accentuates the need for the creation of a real `window`.
// e.g. var jQuery = require("jquery")(window);
// See ticket trac-14549 for more info.
module.exports = global.document ?
factory( global, true ) :
function( w ) {
if ( !w.document ) {
throw new Error( "jQuery requires a window with a document" );
}
return factory( w );
};
} else {
factory( global );
}

// Pass this if window is not defined yet
} )( typeof window !== "undefined" ? window : this, function( window, noGlobal ) {

// Edge <= 12 - 13+, Firefox <=18 - 45+, IE 10 - 11, Safari 5.1 - 9+, iOS 6 - 9.1
// throw exceptions when non-strict code (e.g., ASP.NET 4.5) accesses strict mode
// arguments.callee.caller (trac-13335). But as of jQuery 3.0 (2016), strict mode should be common
// enough that all such attempts are guarded in a try block.
"use strict";

var arr = [];

var getProto = Object.getPrototypeOf;

var slice = arr.slice;

var flat = arr.flat ? function( array ) {
return arr.flat.call( array );
} : function( array ) {
return arr.concat.apply( [], array );
};


var push = arr.push;

var indexOf = arr.indexOf;

var class2type = {};

var toString = class2type.toString;

var hasOwn = class2type.hasOwnProperty;

var fnToString = hasOwn.toString;

var ObjectFunctionString = fnToString.call( Object );

var support = {};

var isFunction = function isFunction( obj ) {

// Support: Chrome <=57, Firefox <=52
// In some browsers, typeof returns "function" for HTML
<object> elements
	// (i.e., `typeof document.createElement( "object" ) === "function"`).
	// We don't want to classify *any* DOM node as a function.
	// Support: QtWeb <=3.8.5, WebKit <=534.34, wkhtmltopdf tool <=0.12.5
	// Plus for old WebKit, typeof returns "function" for HTML collections
	// (e.g., `typeof document.getElementsByTagName("div") === "function"`). (gh-4756)
	return typeof obj === "function" && typeof obj.nodeType !== "number" &&
	typeof obj.item !== "function";
	};


	var isWindow = function isWindow( obj ) {
	return obj != null && obj === obj.window;
	};


	var document = window.document;


	var preservedScriptAttributes = {
	type: true,
	src: true,
	nonce: true,
	noModule: true
	};

	function DOMEval( code, node, doc ) {
	doc = doc || document;

	var i, val,
	script = doc.createElement( "script" );

	script.text = code;
	if ( node ) {
	for ( i in preservedScriptAttributes ) {

	// Support: Firefox 64+, Edge 18+
	// Some browsers don't support the "nonce" property on scripts.
	// On the other hand, just using `getAttribute` is not enough as
	// the `nonce` attribute is reset to an empty string whenever it
	// becomes browsing-context connected.
	// See https://github.com/whatwg/html/issues/2369
	// See https://html.spec.whatwg.org/#nonce-attributes
	// The `node.getAttribute` check was added for the sake of
	// `jQuery.globalEval` so that it can fake a nonce-containing node
	// via an object.
	val = node[ i ] || node.getAttribute && node.getAttribute( i );
	if ( val ) {
	script.setAttribute( i, val );
	}
	}
	}
	doc.head.appendChild( script ).parentNode.removeChild( script );
	}


	function toType( obj ) {
	if ( obj == null ) {
	return obj + "";
	}

	// Support: Android <=2.3 only (functionish RegExp)
	return typeof obj === "object" || typeof obj === "function" ?
	class2type[ toString.call( obj ) ] || "object" :
	typeof obj;
	}
	/* global Symbol */
	// Defining this global in .eslintrc.json would create a danger of using the global
	// unguarded in another place, it seems safer to define global only for this module


	var version = "3.7.0",

	rhtmlSuffix = /HTML$/i,

	// Define a local copy of jQuery
	jQuery = function( selector, context ) {

	// The jQuery object is actually just the init constructor 'enhanced'
	// Need init if jQuery is called (just allow error to be thrown if not included)
	return new jQuery.fn.init( selector, context );
	};

	jQuery.fn = jQuery.prototype = {

	// The current version of jQuery being used
	jquery: version,

	constructor: jQuery,

	// The default length of a jQuery object is 0
	length: 0,

	toArray: function() {
	return slice.call( this );
	},

	// Get the Nth element in the matched element set OR
	// Get the whole matched element set as a clean array
	get: function( num ) {

	// Return all the elements in a clean array
	if ( num == null ) {
	return slice.call( this );
	}

	// Return just the one element from the set
	return num < 0 ? this[ num + this.length ] : this[ num ];
	},

	// Take an array of elements and push it onto the stack
	// (returning the new matched element set)
	pushStack: function( elems ) {

	// Build a new jQuery matched element set
	var ret = jQuery.merge( this.constructor(), elems );

	// Add the old object onto the stack (as a reference)
	ret.prevObject = this;

	// Return the newly-formed element set
	return ret;
	},

	// Execute a callback for every element in the matched set.
	each: function( callback ) {
	return jQuery.each( this, callback );
	},

	map: function( callback ) {
	return this.pushStack( jQuery.map( this, function( elem, i ) {
	return callback.call( elem, i, elem );
	} ) );
	},

	slice: function() {
	return this.pushStack( slice.apply( this, arguments ) );
	},

	first: function() {
	return this.eq( 0 );
	},

	last: function() {
	return this.eq( -1 );
	},

	even: function() {
	return this.pushStack( jQuery.grep( this, function( _elem, i ) {
	return ( i + 1 ) % 2;
	} ) );
	},

	odd: function() {
	return this.pushStack( jQuery.grep( this, function( _elem, i ) {
	return i % 2;
	} ) );
	},

	eq: function( i ) {
	var len = this.length,
	j = +i + ( i < 0 ? len : 0 );
	return this.pushStack( j >= 0 && j < len ? [ this[ j ] ] : [] );
	},

	end: function() {
	return this.prevObject || this.constructor();
	},

	// For internal use only.
	// Behaves like an Array's method, not like a jQuery method.
	push: push,
	sort: arr.sort,
	splice: arr.splice
	};

	jQuery.extend = jQuery.fn.extend = function() {
	var options, name, src, copy, copyIsArray, clone,
	target = arguments[ 0 ] || {},
	i = 1,
	length = arguments.length,
	deep = false;

	// Handle a deep copy situation
	if ( typeof target === "boolean" ) {
	deep = target;

	// Skip the boolean and the target
	target = arguments[ i ] || {};
	i++;
	}

	// Handle case when target is a string or something (possible in deep copy)
	if ( typeof target !== "object" && !isFunction( target ) ) {
	target = {};
	}

	// Extend jQuery itself if only one argument is passed
	if ( i === length ) {
	target = this;
	i--;
	}

	for ( ; i < length; i++ ) {

	// Only deal with non-null/undefined values
	if ( ( options = arguments[ i ] ) != null ) {

	// Extend the base object
	for ( name in options ) {
	copy = options[ name ];

	// Prevent Object.prototype pollution
	// Prevent never-ending loop
	if ( name === "__proto__" || target === copy ) {
	continue;
	}

	// Recurse if we're merging plain objects or arrays
	if ( deep && copy && ( jQuery.isPlainObject( copy ) ||
	( copyIsArray = Array.isArray( copy ) ) ) ) {
	src = target[ name ];

	// Ensure proper type for the source value
	if ( copyIsArray && !Array.isArray( src ) ) {
	clone = [];
	} else if ( !copyIsArray && !jQuery.isPlainObject( src ) ) {
	clone = {};
	} else {
	clone = src;
	}
	copyIsArray = false;

	// Never move original objects, clone them
	target[ name ] = jQuery.extend( deep, clone, copy );

	// Don't bring in undefined values
	} else if ( copy !== undefined ) {
	target[ name ] = copy;
	}
	}
	}
	}

	// Return the modified object
	return target;
	};

	jQuery.extend( {

	// Unique for each copy of jQuery on the page
	expando: "jQuery" + ( version + Math.random() ).replace( /\D/g, "" ),

	// Assume jQuery is ready without the ready module
	isReady: true,

	error: function( msg ) {
	throw new Error( msg );
	},

	noop: function() {},

	isPlainObject: function( obj ) {
	var proto, Ctor;

	// Detect obvious negatives
	// Use toString instead of jQuery.type to catch host objects
	if ( !obj || toString.call( obj ) !== "[object Object]" ) {
	return false;
	}

	proto = getProto( obj );

	// Objects with no prototype (e.g., `Object.create( null )`) are plain
	if ( !proto ) {
	return true;
	}

	// Objects with prototype are plain iff they were constructed by a global Object function
	Ctor = hasOwn.call( proto, "constructor" ) && proto.constructor;
	return typeof Ctor === "function" && fnToString.call( Ctor ) === ObjectFunctionString;
	},

	isEmptyObject: function( obj ) {
	var name;

	for ( name in obj ) {
	return false;
	}
	return true;
	},

	// Evaluates a script in a provided context; falls back to the global one
	// if not specified.
	globalEval: function( code, options, doc ) {
	DOMEval( code, { nonce: options && options.nonce }, doc );
	},

	each: function( obj, callback ) {
	var length, i = 0;

	if ( isArrayLike( obj ) ) {
	length = obj.length;
	for ( ; i < length; i++ ) {
	if ( callback.call( obj[ i ], i, obj[ i ] ) === false ) {
	break;
	}
	}
	} else {
	for ( i in obj ) {
	if ( callback.call( obj[ i ], i, obj[ i ] ) === false ) {
	break;
	}
	}
	}

	return obj;
	},


	// Retrieve the text value of an array of DOM nodes
	text: function( elem ) {
	var node,
	ret = "",
	i = 0,
	nodeType = elem.nodeType;

	if ( !nodeType ) {

	// If no nodeType, this is expected to be an array
	while ( ( node = elem[ i++ ] ) ) {

	// Do not traverse comment nodes
	ret += jQuery.text( node );
	}
	} else if ( nodeType === 1 || nodeType === 9 || nodeType === 11 ) {
	return elem.textContent;
	} else if ( nodeType === 3 || nodeType === 4 ) {
	return elem.nodeValue;
	}

	// Do not include comment or processing instruction nodes

	return ret;
	},

	// results is for internal usage only
	makeArray: function( arr, results ) {
	var ret = results || [];

	if ( arr != null ) {
	if ( isArrayLike( Object( arr ) ) ) {
	jQuery.merge( ret,
	typeof arr === "string" ?
	[ arr ] : arr
	);
	} else {
	push.call( ret, arr );
	}
	}

	return ret;
	},

	inArray: function( elem, arr, i ) {
	return arr == null ? -1 : indexOf.call( arr, elem, i );
	},

	isXMLDoc: function( elem ) {
	var namespace = elem && elem.namespaceURI,
	docElem = elem && ( elem.ownerDocument || elem ).documentElement;

	// Assume HTML when documentElement doesn't yet exist, such as inside
	// document fragments.
	return !rhtmlSuffix.test( namespace || docElem && docElem.nodeName || "HTML" );
	},

	// Support: Android <=4.0 only, PhantomJS 1 only
	// push.apply(_, arraylike) throws on ancient WebKit
	merge: function( first, second ) {
	var len = +second.length,
	j = 0,
	i = first.length;

	for ( ; j < len; j++ ) {
	first[ i++ ] = second[ j ];
	}

	first.length = i;

	return first;
	},

	grep: function( elems, callback, invert ) {
	var callbackInverse,
	matches = [],
	i = 0,
	length = elems.length,
	callbackExpect = !invert;

	// Go through the array, only saving the items
	// that pass the validator function
	for ( ; i < length; i++ ) {
	callbackInverse = !callback( elems[ i ], i );
	if ( callbackInverse !== callbackExpect ) {
	matches.push( elems[ i ] );
	}
	}

	return matches;
	},

	// arg is for internal usage only
	map: function( elems, callback, arg ) {
	var length, value,
	i = 0,
	ret = [];

	// Go through the array, translating each of the items to their new values
	if ( isArrayLike( elems ) ) {
	length = elems.length;
	for ( ; i < length; i++ ) {
	value = callback( elems[ i ], i, arg );

	if ( value != null ) {
	ret.push( value );
	}
	}

	// Go through every key on the object,
	} else {
	for ( i in elems ) {
	value = callback( elems[ i ], i, arg );

	if ( value != null ) {
	ret.push( value );
	}
	}
	}

	// Flatten any nested arrays
	return flat( ret );
	},

	// A global GUID counter for objects
	guid: 1,

	// jQuery.support is not used in Core but other projects attach their
	// properties to it so it needs to exist.
	support: support
	} );

	if ( typeof Symbol === "function" ) {
	jQuery.fn[ Symbol.iterator ] = arr[ Symbol.iterator ];
	}

	// Populate the class2type map
	jQuery.each( "Boolean Number String Function Array Date RegExp Object Error Symbol".split( " " ),
	function( _i, name ) {
	class2type[ "[object " + name + "]" ] = name.toLowerCase();
	} );

	function isArrayLike( obj ) {

	// Support: real iOS 8.2 only (not reproducible in simulator)
	// `in` check used to prevent JIT error (gh-2145)
	// hasOwn isn't used here due to false negatives
	// regarding Nodelist length in IE
	var length = !!obj && "length" in obj && obj.length,
	type = toType( obj );

	if ( isFunction( obj ) || isWindow( obj ) ) {
	return false;
	}

	return type === "array" || length === 0 ||
	typeof length === "number" && length > 0 && ( length - 1 ) in obj;
	}


	function nodeName( elem, name ) {

	return elem.nodeName && elem.nodeName.toLowerCase() === name.toLowerCase();

	}
	var pop = arr.pop;


	var sort = arr.sort;


	var splice = arr.splice;


	var whitespace = "[\\x20\\t\\r\\n\\f]";


	var rtrimCSS = new RegExp(
	"^" + whitespace + "+|((?:^|[^\\\\])(?:\\\\.)*)" + whitespace + "+$",
	"g"
	);


	// Note: an element does not contain itself
	jQuery.contains = function( a, b ) {
	var bup = b && b.parentNode;

	return a === bup || !!( bup && bup.nodeType === 1 && (

	// Support: IE 9 - 11+
	// IE doesn't have `contains` on SVG.
	a.contains ?
	a.contains( bup ) :
	a.compareDocumentPosition && a.compareDocumentPosition( bup ) & 16
	) );
	};


	// CSS string/identifier serialization
	// https://drafts.csswg.org/cssom/#common-serializing-idioms
	var rcssescape = /([\0-\x1f\x7f]|^-?\d)|^-$|[^\x80-\uFFFF\w-]/g;

	function fcssescape( ch, asCodePoint ) {
	if ( asCodePoint ) {

	// U+0000 NULL becomes U+FFFD REPLACEMENT CHARACTER
	if ( ch === "\0" ) {
	return "\uFFFD";
	}

	// Control characters and (dependent upon position) numbers get escaped as code points
	return ch.slice( 0, -1 ) + "\\" + ch.charCodeAt( ch.length - 1 ).toString( 16 ) + " ";
	}

	// Other potentially-special ASCII characters get backslash-escaped
	return "\\" + ch;
	}

	jQuery.escapeSelector = function( sel ) {
	return ( sel + "" ).replace( rcssescape, fcssescape );
	};


	var preferredDoc = document,
	pushNative = push;

	( function() {

	var i,
	Expr,
	outermostContext,
	sortInput,
	hasDuplicate,
	push = pushNative,

	// Local document vars
	document,
	documentElement,
	documentIsHTML,
	rbuggyQSA,
	matches,

	// Instance-specific data
	expando = jQuery.expando,
	dirruns = 0,
	done = 0,
	classCache = createCache(),
	tokenCache = createCache(),
	compilerCache = createCache(),
	nonnativeSelectorCache = createCache(),
	sortOrder = function( a, b ) {
	if ( a === b ) {
	hasDuplicate = true;
	}
	return 0;
	},

	booleans = "checked|selected|async|autofocus|autoplay|controls|defer|disabled|hidden|ismap|" +
	"loop|multiple|open|readonly|required|scoped",

	// Regular expressions

	// https://www.w3.org/TR/css-syntax-3/#ident-token-diagram
	identifier = "(?:\\\\[\\da-fA-F]{1,6}" + whitespace +
	"?|\\\\[^\\r\\n\\f]|[\\w-]|[^\0-\\x7f])+",

	// Attribute selectors: https://www.w3.org/TR/selectors/#attribute-selectors
	attributes = "\\[" + whitespace + "*(" + identifier + ")(?:" + whitespace +

	// Operator (capture 2)
	"*([*^$|!~]?=)" + whitespace +

	// "Attribute values must be CSS identifiers [capture 5] or strings [capture 3 or capture 4]"
	"*(?:'((?:\\\\.|[^\\\\'])*)'|\"((?:\\\\.|[^\\\\\"])*)\"|(" + identifier + "))|)" +
	whitespace + "*\\]",

	pseudos = ":(" + identifier + ")(?:\\((" +

	// To reduce the number of selectors needing tokenize in the preFilter, prefer arguments:
	// 1. quoted (capture 3; capture 4 or capture 5)
	"('((?:\\\\.|[^\\\\'])*)'|\"((?:\\\\.|[^\\\\\"])*)\")|" +

	// 2. simple (capture 6)
	"((?:\\\\.|[^\\\\()[\\]]|" + attributes + ")*)|" +

	// 3. anything else (capture 2)
	".*" +
	")\\)|)",

	// Leading and non-escaped trailing whitespace, capturing some non-whitespace characters preceding the latter
	rwhitespace = new RegExp( whitespace + "+", "g" ),

	rcomma = new RegExp( "^" + whitespace + "*," + whitespace + "*" ),
	rleadingCombinator = new RegExp( "^" + whitespace + "*([>+~]|" + whitespace + ")" +
	whitespace + "*" ),
	rdescend = new RegExp( whitespace + "|>" ),

	rpseudo = new RegExp( pseudos ),
	ridentifier = new RegExp( "^" + identifier + "$" ),

	matchExpr = {
	ID: new RegExp( "^#(" + identifier + ")" ),
	CLASS: new RegExp( "^\\.(" + identifier + ")" ),
	TAG: new RegExp( "^(" + identifier + "|[*])" ),
	ATTR: new RegExp( "^" + attributes ),
	PSEUDO: new RegExp( "^" + pseudos ),
	CHILD: new RegExp(
	"^:(only|first|last|nth|nth-last)-(child|of-type)(?:\\(" +
	whitespace + "*(even|odd|(([+-]|)(\\d*)n|)" + whitespace + "*(?:([+-]|)" +
	whitespace + "*(\\d+)|))" + whitespace + "*\\)|)", "i" ),
	bool: new RegExp( "^(?:" + booleans + ")$", "i" ),

	// For use in libraries implementing .is()
	// We use this for POS matching in `select`
	needsContext: new RegExp( "^" + whitespace +
	"*[>+~]|:(even|odd|eq|gt|lt|nth|first|last)(?:\\(" + whitespace +
	"*((?:-\\d)?\\d*)" + whitespace + "*\\)|)(?=[^-]|$)", "i" )
	},

	rinputs = /^(?:input|select|textarea|button)$/i,
	rheader = /^h\d$/i,

	// Easily-parseable/retrievable ID or TAG or CLASS selectors
	rquickExpr = /^(?:#([\w-]+)|(\w+)|\.([\w-]+))$/,

	rsibling = /[+~]/,

	// CSS escapes
	// https://www.w3.org/TR/CSS21/syndata.html#escaped-characters
	runescape = new RegExp( "\\\\[\\da-fA-F]{1,6}" + whitespace +
	"?|\\\\([^\\r\\n\\f])", "g" ),
	funescape = function( escape, nonHex ) {
	var high = "0x" + escape.slice( 1 ) - 0x10000;

	if ( nonHex ) {

	// Strip the backslash prefix from a non-hex escape sequence
	return nonHex;
	}

	// Replace a hexadecimal escape sequence with the encoded Unicode code point
	// Support: IE <=11+
	// For values outside the Basic Multilingual Plane (BMP), manually construct a
	// surrogate pair
	return high < 0 ?
	String.fromCharCode( high + 0x10000 ) :
	String.fromCharCode( high >> 10 | 0xD800, high & 0x3FF | 0xDC00 );
	},

	// Used for iframes; see `setDocument`.
	// Support: IE 9 - 11+, Edge 12 - 18+
	// Removing the function wrapper causes a "Permission Denied"
	// error in IE/Edge.
	unloadHandler = function() {
	setDocument();
	},

	inDisabledFieldset = addCombinator(
	function( elem ) {
	return elem.disabled === true && nodeName( elem, "fieldset" );
	},
	{ dir: "parentNode", next: "legend" }
	);

	// Support: IE <=9 only
	// Accessing document.activeElement can throw unexpectedly
	// https://bugs.jquery.com/ticket/13393
	function safeActiveElement() {
	try {
	return document.activeElement;
	} catch ( err ) { }
	}

	// Optimize for push.apply( _, NodeList )
	try {
	push.apply(
	( arr = slice.call( preferredDoc.childNodes ) ),
	preferredDoc.childNodes
	);

	// Support: Android <=4.0
	// Detect silently failing push.apply
	// eslint-disable-next-line no-unused-expressions
	arr[ preferredDoc.childNodes.length ].nodeType;
	} catch ( e ) {
	push = {
	apply: function( target, els ) {
	pushNative.apply( target, slice.call( els ) );
	},
	call: function( target ) {
	pushNative.apply( target, slice.call( arguments, 1 ) );
	}
	};
	}

	function find( selector, context, results, seed ) {
	var m, i, elem, nid, match, groups, newSelector,
	newContext = context && context.ownerDocument,

	// nodeType defaults to 9, since context defaults to document
	nodeType = context ? context.nodeType : 9;

	results = results || [];

	// Return early from calls with invalid selector or context
	if ( typeof selector !== "string" || !selector ||
	nodeType !== 1 && nodeType !== 9 && nodeType !== 11 ) {

	return results;
	}

	// Try to shortcut find operations (as opposed to filters) in HTML documents
	if ( !seed ) {
	setDocument( context );
	context = context || document;

	if ( documentIsHTML ) {

	// If the selector is sufficiently simple, try using a "get*By*" DOM method
	// (excepting DocumentFragment context, where the methods don't exist)
	if ( nodeType !== 11 && ( match = rquickExpr.exec( selector ) ) ) {

	// ID selector
	if ( ( m = match[ 1 ] ) ) {

	// Document context
	if ( nodeType === 9 ) {
	if ( ( elem = context.getElementById( m ) ) ) {

	// Support: IE 9 only
	// getElementById can match elements by name instead of ID
	if ( elem.id === m ) {
	push.call( results, elem );
	return results;
	}
	} else {
	return results;
	}

	// Element context
	} else {

	// Support: IE 9 only
	// getElementById can match elements by name instead of ID
	if ( newContext && ( elem = newContext.getElementById( m ) ) &&
	find.contains( context, elem ) &&
	elem.id === m ) {

	push.call( results, elem );
	return results;
	}
	}

	// Type selector
	} else if ( match[ 2 ] ) {
	push.apply( results, context.getElementsByTagName( selector ) );
	return results;

	// Class selector
	} else if ( ( m = match[ 3 ] ) && context.getElementsByClassName ) {
	push.apply( results, context.getElementsByClassName( m ) );
	return results;
	}
	}

	// Take advantage of querySelectorAll
	if ( !nonnativeSelectorCache[ selector + " " ] &&
	( !rbuggyQSA || !rbuggyQSA.test( selector ) ) ) {

	newSelector = selector;
	newContext = context;

	// qSA considers elements outside a scoping root when evaluating child or
	// descendant combinators, which is not what we want.
	// In such cases, we work around the behavior by prefixing every selector in the
	// list with an ID selector referencing the scope context.
	// The technique has to be used as well when a leading combinator is used
	// as such selectors are not recognized by querySelectorAll.
	// Thanks to Andrew Dupont for this technique.
	if ( nodeType === 1 &&
	( rdescend.test( selector ) || rleadingCombinator.test( selector ) ) ) {

	// Expand context for sibling selectors
	newContext = rsibling.test( selector ) && testContext( context.parentNode ) ||
	context;

	// We can use :scope instead of the ID hack if the browser
	// supports it & if we're not changing the context.
	// Support: IE 11+, Edge 17 - 18+
	// IE/Edge sometimes throw a "Permission denied" error when
	// strict-comparing two documents; shallow comparisons work.
	// eslint-disable-next-line eqeqeq
	if ( newContext != context || !support.scope ) {

	// Capture the context ID, setting it first if necessary
	if ( ( nid = context.getAttribute( "id" ) ) ) {
	nid = jQuery.escapeSelector( nid );
	} else {
	context.setAttribute( "id", ( nid = expando ) );
	}
	}

	// Prefix every selector in the list
	groups = tokenize( selector );
	i = groups.length;
	while ( i-- ) {
	groups[ i ] = ( nid ? "#" + nid : ":scope" ) + " " +
	toSelector( groups[ i ] );
	}
	newSelector = groups.join( "," );
	}

	try {
	push.apply( results,
	newContext.querySelectorAll( newSelector )
	);
	return results;
	} catch ( qsaError ) {
	nonnativeSelectorCache( selector, true );
	} finally {
	if ( nid === expando ) {
	context.removeAttribute( "id" );
	}
	}
	}
	}
	}

	// All others
	return select( selector.replace( rtrimCSS, "$1" ), context, results, seed );
	}

	/**
	* Create key-value caches of limited size
	* @returns {function(string, object)} Returns the Object data after storing it on itself with
	* property name the (space-suffixed) string and (if the cache is larger than Expr.cacheLength)
	* deleting the oldest entry
	*/
	function createCache() {
	var keys = [];

	function cache( key, value ) {

	// Use (key + " ") to avoid collision with native prototype properties
	// (see https://github.com/jquery/sizzle/issues/157)
	if ( keys.push( key + " " ) > Expr.cacheLength ) {

	// Only keep the most recent entries
	delete cache[ keys.shift() ];
	}
	return ( cache[ key + " " ] = value );
	}
	return cache;
	}

	/**
	* Mark a function for special use by jQuery selector module
	* @param {Function} fn The function to mark
	*/
	function markFunction( fn ) {
	fn[ expando ] = true;
	return fn;
	}

	/**
	* Support testing using an element
	* @param {Function} fn Passed the created element and returns a boolean result
	*/
	function assert( fn ) {
	var el = document.createElement( "fieldset" );

	try {
	return !!fn( el );
	} catch ( e ) {
	return false;
	} finally {

	// Remove from its parent by default
	if ( el.parentNode ) {
	el.parentNode.removeChild( el );
	}

	// release memory in IE
	el = null;
	}
	}

	/**
	* Returns a function to use in pseudos for input types
	* @param {String} type
	*/
	function createInputPseudo( type ) {
	return function( elem ) {
	return nodeName( elem, "input" ) && elem.type === type;
	};
	}

	/**
	* Returns a function to use in pseudos for buttons
	* @param {String} type
	*/
	function createButtonPseudo( type ) {
	return function( elem ) {
	return ( nodeName( elem, "input" ) || nodeName( elem, "button" ) ) &&
	elem.type === type;
	};
	}

	/**
	* Returns a function to use in pseudos for :enabled/:disabled
	* @param {Boolean} disabled true for :disabled; false for :enabled
	*/
	function createDisabledPseudo( disabled ) {

	// Known :disabled false positives: fieldset[disabled] > legend:nth-of-type(n+2) :can-disable
	return function( elem ) {

	// Only certain elements can match :enabled or :disabled
	// https://html.spec.whatwg.org/multipage/scripting.html#selector-enabled
	// https://html.spec.whatwg.org/multipage/scripting.html#selector-disabled
	if ( "form" in elem ) {

	// Check for inherited disabledness on relevant non-disabled elements:
	// * listed form-associated elements in a disabled fieldset
	// https://html.spec.whatwg.org/multipage/forms.html#category-listed
	// https://html.spec.whatwg.org/multipage/forms.html#concept-fe-disabled
	// * option elements in a disabled optgroup
	// https://html.spec.whatwg.org/multipage/forms.html#concept-option-disabled
	// All such elements have a "form" property.
	if ( elem.parentNode && elem.disabled === false ) {

	// Option elements defer to a parent optgroup if present
	if ( "label" in elem ) {
	if ( "label" in elem.parentNode ) {
	return elem.parentNode.disabled === disabled;
	} else {
	return elem.disabled === disabled;
	}
	}

	// Support: IE 6 - 11+
	// Use the isDisabled shortcut property to check for disabled fieldset ancestors
	return elem.isDisabled === disabled ||

	// Where there is no isDisabled, check manually
	elem.isDisabled !== !disabled &&
	inDisabledFieldset( elem ) === disabled;
	}

	return elem.disabled === disabled;

	// Try to winnow out elements that can't be disabled before trusting the disabled property.
	// Some victims get caught in our net (label, legend, menu, track), but it shouldn't
	// even exist on them, let alone have a boolean value.
	} else if ( "label" in elem ) {
	return elem.disabled === disabled;
	}

	// Remaining elements are neither :enabled nor :disabled
	return false;
	};
	}

	/**
	* Returns a function to use in pseudos for positionals
	* @param {Function} fn
	*/
	function createPositionalPseudo( fn ) {
	return markFunction( function( argument ) {
	argument = +argument;
	return markFunction( function( seed, matches ) {
	var j,
	matchIndexes = fn( [], seed.length, argument ),
	i = matchIndexes.length;

	// Match elements found at the specified indexes
	while ( i-- ) {
	if ( seed[ ( j = matchIndexes[ i ] ) ] ) {
	seed[ j ] = !( matches[ j ] = seed[ j ] );
	}
	}
	} );
	} );
	}

	/**
	* Checks a node for validity as a jQuery selector context
	* @param {Element|Object=} context
	* @returns {Element|Object|Boolean} The input node if acceptable, otherwise a falsy value
	*/
	function testContext( context ) {
	return context && typeof context.getElementsByTagName !== "undefined" && context;
	}

	/**
	* Sets document-related variables once based on the current document
	* @param {Element|Object} [node] An element or document object to use to set the document
	* @returns {Object} Returns the current document
	*/
	function setDocument( node ) {
	var subWindow,
	doc = node ? node.ownerDocument || node : preferredDoc;

	// Return early if doc is invalid or already selected
	// Support: IE 11+, Edge 17 - 18+
	// IE/Edge sometimes throw a "Permission denied" error when strict-comparing
	// two documents; shallow comparisons work.
	// eslint-disable-next-line eqeqeq
	if ( doc == document || doc.nodeType !== 9 || !doc.documentElement ) {
	return document;
	}

	// Update global variables
	document = doc;
	documentElement = document.documentElement;
	documentIsHTML = !jQuery.isXMLDoc( document );

	// Support: iOS 7 only, IE 9 - 11+
	// Older browsers didn't support unprefixed `matches`.
	matches = documentElement.matches ||
	documentElement.webkitMatchesSelector ||
	documentElement.msMatchesSelector;

	// Support: IE 9 - 11+, Edge 12 - 18+
	// Accessing iframe documents after unload throws "permission denied" errors (see trac-13936)
	// Support: IE 11+, Edge 17 - 18+
	// IE/Edge sometimes throw a "Permission denied" error when strict-comparing
	// two documents; shallow comparisons work.
	// eslint-disable-next-line eqeqeq
	if ( preferredDoc != document &&
	( subWindow = document.defaultView ) && subWindow.top !== subWindow ) {

	// Support: IE 9 - 11+, Edge 12 - 18+
	subWindow.addEventListener( "unload", unloadHandler );
	}

	// Support: IE <10
	// Check if getElementById returns elements by name
	// The broken getElementById methods don't pick up programmatically-set names,
	// so use a roundabout getElementsByName test
	support.getById = assert( function( el ) {
	documentElement.appendChild( el ).id = jQuery.expando;
	return !document.getElementsByName ||
	!document.getElementsByName( jQuery.expando ).length;
	} );

	// Support: IE 9 only
	// Check to see if it's possible to do matchesSelector
	// on a disconnected node.
	support.disconnectedMatch = assert( function( el ) {
	return matches.call( el, "*" );
	} );

	// Support: IE 9 - 11+, Edge 12 - 18+
	// IE/Edge don't support the :scope pseudo-class.
	support.scope = assert( function() {
	return document.querySelectorAll( ":scope" );
	} );

	// Support: Chrome 105 - 111 only, Safari 15.4 - 16.3 only
	// Make sure the `:has()` argument is parsed unforgivingly.
	// We include `*` in the test to detect buggy implementations that are
	// _selectively_ forgiving (specifically when the list includes at least
	// one valid selector).
	// Note that we treat complete lack of support for `:has()` as if it were
	// spec-compliant support, which is fine because use of `:has()` in such
	// environments will fail in the qSA path and fall back to jQuery traversal
	// anyway.
	support.cssHas = assert( function() {
	try {
	document.querySelector( ":has(*,:jqfake)" );
	return false;
	} catch ( e ) {
	return true;
	}
	} );

	// ID filter and find
	if ( support.getById ) {
	Expr.filter.ID = function( id ) {
	var attrId = id.replace( runescape, funescape );
	return function( elem ) {
	return elem.getAttribute( "id" ) === attrId;
	};
	};
	Expr.find.ID = function( id, context ) {
	if ( typeof context.getElementById !== "undefined" && documentIsHTML ) {
	var elem = context.getElementById( id );
	return elem ? [ elem ] : [];
	}
	};
	} else {
	Expr.filter.ID = function( id ) {
	var attrId = id.replace( runescape, funescape );
	return function( elem ) {
	var node = typeof elem.getAttributeNode !== "undefined" &&
	elem.getAttributeNode( "id" );
	return node && node.value === attrId;
	};
	};

	// Support: IE 6 - 7 only
	// getElementById is not reliable as a find shortcut
	Expr.find.ID = function( id, context ) {
	if ( typeof context.getElementById !== "undefined" && documentIsHTML ) {
	var node, i, elems,
	elem = context.getElementById( id );

	if ( elem ) {

	// Verify the id attribute
	node = elem.getAttributeNode( "id" );
	if ( node && node.value === id ) {
	return [ elem ];
	}

	// Fall back on getElementsByName
	elems = context.getElementsByName( id );
	i = 0;
	while ( ( elem = elems[ i++ ] ) ) {
	node = elem.getAttributeNode( "id" );
	if ( node && node.value === id ) {
	return [ elem ];
	}
	}
	}

	return [];
	}
	};
	}

	// Tag
	Expr.find.TAG = function( tag, context ) {
	if ( typeof context.getElementsByTagName !== "undefined" ) {
	return context.getElementsByTagName( tag );

	// DocumentFragment nodes don't have gEBTN
	} else {
	return context.querySelectorAll( tag );
	}
	};

	// Class
	Expr.find.CLASS = function( className, context ) {
	if ( typeof context.getElementsByClassName !== "undefined" && documentIsHTML ) {
	return context.getElementsByClassName( className );
	}
	};

	/* QSA/matchesSelector
	---------------------------------------------------------------------- */

	// QSA and matchesSelector support

	rbuggyQSA = [];

	// Build QSA regex
	// Regex strategy adopted from Diego Perini
	assert( function( el ) {

	var input;

	documentElement.appendChild( el ).innerHTML =
	"<a id='" + expando + "' href='' disabled='disabled'></a>" +
	"<select id='" + expando + "-\r\\' disabled='disabled'>" +
		"
		<option selected=''></option>
	</select>";

	// Support: iOS <=7 - 8 only
	// Boolean attributes and "value" are not treated correctly in some XML documents
	if ( !el.querySelectorAll( "[selected]" ).length ) {
	rbuggyQSA.push( "\\[" + whitespace + "*(?:value|" + booleans + ")" );
	}

	// Support: iOS <=7 - 8 only
	if ( !el.querySelectorAll( "[id~=" + expando + "-]" ).length ) {
	rbuggyQSA.push( "~=" );
	}

	// Support: iOS 8 only
	// https://bugs.webkit.org/show_bug.cgi?id=136851
	// In-page `selector#id sibling-combinator selector` fails
	if ( !el.querySelectorAll( "a#" + expando + "+*" ).length ) {
	rbuggyQSA.push( ".#.+[+~]" );
	}

	// Support: Chrome <=105+, Firefox <=104+, Safari <=15.4+
	// In some of the document kinds, these selectors wouldn't work natively.
	// This is probably OK but for backwards compatibility we want to maintain
	// handling them through jQuery traversal in jQuery 3.x.
	if ( !el.querySelectorAll( ":checked" ).length ) {
	rbuggyQSA.push( ":checked" );
	}

	// Support: Windows 8 Native Apps
	// The type and name attributes are restricted during .innerHTML assignment
	input = document.createElement( "input" );
	input.setAttribute( "type", "hidden" );
	el.appendChild( input ).setAttribute( "name", "D" );

	// Support: IE 9 - 11+
	// IE's :disabled selector does not pick up the children of disabled fieldsets
	// Support: Chrome <=105+, Firefox <=104+, Safari <=15.4+
	// In some of the document kinds, these selectors wouldn't work natively.
	// This is probably OK but for backwards compatibility we want to maintain
	// handling them through jQuery traversal in jQuery 3.x.
	documentElement.appendChild( el ).disabled = true;
	if ( el.querySelectorAll( ":disabled" ).length !== 2 ) {
	rbuggyQSA.push( ":enabled", ":disabled" );
	}

	// Support: IE 11+, Edge 15 - 18+
	// IE 11/Edge don't find elements on a `[name='']` query in some cases.
	// Adding a temporary attribute to the document before the selection works
	// around the issue.
	// Interestingly, IE 10 & older don't seem to have the issue.
	input = document.createElement( "input" );
	input.setAttribute( "name", "" );
	el.appendChild( input );
	if ( !el.querySelectorAll( "[name='']" ).length ) {
	rbuggyQSA.push( "\\[" + whitespace + "*name" + whitespace + "*=" +
	whitespace + "*(?:''|\"\")" );
	}
	} );

	if ( !support.cssHas ) {

	// Support: Chrome 105 - 110+, Safari 15.4 - 16.3+
	// Our regular `try-catch` mechanism fails to detect natively-unsupported
	// pseudo-classes inside `:has()` (such as `:has(:contains("Foo"))`)
	// in browsers that parse the `:has()` argument as a forgiving selector list.
	// https://drafts.csswg.org/selectors/#relational now requires the argument
	// to be parsed unforgivingly, but browsers have not yet fully adjusted.
	rbuggyQSA.push( ":has" );
	}

	rbuggyQSA = rbuggyQSA.length && new RegExp( rbuggyQSA.join( "|" ) );

	/* Sorting
	---------------------------------------------------------------------- */

	// Document order sorting
	sortOrder = function( a, b ) {

	// Flag for duplicate removal
	if ( a === b ) {
	hasDuplicate = true;
	return 0;
	}

	// Sort on method existence if only one input has compareDocumentPosition
	var compare = !a.compareDocumentPosition - !b.compareDocumentPosition;
	if ( compare ) {
	return compare;
	}

	// Calculate position if both inputs belong to the same document
	// Support: IE 11+, Edge 17 - 18+
	// IE/Edge sometimes throw a "Permission denied" error when strict-comparing
	// two documents; shallow comparisons work.
	// eslint-disable-next-line eqeqeq
	compare = ( a.ownerDocument || a ) == ( b.ownerDocument || b ) ?
	a.compareDocumentPosition( b ) :

	// Otherwise we know they are disconnected
	1;

	// Disconnected nodes
	if ( compare & 1 ||
	( !support.sortDetached && b.compareDocumentPosition( a ) === compare ) ) {

	// Choose the first element that is related to our preferred document
	// Support: IE 11+, Edge 17 - 18+
	// IE/Edge sometimes throw a "Permission denied" error when strict-comparing
	// two documents; shallow comparisons work.
	// eslint-disable-next-line eqeqeq
	if ( a === document || a.ownerDocument == preferredDoc &&
	find.contains( preferredDoc, a ) ) {
	return -1;
	}

	// Support: IE 11+, Edge 17 - 18+
	// IE/Edge sometimes throw a "Permission denied" error when strict-comparing
	// two documents; shallow comparisons work.
	// eslint-disable-next-line eqeqeq
	if ( b === document || b.ownerDocument == preferredDoc &&
	find.contains( preferredDoc, b ) ) {
	return 1;
	}

	// Maintain original order
	return sortInput ?
	( indexOf.call( sortInput, a ) - indexOf.call( sortInput, b ) ) :
	0;
	}

	return compare & 4 ? -1 : 1;
	};

	return document;
	}

	find.matches = function( expr, elements ) {
	return find( expr, null, null, elements );
	};

	find.matchesSelector = function( elem, expr ) {
	setDocument( elem );

	if ( documentIsHTML &&
	!nonnativeSelectorCache[ expr + " " ] &&
	( !rbuggyQSA || !rbuggyQSA.test( expr ) ) ) {

	try {
	var ret = matches.call( elem, expr );

	// IE 9's matchesSelector returns false on disconnected nodes
	if ( ret || support.disconnectedMatch ||

	// As well, disconnected nodes are said to be in a document
	// fragment in IE 9
	elem.document && elem.document.nodeType !== 11 ) {
	return ret;
	}
	} catch ( e ) {
	nonnativeSelectorCache( expr, true );
	}
	}

	return find( expr, document, null, [ elem ] ).length > 0;
	};

	find.contains = function( context, elem ) {

	// Set document vars if needed
	// Support: IE 11+, Edge 17 - 18+
	// IE/Edge sometimes throw a "Permission denied" error when strict-comparing
	// two documents; shallow comparisons work.
	// eslint-disable-next-line eqeqeq
	if ( ( context.ownerDocument || context ) != document ) {
	setDocument( context );
	}
	return jQuery.contains( context, elem );
	};


	find.attr = function( elem, name ) {

	// Set document vars if needed
	// Support: IE 11+, Edge 17 - 18+
	// IE/Edge sometimes throw a "Permission denied" error when strict-comparing
	// two documents; shallow comparisons work.
	// eslint-disable-next-line eqeqeq
	if ( ( elem.ownerDocument || elem ) != document ) {
	setDocument( elem );
	}

	var fn = Expr.attrHandle[ name.toLowerCase() ],

	// Don't get fooled by Object.prototype properties (see trac-13807)
	val = fn && hasOwn.call( Expr.attrHandle, name.toLowerCase() ) ?
	fn( elem, name, !documentIsHTML ) :
	undefined;

	if ( val !== undefined ) {
	return val;
	}

	return elem.getAttribute( name );
	};

	find.error = function( msg ) {
	throw new Error( "Syntax error, unrecognized expression: " + msg );
	};

	/**
	* Document sorting and removing duplicates
	* @param {ArrayLike} results
	*/
	jQuery.uniqueSort = function( results ) {
	var elem,
	duplicates = [],
	j = 0,
	i = 0;

	// Unless we *know* we can detect duplicates, assume their presence
	//
	// Support: Android <=4.0+
	// Testing for detecting duplicates is unpredictable so instead assume we can't
	// depend on duplicate detection in all browsers without a stable sort.
	hasDuplicate = !support.sortStable;
	sortInput = !support.sortStable && slice.call( results, 0 );
	sort.call( results, sortOrder );

	if ( hasDuplicate ) {
	while ( ( elem = results[ i++ ] ) ) {
	if ( elem === results[ i ] ) {
	j = duplicates.push( i );
	}
	}
	while ( j-- ) {
	splice.call( results, duplicates[ j ], 1 );
	}
	}

	// Clear input after sorting to release objects
	// See https://github.com/jquery/sizzle/pull/225
	sortInput = null;

	return results;
	};

	jQuery.fn.uniqueSort = function() {
	return this.pushStack( jQuery.uniqueSort( slice.apply( this ) ) );
	};

	Expr = jQuery.expr = {

	// Can be adjusted by the user
	cacheLength: 50,

	createPseudo: markFunction,

	match: matchExpr,

	attrHandle: {},

	find: {},

	relative: {
	">": { dir: "parentNode", first: true },
	" ": { dir: "parentNode" },
	"+": { dir: "previousSibling", first: true },
	"~": { dir: "previousSibling" }
	},

	preFilter: {
	ATTR: function( match ) {
	match[ 1 ] = match[ 1 ].replace( runescape, funescape );

	// Move the given value to match[3] whether quoted or unquoted
	match[ 3 ] = ( match[ 3 ] || match[ 4 ] || match[ 5 ] || "" )
	.replace( runescape, funescape );

	if ( match[ 2 ] === "~=" ) {
	match[ 3 ] = " " + match[ 3 ] + " ";
	}

	return match.slice( 0, 4 );
	},

	CHILD: function( match ) {

	/* matches from matchExpr["CHILD"]
	1 type (only|nth|...)
	2 what (child|of-type)
	3 argument (even|odd|\d*|\d*n([+-]\d+)?|...)
	4 xn-component of xn+y argument ([+-]?\d*n|)
	5 sign of xn-component
	6 x of xn-component
	7 sign of y-component
	8 y of y-component
	*/
	match[ 1 ] = match[ 1 ].toLowerCase();

	if ( match[ 1 ].slice( 0, 3 ) === "nth" ) {

	// nth-* requires argument
	if ( !match[ 3 ] ) {
	find.error( match[ 0 ] );
	}

	// numeric x and y parameters for Expr.filter.CHILD
	// remember that false/true cast respectively to 0/1
	match[ 4 ] = +( match[ 4 ] ?
	match[ 5 ] + ( match[ 6 ] || 1 ) :
	2 * ( match[ 3 ] === "even" || match[ 3 ] === "odd" )
	);
	match[ 5 ] = +( ( match[ 7 ] + match[ 8 ] ) || match[ 3 ] === "odd" );

	// other types prohibit arguments
	} else if ( match[ 3 ] ) {
	find.error( match[ 0 ] );
	}

	return match;
	},

	PSEUDO: function( match ) {
	var excess,
	unquoted = !match[ 6 ] && match[ 2 ];

	if ( matchExpr.CHILD.test( match[ 0 ] ) ) {
	return null;
	}

	// Accept quoted arguments as-is
	if ( match[ 3 ] ) {
	match[ 2 ] = match[ 4 ] || match[ 5 ] || "";

	// Strip excess characters from unquoted arguments
	} else if ( unquoted && rpseudo.test( unquoted ) &&

	// Get excess from tokenize (recursively)
	( excess = tokenize( unquoted, true ) ) &&

	// advance to the next closing parenthesis
	( excess = unquoted.indexOf( ")", unquoted.length - excess ) - unquoted.length ) ) {

	// excess is a negative index
	match[ 0 ] = match[ 0 ].slice( 0, excess );
	match[ 2 ] = unquoted.slice( 0, excess );
	}

	// Return only captures needed by the pseudo filter method (type and argument)
	return match.slice( 0, 3 );
	}
	},

	filter: {

	TAG: function( nodeNameSelector ) {
	var expectedNodeName = nodeNameSelector.replace( runescape, funescape ).toLowerCase();
	return nodeNameSelector === "*" ?
	function() {
	return true;
	} :
	function( elem ) {
	return nodeName( elem, expectedNodeName );
	};
	},

	CLASS: function( className ) {
	var pattern = classCache[ className + " " ];

	return pattern ||
	( pattern = new RegExp( "(^|" + whitespace + ")" + className +
	"(" + whitespace + "|$)" ) ) &&
	classCache( className, function( elem ) {
	return pattern.test(
	typeof elem.className === "string" && elem.className ||
	typeof elem.getAttribute !== "undefined" &&
	elem.getAttribute( "class" ) ||
	""
	);
	} );
	},

	ATTR: function( name, operator, check ) {
	return function( elem ) {
	var result = find.attr( elem, name );

	if ( result == null ) {
	return operator === "!=";
	}
	if ( !operator ) {
	return true;
	}

	result += "";

	if ( operator === "=" ) {
	return result === check;
	}
	if ( operator === "!=" ) {
	return result !== check;
	}
	if ( operator === "^=" ) {
	return check && result.indexOf( check ) === 0;
	}
	if ( operator === "*=" ) {
	return check && result.indexOf( check ) > -1;
	}
	if ( operator === "$=" ) {
	return check && result.slice( -check.length ) === check;
	}
	if ( operator === "~=" ) {
	return ( " " + result.replace( rwhitespace, " " ) + " " )
	.indexOf( check ) > -1;
	}
	if ( operator === "|=" ) {
	return result === check || result.slice( 0, check.length + 1 ) === check + "-";
	}

	return false;
	};
	},

	CHILD: function( type, what, _argument, first, last ) {
	var simple = type.slice( 0, 3 ) !== "nth",
	forward = type.slice( -4 ) !== "last",
	ofType = what === "of-type";

	return first === 1 && last === 0 ?

	// Shortcut for :nth-*(n)
	function( elem ) {
	return !!elem.parentNode;
	} :

	function( elem, _context, xml ) {
	var cache, outerCache, node, nodeIndex, start,
	dir = simple !== forward ? "nextSibling" : "previousSibling",
	parent = elem.parentNode,
	name = ofType && elem.nodeName.toLowerCase(),
	useCache = !xml && !ofType,
	diff = false;

	if ( parent ) {

	// :(first|last|only)-(child|of-type)
	if ( simple ) {
	while ( dir ) {
	node = elem;
	while ( ( node = node[ dir ] ) ) {
	if ( ofType ?
	nodeName( node, name ) :
	node.nodeType === 1 ) {

	return false;
	}
	}

	// Reverse direction for :only-* (if we haven't yet done so)
	start = dir = type === "only" && !start && "nextSibling";
	}
	return true;
	}

	start = [ forward ? parent.firstChild : parent.lastChild ];

	// non-xml :nth-child(...) stores cache data on `parent`
	if ( forward && useCache ) {

	// Seek `elem` from a previously-cached index
	outerCache = parent[ expando ] || ( parent[ expando ] = {} );
	cache = outerCache[ type ] || [];
	nodeIndex = cache[ 0 ] === dirruns && cache[ 1 ];
	diff = nodeIndex && cache[ 2 ];
	node = nodeIndex && parent.childNodes[ nodeIndex ];

	while ( ( node = ++nodeIndex && node && node[ dir ] ||

	// Fallback to seeking `elem` from the start
	( diff = nodeIndex = 0 ) || start.pop() ) ) {

	// When found, cache indexes on `parent` and break
	if ( node.nodeType === 1 && ++diff && node === elem ) {
	outerCache[ type ] = [ dirruns, nodeIndex, diff ];
	break;
	}
	}

	} else {

	// Use previously-cached element index if available
	if ( useCache ) {
	outerCache = elem[ expando ] || ( elem[ expando ] = {} );
	cache = outerCache[ type ] || [];
	nodeIndex = cache[ 0 ] === dirruns && cache[ 1 ];
	diff = nodeIndex;
	}

	// xml :nth-child(...)
	// or :nth-last-child(...) or :nth(-last)?-of-type(...)
	if ( diff === false ) {

	// Use the same loop as above to seek `elem` from the start
	while ( ( node = ++nodeIndex && node && node[ dir ] ||
	( diff = nodeIndex = 0 ) || start.pop() ) ) {

	if ( ( ofType ?
	nodeName( node, name ) :
	node.nodeType === 1 ) &&
	++diff ) {

	// Cache the index of each encountered element
	if ( useCache ) {
	outerCache = node[ expando ] ||
	( node[ expando ] = {} );
	outerCache[ type ] = [ dirruns, diff ];
	}

	if ( node === elem ) {
	break;
	}
	}
	}
	}
	}

	// Incorporate the offset, then check against cycle size
	diff -= last;
	return diff === first || ( diff % first === 0 && diff / first >= 0 );
	}
	};
	},

	PSEUDO: function( pseudo, argument ) {

	// pseudo-class names are case-insensitive
	// https://www.w3.org/TR/selectors/#pseudo-classes
	// Prioritize by case sensitivity in case custom pseudos are added with uppercase letters
	// Remember that setFilters inherits from pseudos
	var args,
	fn = Expr.pseudos[ pseudo ] || Expr.setFilters[ pseudo.toLowerCase() ] ||
	find.error( "unsupported pseudo: " + pseudo );

	// The user may use createPseudo to indicate that
	// arguments are needed to create the filter function
	// just as jQuery does
	if ( fn[ expando ] ) {
	return fn( argument );
	}

	// But maintain support for old signatures
	if ( fn.length > 1 ) {
	args = [ pseudo, pseudo, "", argument ];
	return Expr.setFilters.hasOwnProperty( pseudo.toLowerCase() ) ?
	markFunction( function( seed, matches ) {
	var idx,
	matched = fn( seed, argument ),
	i = matched.length;
	while ( i-- ) {
	idx = indexOf.call( seed, matched[ i ] );
	seed[ idx ] = !( matches[ idx ] = matched[ i ] );
	}
	} ) :
	function( elem ) {
	return fn( elem, 0, args );
	};
	}

	return fn;
	}
	},

	pseudos: {

	// Potentially complex pseudos
	not: markFunction( function( selector ) {

	// Trim the selector passed to compile
	// to avoid treating leading and trailing
	// spaces as combinators
	var input = [],
	results = [],
	matcher = compile( selector.replace( rtrimCSS, "$1" ) );

	return matcher[ expando ] ?
	markFunction( function( seed, matches, _context, xml ) {
	var elem,
	unmatched = matcher( seed, null, xml, [] ),
	i = seed.length;

	// Match elements unmatched by `matcher`
	while ( i-- ) {
	if ( ( elem = unmatched[ i ] ) ) {
	seed[ i ] = !( matches[ i ] = elem );
	}
	}
	} ) :
	function( elem, _context, xml ) {
	input[ 0 ] = elem;
	matcher( input, null, xml, results );

	// Don't keep the element
	// (see https://github.com/jquery/sizzle/issues/299)
	input[ 0 ] = null;
	return !results.pop();
	};
	} ),

	has: markFunction( function( selector ) {
	return function( elem ) {
	return find( selector, elem ).length > 0;
	};
	} ),

	contains: markFunction( function( text ) {
	text = text.replace( runescape, funescape );
	return function( elem ) {
	return ( elem.textContent || jQuery.text( elem ) ).indexOf( text ) > -1;
	};
	} ),

	// "Whether an element is represented by a :lang() selector
	// is based solely on the element's language value
	// being equal to the identifier C,
	// or beginning with the identifier C immediately followed by "-".
	// The matching of C against the element's language value is performed case-insensitively.
	// The identifier C does not have to be a valid language name."
	// https://www.w3.org/TR/selectors/#lang-pseudo
	lang: markFunction( function( lang ) {

	// lang value must be a valid identifier
	if ( !ridentifier.test( lang || "" ) ) {
	find.error( "unsupported lang: " + lang );
	}
	lang = lang.replace( runescape, funescape ).toLowerCase();
	return function( elem ) {
	var elemLang;
	do {
	if ( ( elemLang = documentIsHTML ?
	elem.lang :
	elem.getAttribute( "xml:lang" ) || elem.getAttribute( "lang" ) ) ) {

	elemLang = elemLang.toLowerCase();
	return elemLang === lang || elemLang.indexOf( lang + "-" ) === 0;
	}
	} while ( ( elem = elem.parentNode ) && elem.nodeType === 1 );
	return false;
	};
	} ),

	// Miscellaneous
	target: function( elem ) {
	var hash = window.location && window.location.hash;
	return hash && hash.slice( 1 ) === elem.id;
	},

	root: function( elem ) {
	return elem === documentElement;
	},

	focus: function( elem ) {
	return elem === safeActiveElement() &&
	document.hasFocus() &&
	!!( elem.type || elem.href || ~elem.tabIndex );
	},

	// Boolean properties
	enabled: createDisabledPseudo( false ),
	disabled: createDisabledPseudo( true ),

	checked: function( elem ) {

	// In CSS3, :checked should return both checked and selected elements
	// https://www.w3.org/TR/2011/REC-css3-selectors-20110929/#checked
	return ( nodeName( elem, "input" ) && !!elem.checked ) ||
	( nodeName( elem, "option" ) && !!elem.selected );
	},

	selected: function( elem ) {

	// Support: IE <=11+
	// Accessing the selectedIndex property
	// forces the browser to treat the default option as
	// selected when in an optgroup.
	if ( elem.parentNode ) {
	// eslint-disable-next-line no-unused-expressions
	elem.parentNode.selectedIndex;
	}

	return elem.selected === true;
	},

	// Contents
	empty: function( elem ) {

	// https://www.w3.org/TR/selectors/#empty-pseudo
	// :empty is negated by element (1) or content nodes (text: 3; cdata: 4; entity ref: 5),
	// but not by others (comment: 8; processing instruction: 7; etc.)
	// nodeType < 6 works because attributes (2) do not appear as children
	for ( elem = elem.firstChild; elem; elem = elem.nextSibling ) {
	if ( elem.nodeType < 6 ) {
	return false;
	}
	}
	return true;
	},

	parent: function( elem ) {
	return !Expr.pseudos.empty( elem );
	},

	// Element/input types
	header: function( elem ) {
	return rheader.test( elem.nodeName );
	},

	input: function( elem ) {
	return rinputs.test( elem.nodeName );
	},

	button: function( elem ) {
	return nodeName( elem, "input" ) && elem.type === "button" ||
	nodeName( elem, "button" );
	},

	text: function( elem ) {
	var attr;
	return nodeName( elem, "input" ) && elem.type === "text" &&

	// Support: IE <10 only
	// New HTML5 attribute values (e.g., "search") appear
	// with elem.type === "text"
	( ( attr = elem.getAttribute( "type" ) ) == null ||
	attr.toLowerCase() === "text" );
	},

	// Position-in-collection
	first: createPositionalPseudo( function() {
	return [ 0 ];
	} ),

	last: createPositionalPseudo( function( _matchIndexes, length ) {
	return [ length - 1 ];
	} ),

	eq: createPositionalPseudo( function( _matchIndexes, length, argument ) {
	return [ argument < 0 ? argument + length : argument ];
	} ),

	even: createPositionalPseudo( function( matchIndexes, length ) {
	var i = 0;
	for ( ; i < length; i += 2 ) {
	matchIndexes.push( i );
	}
	return matchIndexes;
	} ),

	odd: createPositionalPseudo( function( matchIndexes, length ) {
	var i = 1;
	for ( ; i < length; i += 2 ) {
	matchIndexes.push( i );
	}
	return matchIndexes;
	} ),

	lt: createPositionalPseudo( function( matchIndexes, length, argument ) {
	var i;

	if ( argument < 0 ) {
	i = argument + length;
	} else if ( argument > length ) {
	i = length;
	} else {
	i = argument;
	}

	for ( ; --i >= 0; ) {
	matchIndexes.push( i );
	}
	return matchIndexes;
	} ),

	gt: createPositionalPseudo( function( matchIndexes, length, argument ) {
	var i = argument < 0 ? argument + length : argument;
	for ( ; ++i < length; ) {
	matchIndexes.push( i );
	}
	return matchIndexes;
	} )
	}
	};

	Expr.pseudos.nth = Expr.pseudos.eq;

	// Add button/input type pseudos
	for ( i in { radio: true, checkbox: true, file: true, password: true, image: true } ) {
	Expr.pseudos[ i ] = createInputPseudo( i );
	}
	for ( i in { submit: true, reset: true } ) {
	Expr.pseudos[ i ] = createButtonPseudo( i );
	}

	// Easy API for creating new setFilters
	function setFilters() {}
	setFilters.prototype = Expr.filters = Expr.pseudos;
	Expr.setFilters = new setFilters();

	function tokenize( selector, parseOnly ) {
	var matched, match, tokens, type,
	soFar, groups, preFilters,
	cached = tokenCache[ selector + " " ];

	if ( cached ) {
	return parseOnly ? 0 : cached.slice( 0 );
	}

	soFar = selector;
	groups = [];
	preFilters = Expr.preFilter;

	while ( soFar ) {

	// Comma and first run
	if ( !matched || ( match = rcomma.exec( soFar ) ) ) {
	if ( match ) {

	// Don't consume trailing commas as valid
	soFar = soFar.slice( match[ 0 ].length ) || soFar;
	}
	groups.push( ( tokens = [] ) );
	}

	matched = false;

	// Combinators
	if ( ( match = rleadingCombinator.exec( soFar ) ) ) {
	matched = match.shift();
	tokens.push( {
	value: matched,

	// Cast descendant combinators to space
	type: match[ 0 ].replace( rtrimCSS, " " )
	} );
	soFar = soFar.slice( matched.length );
	}

	// Filters
	for ( type in Expr.filter ) {
	if ( ( match = matchExpr[ type ].exec( soFar ) ) && ( !preFilters[ type ] ||
	( match = preFilters[ type ]( match ) ) ) ) {
	matched = match.shift();
	tokens.push( {
	value: matched,
	type: type,
	matches: match
	} );
	soFar = soFar.slice( matched.length );
	}
	}

	if ( !matched ) {
	break;
	}
	}

	// Return the length of the invalid excess
	// if we're just parsing
	// Otherwise, throw an error or return tokens
	if ( parseOnly ) {
	return soFar.length;
	}

	return soFar ?
	find.error( selector ) :

	// Cache the tokens
	tokenCache( selector, groups ).slice( 0 );
	}

	function toSelector( tokens ) {
	var i = 0,
	len = tokens.length,
	selector = "";
	for ( ; i < len; i++ ) {
	selector += tokens[ i ].value;
	}
	return selector;
	}

	function addCombinator( matcher, combinator, base ) {
	var dir = combinator.dir,
	skip = combinator.next,
	key = skip || dir,
	checkNonElements = base && key === "parentNode",
	doneName = done++;

	return combinator.first ?

	// Check against closest ancestor/preceding element
	function( elem, context, xml ) {
	while ( ( elem = elem[ dir ] ) ) {
	if ( elem.nodeType === 1 || checkNonElements ) {
	return matcher( elem, context, xml );
	}
	}
	return false;
	} :

	// Check against all ancestor/preceding elements
	function( elem, context, xml ) {
	var oldCache, outerCache,
	newCache = [ dirruns, doneName ];

	// We can't set arbitrary data on XML nodes, so they don't benefit from combinator caching
	if ( xml ) {
	while ( ( elem = elem[ dir ] ) ) {
	if ( elem.nodeType === 1 || checkNonElements ) {
	if ( matcher( elem, context, xml ) ) {
	return true;
	}
	}
	}
	} else {
	while ( ( elem = elem[ dir ] ) ) {
	if ( elem.nodeType === 1 || checkNonElements ) {
	outerCache = elem[ expando ] || ( elem[ expando ] = {} );

	if ( skip && nodeName( elem, skip ) ) {
	elem = elem[ dir ] || elem;
	} else if ( ( oldCache = outerCache[ key ] ) &&
	oldCache[ 0 ] === dirruns && oldCache[ 1 ] === doneName ) {

	// Assign to newCache so results back-propagate to previous elements
	return ( newCache[ 2 ] = oldCache[ 2 ] );
	} else {

	// Reuse newcache so results back-propagate to previous elements
	outerCache[ key ] = newCache;

	// A match means we're done; a fail means we have to keep checking
	if ( ( newCache[ 2 ] = matcher( elem, context, xml ) ) ) {
	return true;
	}
	}
	}
	}
	}
	return false;
	};
	}

	function elementMatcher( matchers ) {
	return matchers.length > 1 ?
	function( elem, context, xml ) {
	var i = matchers.length;
	while ( i-- ) {
	if ( !matchers[ i ]( elem, context, xml ) ) {
	return false;
	}
	}
	return true;
	} :
	matchers[ 0 ];
	}

	function multipleContexts( selector, contexts, results ) {
	var i = 0,
	len = contexts.length;
	for ( ; i < len; i++ ) {
	find( selector, contexts[ i ], results );
	}
	return results;
	}

	function condense( unmatched, map, filter, context, xml ) {
	var elem,
	newUnmatched = [],
	i = 0,
	len = unmatched.length,
	mapped = map != null;

	for ( ; i < len; i++ ) {
	if ( ( elem = unmatched[ i ] ) ) {
	if ( !filter || filter( elem, context, xml ) ) {
	newUnmatched.push( elem );
	if ( mapped ) {
	map.push( i );
	}
	}
	}
	}

	return newUnmatched;
	}

	function setMatcher( preFilter, selector, matcher, postFilter, postFinder, postSelector ) {
	if ( postFilter && !postFilter[ expando ] ) {
	postFilter = setMatcher( postFilter );
	}
	if ( postFinder && !postFinder[ expando ] ) {
	postFinder = setMatcher( postFinder, postSelector );
	}
	return markFunction( function( seed, results, context, xml ) {
	var temp, i, elem, matcherOut,
	preMap = [],
	postMap = [],
	preexisting = results.length,

	// Get initial elements from seed or context
	elems = seed ||
	multipleContexts( selector || "*",
	context.nodeType ? [ context ] : context, [] ),

	// Prefilter to get matcher input, preserving a map for seed-results synchronization
	matcherIn = preFilter && ( seed || !selector ) ?
	condense( elems, preMap, preFilter, context, xml ) :
	elems;

	if ( matcher ) {

	// If we have a postFinder, or filtered seed, or non-seed postFilter
	// or preexisting results,
	matcherOut = postFinder || ( seed ? preFilter : preexisting || postFilter ) ?

	// ...intermediate processing is necessary
	[] :

	// ...otherwise use results directly
	results;

	// Find primary matches
	matcher( matcherIn, matcherOut, context, xml );
	} else {
	matcherOut = matcherIn;
	}

	// Apply postFilter
	if ( postFilter ) {
	temp = condense( matcherOut, postMap );
	postFilter( temp, [], context, xml );

	// Un-match failing elements by moving them back to matcherIn
	i = temp.length;
	while ( i-- ) {
	if ( ( elem = temp[ i ] ) ) {
	matcherOut[ postMap[ i ] ] = !( matcherIn[ postMap[ i ] ] = elem );
	}
	}
	}

	if ( seed ) {
	if ( postFinder || preFilter ) {
	if ( postFinder ) {

	// Get the final matcherOut by condensing this intermediate into postFinder contexts
	temp = [];
	i = matcherOut.length;
	while ( i-- ) {
	if ( ( elem = matcherOut[ i ] ) ) {

	// Restore matcherIn since elem is not yet a final match
	temp.push( ( matcherIn[ i ] = elem ) );
	}
	}
	postFinder( null, ( matcherOut = [] ), temp, xml );
	}

	// Move matched elements from seed to results to keep them synchronized
	i = matcherOut.length;
	while ( i-- ) {
	if ( ( elem = matcherOut[ i ] ) &&
	( temp = postFinder ? indexOf.call( seed, elem ) : preMap[ i ] ) > -1 ) {

	seed[ temp ] = !( results[ temp ] = elem );
	}
	}
	}

	// Add elements to results, through postFinder if defined
	} else {
	matcherOut = condense(
	matcherOut === results ?
	matcherOut.splice( preexisting, matcherOut.length ) :
	matcherOut
	);
	if ( postFinder ) {
	postFinder( null, results, matcherOut, xml );
	} else {
	push.apply( results, matcherOut );
	}
	}
	} );
	}

	function matcherFromTokens( tokens ) {
	var checkContext, matcher, j,
	len = tokens.length,
	leadingRelative = Expr.relative[ tokens[ 0 ].type ],
	implicitRelative = leadingRelative || Expr.relative[ " " ],
	i = leadingRelative ? 1 : 0,

	// The foundational matcher ensures that elements are reachable from top-level context(s)
	matchContext = addCombinator( function( elem ) {
	return elem === checkContext;
	}, implicitRelative, true ),
	matchAnyContext = addCombinator( function( elem ) {
	return indexOf.call( checkContext, elem ) > -1;
	}, implicitRelative, true ),
	matchers = [ function( elem, context, xml ) {

	// Support: IE 11+, Edge 17 - 18+
	// IE/Edge sometimes throw a "Permission denied" error when strict-comparing
	// two documents; shallow comparisons work.
	// eslint-disable-next-line eqeqeq
	var ret = ( !leadingRelative && ( xml || context != outermostContext ) ) || (
	( checkContext = context ).nodeType ?
	matchContext( elem, context, xml ) :
	matchAnyContext( elem, context, xml ) );

	// Avoid hanging onto element
	// (see https://github.com/jquery/sizzle/issues/299)
	checkContext = null;
	return ret;
	} ];

	for ( ; i < len; i++ ) {
	if ( ( matcher = Expr.relative[ tokens[ i ].type ] ) ) {
	matchers = [ addCombinator( elementMatcher( matchers ), matcher ) ];
	} else {
	matcher = Expr.filter[ tokens[ i ].type ].apply( null, tokens[ i ].matches );

	// Return special upon seeing a positional matcher
	if ( matcher[ expando ] ) {

	// Find the next relative operator (if any) for proper handling
	j = ++i;
	for ( ; j < len; j++ ) {
	if ( Expr.relative[ tokens[ j ].type ] ) {
	break;
	}
	}
	return setMatcher(
	i > 1 && elementMatcher( matchers ),
	i > 1 && toSelector(

	// If the preceding token was a descendant combinator, insert an implicit any-element `*`
	tokens.slice( 0, i - 1 )
	.concat( { value: tokens[ i - 2 ].type === " " ? "*" : "" } )
	).replace( rtrimCSS, "$1" ),
	matcher,
	i < j && matcherFromTokens( tokens.slice( i, j ) ),
	j < len && matcherFromTokens( ( tokens = tokens.slice( j ) ) ),
	j < len && toSelector( tokens )
	);
	}
	matchers.push( matcher );
	}
	}

	return elementMatcher( matchers );
	}

	function matcherFromGroupMatchers( elementMatchers, setMatchers ) {
	var bySet = setMatchers.length > 0,
	byElement = elementMatchers.length > 0,
	superMatcher = function( seed, context, xml, results, outermost ) {
	var elem, j, matcher,
	matchedCount = 0,
	i = "0",
	unmatched = seed && [],
	setMatched = [],
	contextBackup = outermostContext,

	// We must always have either seed elements or outermost context
	elems = seed || byElement && Expr.find.TAG( "*", outermost ),

	// Use integer dirruns iff this is the outermost matcher
	dirrunsUnique = ( dirruns += contextBackup == null ? 1 : Math.random() || 0.1 ),
	len = elems.length;

	if ( outermost ) {

	// Support: IE 11+, Edge 17 - 18+
	// IE/Edge sometimes throw a "Permission denied" error when strict-comparing
	// two documents; shallow comparisons work.
	// eslint-disable-next-line eqeqeq
	outermostContext = context == document || context || outermost;
	}

	// Add elements passing elementMatchers directly to results
	// Support: iOS <=7 - 9 only
	// Tolerate NodeList properties (IE: "length"; Safari:
	<number>) matching
		// elements by id. (see trac-14142)
		for ( ; i !== len && ( elem = elems[ i ] ) != null; i++ ) {
		if ( byElement && elem ) {
		j = 0;

		// Support: IE 11+, Edge 17 - 18+
		// IE/Edge sometimes throw a "Permission denied" error when strict-comparing
		// two documents; shallow comparisons work.
		// eslint-disable-next-line eqeqeq
		if ( !context && elem.ownerDocument != document ) {
		setDocument( elem );
		xml = !documentIsHTML;
		}
		while ( ( matcher = elementMatchers[ j++ ] ) ) {
		if ( matcher( elem, context || document, xml ) ) {
		push.call( results, elem );
		break;
		}
		}
		if ( outermost ) {
		dirruns = dirrunsUnique;
		}
		}

		// Track unmatched elements for set filters
		if ( bySet ) {

		// They will have gone through all possible matchers
		if ( ( elem = !matcher && elem ) ) {
		matchedCount--;
		}

		// Lengthen the array for every element, matched or not
		if ( seed ) {
		unmatched.push( elem );
		}
		}
		}

		// `i` is now the count of elements visited above, and adding it to `matchedCount`
		// makes the latter nonnegative.
		matchedCount += i;

		// Apply set filters to unmatched elements
		// NOTE: This can be skipped if there are no unmatched elements (i.e., `matchedCount`
		// equals `i`), unless we didn't visit _any_ elements in the above loop because we have
		// no element matchers and no seed.
		// Incrementing an initially-string "0" `i` allows `i` to remain a string only in that
		// case, which will result in a "00" `matchedCount` that differs from `i` but is also
		// numerically zero.
		if ( bySet && i !== matchedCount ) {
		j = 0;
		while ( ( matcher = setMatchers[ j++ ] ) ) {
		matcher( unmatched, setMatched, context, xml );
		}

		if ( seed ) {

		// Reintegrate element matches to eliminate the need for sorting
		if ( matchedCount > 0 ) {
		while ( i-- ) {
		if ( !( unmatched[ i ] || setMatched[ i ] ) ) {
		setMatched[ i ] = pop.call( results );
		}
		}
		}

		// Discard index placeholder values to get only actual matches
		setMatched = condense( setMatched );
		}

		// Add matches to results
		push.apply( results, setMatched );

		// Seedless set matches succeeding multiple successful matchers stipulate sorting
		if ( outermost && !seed && setMatched.length > 0 &&
		( matchedCount + setMatchers.length ) > 1 ) {

		jQuery.uniqueSort( results );
		}
		}

		// Override manipulation of globals by nested matchers
		if ( outermost ) {
		dirruns = dirrunsUnique;
		outermostContext = contextBackup;
		}

		return unmatched;
		};

		return bySet ?
		markFunction( superMatcher ) :
		superMatcher;
		}

		function compile( selector, match /* Internal Use Only */ ) {
		var i,
		setMatchers = [],
		elementMatchers = [],
		cached = compilerCache[ selector + " " ];

		if ( !cached ) {

		// Generate a function of recursive functions that can be used to check each element
		if ( !match ) {
		match = tokenize( selector );
		}
		i = match.length;
		while ( i-- ) {
		cached = matcherFromTokens( match[ i ] );
		if ( cached[ expando ] ) {
		setMatchers.push( cached );
		} else {
		elementMatchers.push( cached );
		}
		}

		// Cache the compiled function
		cached = compilerCache( selector,
		matcherFromGroupMatchers( elementMatchers, setMatchers ) );

		// Save selector and tokenization
		cached.selector = selector;
		}
		return cached;
		}

		/**
		* A low-level selection function that works with jQuery's compiled
		* selector functions
		* @param {String|Function} selector A selector or a pre-compiled
		* selector function built with jQuery selector compile
		* @param {Element} context
		* @param {Array} [results]
		* @param {Array} [seed] A set of elements to match against
		*/
		function select( selector, context, results, seed ) {
		var i, tokens, token, type, find,
		compiled = typeof selector === "function" && selector,
		match = !seed && tokenize( ( selector = compiled.selector || selector ) );

		results = results || [];

		// Try to minimize operations if there is only one selector in the list and no seed
		// (the latter of which guarantees us context)
		if ( match.length === 1 ) {

		// Reduce context if the leading compound selector is an ID
		tokens = match[ 0 ] = match[ 0 ].slice( 0 );
		if ( tokens.length > 2 && ( token = tokens[ 0 ] ).type === "ID" &&
		context.nodeType === 9 && documentIsHTML && Expr.relative[ tokens[ 1 ].type ] ) {

		context = ( Expr.find.ID(
		token.matches[ 0 ].replace( runescape, funescape ),
		context
		) || [] )[ 0 ];
		if ( !context ) {
		return results;

		// Precompiled matchers will still verify ancestry, so step up a level
		} else if ( compiled ) {
		context = context.parentNode;
		}

		selector = selector.slice( tokens.shift().value.length );
		}

		// Fetch a seed set for right-to-left matching
		i = matchExpr.needsContext.test( selector ) ? 0 : tokens.length;
		while ( i-- ) {
		token = tokens[ i ];

		// Abort if we hit a combinator
		if ( Expr.relative[ ( type = token.type ) ] ) {
		break;
		}
		if ( ( find = Expr.find[ type ] ) ) {

		// Search, expanding context for leading sibling combinators
		if ( ( seed = find(
		token.matches[ 0 ].replace( runescape, funescape ),
		rsibling.test( tokens[ 0 ].type ) &&
		testContext( context.parentNode ) || context
		) ) ) {

		// If seed is empty or no tokens remain, we can return early
		tokens.splice( i, 1 );
		selector = seed.length && toSelector( tokens );
		if ( !selector ) {
		push.apply( results, seed );
		return results;
		}

		break;
		}
		}
		}
		}

		// Compile and execute a filtering function if one is not provided
		// Provide `match` to avoid retokenization if we modified the selector above
		( compiled || compile( selector, match ) )(
		seed,
		context,
		!documentIsHTML,
		results,
		!context || rsibling.test( selector ) && testContext( context.parentNode ) || context
		);
		return results;
		}

		// One-time assignments

		// Support: Android <=4.0 - 4.1+
		// Sort stability
		support.sortStable = expando.split( "" ).sort( sortOrder ).join( "" ) === expando;

		// Initialize against the default document
		setDocument();

		// Support: Android <=4.0 - 4.1+
		// Detached nodes confoundingly follow *each other*
		support.sortDetached = assert( function( el ) {

		// Should return 1, but returns 4 (following)
		return el.compareDocumentPosition( document.createElement( "fieldset" ) ) & 1;
		} );

		jQuery.find = find;

		// Deprecated
		jQuery.expr[ ":" ] = jQuery.expr.pseudos;
		jQuery.unique = jQuery.uniqueSort;

		// These have always been private, but they used to be documented
		// as part of Sizzle so let's maintain them in the 3.x line
		// for backwards compatibility purposes.
		find.compile = compile;
		find.select = select;
		find.setDocument = setDocument;

		find.escape = jQuery.escapeSelector;
		find.getText = jQuery.text;
		find.isXML = jQuery.isXMLDoc;
		find.selectors = jQuery.expr;
		find.support = jQuery.support;
		find.uniqueSort = jQuery.uniqueSort;

		/* eslint-enable */

		} )();


		var dir = function( elem, dir, until ) {
		var matched = [],
		truncate = until !== undefined;

		while ( ( elem = elem[ dir ] ) && elem.nodeType !== 9 ) {
		if ( elem.nodeType === 1 ) {
		if ( truncate && jQuery( elem ).is( until ) ) {
		break;
		}
		matched.push( elem );
		}
		}
		return matched;
		};


		var siblings = function( n, elem ) {
		var matched = [];

		for ( ; n; n = n.nextSibling ) {
		if ( n.nodeType === 1 && n !== elem ) {
		matched.push( n );
		}
		}

		return matched;
		};


		var rneedsContext = jQuery.expr.match.needsContext;

		var rsingleTag = ( /^<([a-z][^\/\0>:\x20\t\r\n\f]*)[\x20\t\r\n\f]*\/?>(?:<\/\1>|)$/i );


		// Implement the identical functionality for filter and not
		function winnow( elements, qualifier, not ) {
		if ( isFunction( qualifier ) ) {
		return jQuery.grep( elements, function( elem, i ) {
		return !!qualifier.call( elem, i, elem ) !== not;
		} );
		}

		// Single element
		if ( qualifier.nodeType ) {
		return jQuery.grep( elements, function( elem ) {
		return ( elem === qualifier ) !== not;
		} );
		}

		// Arraylike of elements (jQuery, arguments, Array)
		if ( typeof qualifier !== "string" ) {
		return jQuery.grep( elements, function( elem ) {
		return ( indexOf.call( qualifier, elem ) > -1 ) !== not;
		} );
		}

		// Filtered directly for both simple and complex selectors
		return jQuery.filter( qualifier, elements, not );
		}

		jQuery.filter = function( expr, elems, not ) {
		var elem = elems[ 0 ];

		if ( not ) {
		expr = ":not(" + expr + ")";
		}

		if ( elems.length === 1 && elem.nodeType === 1 ) {
		return jQuery.find.matchesSelector( elem, expr ) ? [ elem ] : [];
		}

		return jQuery.find.matches( expr, jQuery.grep( elems, function( elem ) {
		return elem.nodeType === 1;
		} ) );
		};

		jQuery.fn.extend( {
		find: function( selector ) {
		var i, ret,
		len = this.length,
		self = this;

		if ( typeof selector !== "string" ) {
		return this.pushStack( jQuery( selector ).filter( function() {
		for ( i = 0; i < len; i++ ) {
		if ( jQuery.contains( self[ i ], this ) ) {
		return true;
		}
		}
		} ) );
		}

		ret = this.pushStack( [] );

		for ( i = 0; i < len; i++ ) {
		jQuery.find( selector, self[ i ], ret );
		}

		return len > 1 ? jQuery.uniqueSort( ret ) : ret;
		},
		filter: function( selector ) {
		return this.pushStack( winnow( this, selector || [], false ) );
		},
		not: function( selector ) {
		return this.pushStack( winnow( this, selector || [], true ) );
		},
		is: function( selector ) {
		return !!winnow(
		this,

		// If this is a positional/relative selector, check membership in the returned set
		// so $("p:first").is("p:last") won't return true for a doc with two "p".
		typeof selector === "string" && rneedsContext.test( selector ) ?
		jQuery( selector ) :
		selector || [],
		false
		).length;
		}
		} );


		// Initialize a jQuery object


		// A central reference to the root jQuery(document)
		var rootjQuery,

		// A simple way to check for HTML strings
		// Prioritize #id over
		<tag> to avoid XSS via location.hash (trac-9521)
			// Strict HTML recognition (trac-11290: must start with <)
			// Shortcut simple #id case for speed
			rquickExpr = /^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]+))$/,

			init = jQuery.fn.init = function( selector, context, root ) {
			var match, elem;

			// HANDLE: $(""), $(null), $(undefined), $(false)
			if ( !selector ) {
			return this;
			}

			// Method init() accepts an alternate rootjQuery
			// so migrate can support jQuery.sub (gh-2101)
			root = root || rootjQuery;

			// Handle HTML strings
			if ( typeof selector === "string" ) {
			if ( selector[ 0 ] === "<" &&
			selector[ selector.length - 1 ] === ">" &&
			selector.length >= 3 ) {

			// Assume that strings that start and end with <> are HTML and skip the regex check
			match = [ null, selector, null ];

			} else {
			match = rquickExpr.exec( selector );
			}

			// Match html or make sure no context is specified for #id
			if ( match && ( match[ 1 ] || !context ) ) {

			// HANDLE: $(html) -> $(array)
			if ( match[ 1 ] ) {
			context = context instanceof jQuery ? context[ 0 ] : context;

			// Option to run scripts is true for back-compat
			// Intentionally let the error be thrown if parseHTML is not present
			jQuery.merge( this, jQuery.parseHTML(
			match[ 1 ],
			context && context.nodeType ? context.ownerDocument || context : document,
			true
			) );

			// HANDLE: $(html, props)
			if ( rsingleTag.test( match[ 1 ] ) && jQuery.isPlainObject( context ) ) {
			for ( match in context ) {

			// Properties of context are called as methods if possible
			if ( isFunction( this[ match ] ) ) {
			this[ match ]( context[ match ] );

			// ...and otherwise set as attributes
			} else {
			this.attr( match, context[ match ] );
			}
			}
			}

			return this;

			// HANDLE: $(#id)
			} else {
			elem = document.getElementById( match[ 2 ] );

			if ( elem ) {

			// Inject the element directly into the jQuery object
			this[ 0 ] = elem;
			this.length = 1;
			}
			return this;
			}

			// HANDLE: $(expr, $(...))
			} else if ( !context || context.jquery ) {
			return ( context || root ).find( selector );

			// HANDLE: $(expr, context)
			// (which is just equivalent to: $(context).find(expr)
			} else {
			return this.constructor( context ).find( selector );
			}

			// HANDLE: $(DOMElement)
			} else if ( selector.nodeType ) {
			this[ 0 ] = selector;
			this.length = 1;
			return this;

			// HANDLE: $(function)
			// Shortcut for document ready
			} else if ( isFunction( selector ) ) {
			return root.ready !== undefined ?
			root.ready( selector ) :

			// Execute immediately if ready is not present
			selector( jQuery );
			}

			return jQuery.makeArray( selector, this );
			};

			// Give the init function the jQuery prototype for later instantiation
			init.prototype = jQuery.fn;

			// Initialize central reference
			rootjQuery = jQuery( document );


			var rparentsprev = /^(?:parents|prev(?:Until|All))/,

			// Methods guaranteed to produce a unique set when starting from a unique set
			guaranteedUnique = {
			children: true,
			contents: true,
			next: true,
			prev: true
			};

			jQuery.fn.extend( {
			has: function( target ) {
			var targets = jQuery( target, this ),
			l = targets.length;

			return this.filter( function() {
			var i = 0;
			for ( ; i < l; i++ ) {
			if ( jQuery.contains( this, targets[ i ] ) ) {
			return true;
			}
			}
			} );
			},

			closest: function( selectors, context ) {
			var cur,
			i = 0,
			l = this.length,
			matched = [],
			targets = typeof selectors !== "string" && jQuery( selectors );

			// Positional selectors never match, since there's no _selection_ context
			if ( !rneedsContext.test( selectors ) ) {
			for ( ; i < l; i++ ) {
			for ( cur = this[ i ]; cur && cur !== context; cur = cur.parentNode ) {

			// Always skip document fragments
			if ( cur.nodeType < 11 && ( targets ?
			targets.index( cur ) > -1 :

			// Don't pass non-elements to jQuery#find
			cur.nodeType === 1 &&
			jQuery.find.matchesSelector( cur, selectors ) ) ) {

			matched.push( cur );
			break;
			}
			}
			}
			}

			return this.pushStack( matched.length > 1 ? jQuery.uniqueSort( matched ) : matched );
			},

			// Determine the position of an element within the set
			index: function( elem ) {

			// No argument, return index in parent
			if ( !elem ) {
			return ( this[ 0 ] && this[ 0 ].parentNode ) ? this.first().prevAll().length : -1;
			}

			// Index in selector
			if ( typeof elem === "string" ) {
			return indexOf.call( jQuery( elem ), this[ 0 ] );
			}

			// Locate the position of the desired element
			return indexOf.call( this,

			// If it receives a jQuery object, the first element is used
			elem.jquery ? elem[ 0 ] : elem
			);
			},

			add: function( selector, context ) {
			return this.pushStack(
			jQuery.uniqueSort(
			jQuery.merge( this.get(), jQuery( selector, context ) )
			)
			);
			},

			addBack: function( selector ) {
			return this.add( selector == null ?
			this.prevObject : this.prevObject.filter( selector )
			);
			}
			} );

			function sibling( cur, dir ) {
			while ( ( cur = cur[ dir ] ) && cur.nodeType !== 1 ) {}
			return cur;
			}

			jQuery.each( {
			parent: function( elem ) {
			var parent = elem.parentNode;
			return parent && parent.nodeType !== 11 ? parent : null;
			},
			parents: function( elem ) {
			return dir( elem, "parentNode" );
			},
			parentsUntil: function( elem, _i, until ) {
			return dir( elem, "parentNode", until );
			},
			next: function( elem ) {
			return sibling( elem, "nextSibling" );
			},
			prev: function( elem ) {
			return sibling( elem, "previousSibling" );
			},
			nextAll: function( elem ) {
			return dir( elem, "nextSibling" );
			},
			prevAll: function( elem ) {
			return dir( elem, "previousSibling" );
			},
			nextUntil: function( elem, _i, until ) {
			return dir( elem, "nextSibling", until );
			},
			prevUntil: function( elem, _i, until ) {
			return dir( elem, "previousSibling", until );
			},
			siblings: function( elem ) {
			return siblings( ( elem.parentNode || {} ).firstChild, elem );
			},
			children: function( elem ) {
			return siblings( elem.firstChild );
			},
			contents: function( elem ) {
			if ( elem.contentDocument != null &&

			// Support: IE 11+
			//
			<object> elements with no `data` attribute has an object
				// `contentDocument` with a `null` prototype.
				getProto( elem.contentDocument ) ) {

				return elem.contentDocument;
				}

				// Support: IE 9 - 11 only, iOS 7 only, Android Browser <=4.3 only
				// Treat the template element as a regular one in browsers that
				// don't support it.
				if ( nodeName( elem, "template" ) ) {
				elem = elem.content || elem;
				}

				return jQuery.merge( [], elem.childNodes );
				}
				}, function( name, fn ) {
				jQuery.fn[ name ] = function( until, selector ) {
				var matched = jQuery.map( this, fn, until );

				if ( name.slice( -5 ) !== "Until" ) {
				selector = until;
				}

				if ( selector && typeof selector === "string" ) {
				matched = jQuery.filter( selector, matched );
				}

				if ( this.length > 1 ) {

				// Remove duplicates
				if ( !guaranteedUnique[ name ] ) {
				jQuery.uniqueSort( matched );
				}

				// Reverse order for parents* and prev-derivatives
				if ( rparentsprev.test( name ) ) {
				matched.reverse();
				}
				}

				return this.pushStack( matched );
				};
				} );
				var rnothtmlwhite = ( /[^\x20\t\r\n\f]+/g );


				// Convert String-formatted options into Object-formatted ones
				function createOptions( options ) {
				var object = {};
				jQuery.each( options.match( rnothtmlwhite ) || [], function( _, flag ) {
				object[ flag ] = true;
				} );
				return object;
				}

				/*
				* Create a callback list using the following parameters:
				*
				* options: an optional list of space-separated options that will change how
				* the callback list behaves or a more traditional option object
				*
				* By default a callback list will act like an event callback list and can be
				* "fired" multiple times.
				*
				* Possible options:
				*
				* once: will ensure the callback list can only be fired once (like a Deferred)
				*
				* memory: will keep track of previous values and will call any callback added
				* after the list has been fired right away with the latest "memorized"
				* values (like a Deferred)
				*
				* unique: will ensure a callback can only be added once (no duplicate in the list)
				*
				* stopOnFalse: interrupt callings when a callback returns false
				*
				*/
				jQuery.Callbacks = function( options ) {

				// Convert options from String-formatted to Object-formatted if needed
				// (we check in cache first)
				options = typeof options === "string" ?
				createOptions( options ) :
				jQuery.extend( {}, options );

				var // Flag to know if list is currently firing
				firing,

				// Last fire value for non-forgettable lists
				memory,

				// Flag to know if list was already fired
				fired,

				// Flag to prevent firing
				locked,

				// Actual callback list
				list = [],

				// Queue of execution data for repeatable lists
				queue = [],

				// Index of currently firing callback (modified by add/remove as needed)
				firingIndex = -1,

				// Fire callbacks
				fire = function() {

				// Enforce single-firing
				locked = locked || options.once;

				// Execute callbacks for all pending executions,
				// respecting firingIndex overrides and runtime changes
				fired = firing = true;
				for ( ; queue.length; firingIndex = -1 ) {
				memory = queue.shift();
				while ( ++firingIndex < list.length ) {

				// Run callback and check for early termination
				if ( list[ firingIndex ].apply( memory[ 0 ], memory[ 1 ] ) === false &&
				options.stopOnFalse ) {

				// Jump to end and forget the data so .add doesn't re-fire
				firingIndex = list.length;
				memory = false;
				}
				}
				}

				// Forget the data if we're done with it
				if ( !options.memory ) {
				memory = false;
				}

				firing = false;

				// Clean up if we're done firing for good
				if ( locked ) {

				// Keep an empty list if we have data for future add calls
				if ( memory ) {
				list = [];

				// Otherwise, this object is spent
				} else {
				list = "";
				}
				}
				},

				// Actual Callbacks object
				self = {

				// Add a callback or a collection of callbacks to the list
				add: function() {
				if ( list ) {

				// If we have memory from a past run, we should fire after adding
				if ( memory && !firing ) {
				firingIndex = list.length - 1;
				queue.push( memory );
				}

				( function add( args ) {
				jQuery.each( args, function( _, arg ) {
				if ( isFunction( arg ) ) {
				if ( !options.unique || !self.has( arg ) ) {
				list.push( arg );
				}
				} else if ( arg && arg.length && toType( arg ) !== "string" ) {

				// Inspect recursively
				add( arg );
				}
				} );
				} )( arguments );

				if ( memory && !firing ) {
				fire();
				}
				}
				return this;
				},

				// Remove a callback from the list
				remove: function() {
				jQuery.each( arguments, function( _, arg ) {
				var index;
				while ( ( index = jQuery.inArray( arg, list, index ) ) > -1 ) {
				list.splice( index, 1 );

				// Handle firing indexes
				if ( index <= firingIndex ) {
				firingIndex--;
				}
				}
				} );
				return this;
				},

				// Check if a given callback is in the list.
				// If no argument is given, return whether or not list has callbacks attached.
				has: function( fn ) {
				return fn ?
				jQuery.inArray( fn, list ) > -1 :
				list.length > 0;
				},

				// Remove all callbacks from the list
				empty: function() {
				if ( list ) {
				list = [];
				}
				return this;
				},

				// Disable .fire and .add
				// Abort any current/pending executions
				// Clear all callbacks and values
				disable: function() {
				locked = queue = [];
				list = memory = "";
				return this;
				},
				disabled: function() {
				return !list;
				},

				// Disable .fire
				// Also disable .add unless we have memory (since it would have no effect)
				// Abort any pending executions
				lock: function() {
				locked = queue = [];
				if ( !memory && !firing ) {
				list = memory = "";
				}
				return this;
				},
				locked: function() {
				return !!locked;
				},

				// Call all callbacks with the given context and arguments
				fireWith: function( context, args ) {
				if ( !locked ) {
				args = args || [];
				args = [ context, args.slice ? args.slice() : args ];
				queue.push( args );
				if ( !firing ) {
				fire();
				}
				}
				return this;
				},

				// Call all the callbacks with the given arguments
				fire: function() {
				self.fireWith( this, arguments );
				return this;
				},

				// To know if the callbacks have already been called at least once
				fired: function() {
				return !!fired;
				}
				};

				return self;
				};


				function Identity( v ) {
				return v;
				}
				function Thrower( ex ) {
				throw ex;
				}

				function adoptValue( value, resolve, reject, noValue ) {
				var method;

				try {

				// Check for promise aspect first to privilege synchronous behavior
				if ( value && isFunction( ( method = value.promise ) ) ) {
				method.call( value ).done( resolve ).fail( reject );

				// Other thenables
				} else if ( value && isFunction( ( method = value.then ) ) ) {
				method.call( value, resolve, reject );

				// Other non-thenables
				} else {

				// Control `resolve` arguments by letting Array#slice cast boolean `noValue` to integer:
				// * false: [ value ].slice( 0 ) => resolve( value )
				// * true: [ value ].slice( 1 ) => resolve()
				resolve.apply( undefined, [ value ].slice( noValue ) );
				}

				// For Promises/A+, convert exceptions into rejections
				// Since jQuery.when doesn't unwrap thenables, we can skip the extra checks appearing in
				// Deferred#then to conditionally suppress rejection.
				} catch ( value ) {

				// Support: Android 4.0 only
				// Strict mode functions invoked without .call/.apply get global-object context
				reject.apply( undefined, [ value ] );
				}
				}

				jQuery.extend( {

				Deferred: function( func ) {
				var tuples = [

				// action, add listener, callbacks,
				// ... .then handlers, argument index, [final state]
				[ "notify", "progress", jQuery.Callbacks( "memory" ),
				jQuery.Callbacks( "memory" ), 2 ],
				[ "resolve", "done", jQuery.Callbacks( "once memory" ),
				jQuery.Callbacks( "once memory" ), 0, "resolved" ],
				[ "reject", "fail", jQuery.Callbacks( "once memory" ),
				jQuery.Callbacks( "once memory" ), 1, "rejected" ]
				],
				state = "pending",
				promise = {
				state: function() {
				return state;
				},
				always: function() {
				deferred.done( arguments ).fail( arguments );
				return this;
				},
				"catch": function( fn ) {
				return promise.then( null, fn );
				},

				// Keep pipe for back-compat
				pipe: function( /* fnDone, fnFail, fnProgress */ ) {
				var fns = arguments;

				return jQuery.Deferred( function( newDefer ) {
				jQuery.each( tuples, function( _i, tuple ) {

				// Map tuples (progress, done, fail) to arguments (done, fail, progress)
				var fn = isFunction( fns[ tuple[ 4 ] ] ) && fns[ tuple[ 4 ] ];

				// deferred.progress(function() { bind to newDefer or newDefer.notify })
				// deferred.done(function() { bind to newDefer or newDefer.resolve })
				// deferred.fail(function() { bind to newDefer or newDefer.reject })
				deferred[ tuple[ 1 ] ]( function() {
				var returned = fn && fn.apply( this, arguments );
				if ( returned && isFunction( returned.promise ) ) {
				returned.promise()
				.progress( newDefer.notify )
				.done( newDefer.resolve )
				.fail( newDefer.reject );
				} else {
				newDefer[ tuple[ 0 ] + "With" ](
				this,
				fn ? [ returned ] : arguments
				);
				}
				} );
				} );
				fns = null;
				} ).promise();
				},
				then: function( onFulfilled, onRejected, onProgress ) {
				var maxDepth = 0;
				function resolve( depth, deferred, handler, special ) {
				return function() {
				var that = this,
				args = arguments,
				mightThrow = function() {
				var returned, then;

				// Support: Promises/A+ section 2.3.3.3.3
				// https://promisesaplus.com/#point-59
				// Ignore double-resolution attempts
				if ( depth < maxDepth ) {
				return;
				}

				returned = handler.apply( that, args );

				// Support: Promises/A+ section 2.3.1
				// https://promisesaplus.com/#point-48
				if ( returned === deferred.promise() ) {
				throw new TypeError( "Thenable self-resolution" );
				}

				// Support: Promises/A+ sections 2.3.3.1, 3.5
				// https://promisesaplus.com/#point-54
				// https://promisesaplus.com/#point-75
				// Retrieve `then` only once
				then = returned &&

				// Support: Promises/A+ section 2.3.4
				// https://promisesaplus.com/#point-64
				// Only check objects and functions for thenability
				( typeof returned === "object" ||
				typeof returned === "function" ) &&
				returned.then;

				// Handle a returned thenable
				if ( isFunction( then ) ) {

				// Special processors (notify) just wait for resolution
				if ( special ) {
				then.call(
				returned,
				resolve( maxDepth, deferred, Identity, special ),
				resolve( maxDepth, deferred, Thrower, special )
				);

				// Normal processors (resolve) also hook into progress
				} else {

				// ...and disregard older resolution values
				maxDepth++;

				then.call(
				returned,
				resolve( maxDepth, deferred, Identity, special ),
				resolve( maxDepth, deferred, Thrower, special ),
				resolve( maxDepth, deferred, Identity,
				deferred.notifyWith )
				);
				}

				// Handle all other returned values
				} else {

				// Only substitute handlers pass on context
				// and multiple values (non-spec behavior)
				if ( handler !== Identity ) {
				that = undefined;
				args = [ returned ];
				}

				// Process the value(s)
				// Default process is resolve
				( special || deferred.resolveWith )( that, args );
				}
				},

				// Only normal processors (resolve) catch and reject exceptions
				process = special ?
				mightThrow :
				function() {
				try {
				mightThrow();
				} catch ( e ) {

				if ( jQuery.Deferred.exceptionHook ) {
				jQuery.Deferred.exceptionHook( e,
				process.error );
				}

				// Support: Promises/A+ section 2.3.3.3.4.1
				// https://promisesaplus.com/#point-61
				// Ignore post-resolution exceptions
				if ( depth + 1 >= maxDepth ) {

				// Only substitute handlers pass on context
				// and multiple values (non-spec behavior)
				if ( handler !== Thrower ) {
				that = undefined;
				args = [ e ];
				}

				deferred.rejectWith( that, args );
				}
				}
				};

				// Support: Promises/A+ section 2.3.3.3.1
				// https://promisesaplus.com/#point-57
				// Re-resolve promises immediately to dodge false rejection from
				// subsequent errors
				if ( depth ) {
				process();
				} else {

				// Call an optional hook to record the error, in case of exception
				// since it's otherwise lost when execution goes async
				if ( jQuery.Deferred.getErrorHook ) {
				process.error = jQuery.Deferred.getErrorHook();

				// The deprecated alias of the above. While the name suggests
				// returning the stack, not an error instance, jQuery just passes
				// it directly to `console.warn` so both will work; an instance
				// just better cooperates with source maps.
				} else if ( jQuery.Deferred.getStackHook ) {
				process.error = jQuery.Deferred.getStackHook();
				}
				window.setTimeout( process );
				}
				};
				}

				return jQuery.Deferred( function( newDefer ) {

				// progress_handlers.add( ... )
				tuples[ 0 ][ 3 ].add(
				resolve(
				0,
				newDefer,
				isFunction( onProgress ) ?
				onProgress :
				Identity,
				newDefer.notifyWith
				)
				);

				// fulfilled_handlers.add( ... )
				tuples[ 1 ][ 3 ].add(
				resolve(
				0,
				newDefer,
				isFunction( onFulfilled ) ?
				onFulfilled :
				Identity
				)
				);

				// rejected_handlers.add( ... )
				tuples[ 2 ][ 3 ].add(
				resolve(
				0,
				newDefer,
				isFunction( onRejected ) ?
				onRejected :
				Thrower
				)
				);
				} ).promise();
				},

				// Get a promise for this deferred
				// If obj is provided, the promise aspect is added to the object
				promise: function( obj ) {
				return obj != null ? jQuery.extend( obj, promise ) : promise;
				}
				},
				deferred = {};

				// Add list-specific methods
				jQuery.each( tuples, function( i, tuple ) {
				var list = tuple[ 2 ],
				stateString = tuple[ 5 ];

				// promise.progress = list.add
				// promise.done = list.add
				// promise.fail = list.add
				promise[ tuple[ 1 ] ] = list.add;

				// Handle state
				if ( stateString ) {
				list.add(
				function() {

				// state = "resolved" (i.e., fulfilled)
				// state = "rejected"
				state = stateString;
				},

				// rejected_callbacks.disable
				// fulfilled_callbacks.disable
				tuples[ 3 - i ][ 2 ].disable,

				// rejected_handlers.disable
				// fulfilled_handlers.disable
				tuples[ 3 - i ][ 3 ].disable,

				// progress_callbacks.lock
				tuples[ 0 ][ 2 ].lock,

				// progress_handlers.lock
				tuples[ 0 ][ 3 ].lock
				);
				}

				// progress_handlers.fire
				// fulfilled_handlers.fire
				// rejected_handlers.fire
				list.add( tuple[ 3 ].fire );

				// deferred.notify = function() { deferred.notifyWith(...) }
				// deferred.resolve = function() { deferred.resolveWith(...) }
				// deferred.reject = function() { deferred.rejectWith(...) }
				deferred[ tuple[ 0 ] ] = function() {
				deferred[ tuple[ 0 ] + "With" ]( this === deferred ? undefined : this, arguments );
				return this;
				};

				// deferred.notifyWith = list.fireWith
				// deferred.resolveWith = list.fireWith
				// deferred.rejectWith = list.fireWith
				deferred[ tuple[ 0 ] + "With" ] = list.fireWith;
				} );

				// Make the deferred a promise
				promise.promise( deferred );

				// Call given func if any
				if ( func ) {
				func.call( deferred, deferred );
				}

				// All done!
				return deferred;
				},

				// Deferred helper
				when: function( singleValue ) {
				var

				// count of uncompleted subordinates
				remaining = arguments.length,

				// count of unprocessed arguments
				i = remaining,

				// subordinate fulfillment data
				resolveContexts = Array( i ),
				resolveValues = slice.call( arguments ),

				// the primary Deferred
				primary = jQuery.Deferred(),

				// subordinate callback factory
				updateFunc = function( i ) {
				return function( value ) {
				resolveContexts[ i ] = this;
				resolveValues[ i ] = arguments.length > 1 ? slice.call( arguments ) : value;
				if ( !( --remaining ) ) {
				primary.resolveWith( resolveContexts, resolveValues );
				}
				};
				};

				// Single- and empty arguments are adopted like Promise.resolve
				if ( remaining <= 1 ) {
				adoptValue( singleValue, primary.done( updateFunc( i ) ).resolve, primary.reject,
				!remaining );

				// Use .then() to unwrap secondary thenables (cf. gh-3000)
				if ( primary.state() === "pending" ||
				isFunction( resolveValues[ i ] && resolveValues[ i ].then ) ) {

				return primary.then();
				}
				}

				// Multiple arguments are aggregated like Promise.all array elements
				while ( i-- ) {
				adoptValue( resolveValues[ i ], updateFunc( i ), primary.reject );
				}

				return primary.promise();
				}
				} );


				// These usually indicate a programmer mistake during development,
				// warn about them ASAP rather than swallowing them by default.
				var rerrorNames = /^(Eval|Internal|Range|Reference|Syntax|Type|URI)Error$/;

				// If `jQuery.Deferred.getErrorHook` is defined, `asyncError` is an error
				// captured before the async barrier to get the original error cause
				// which may otherwise be hidden.
				jQuery.Deferred.exceptionHook = function( error, asyncError ) {

				// Support: IE 8 - 9 only
				// Console exists when dev tools are open, which can happen at any time
				if ( window.console && window.console.warn && error && rerrorNames.test( error.name ) ) {
				window.console.warn( "jQuery.Deferred exception: " + error.message,
				error.stack, asyncError );
				}
				};


				jQuery.readyException = function( error ) {
				window.setTimeout( function() {
				throw error;
				} );
				};


				// The deferred used on DOM ready
				var readyList = jQuery.Deferred();

				jQuery.fn.ready = function( fn ) {

				readyList
				.then( fn )

				// Wrap jQuery.readyException in a function so that the lookup
				// happens at the time of error handling instead of callback
				// registration.
				.catch( function( error ) {
				jQuery.readyException( error );
				} );

				return this;
				};

				jQuery.extend( {

				// Is the DOM ready to be used? Set to true once it occurs.
				isReady: false,

				// A counter to track how many items to wait for before
				// the ready event fires. See trac-6781
				readyWait: 1,

				// Handle when the DOM is ready
				ready: function( wait ) {

				// Abort if there are pending holds or we're already ready
				if ( wait === true ? --jQuery.readyWait : jQuery.isReady ) {
				return;
				}

				// Remember that the DOM is ready
				jQuery.isReady = true;

				// If a normal DOM Ready event fired, decrement, and wait if need be
				if ( wait !== true && --jQuery.readyWait > 0 ) {
				return;
				}

				// If there are functions bound, to execute
				readyList.resolveWith( document, [ jQuery ] );
				}
				} );

				jQuery.ready.then = readyList.then;

				// The ready event handler and self cleanup method
				function completed() {
				document.removeEventListener( "DOMContentLoaded", completed );
				window.removeEventListener( "load", completed );
				jQuery.ready();
				}

				// Catch cases where $(document).ready() is called
				// after the browser event has already occurred.
				// Support: IE <=9 - 10 only
				// Older IE sometimes signals "interactive" too soon
				if ( document.readyState === "complete" ||
				( document.readyState !== "loading" && !document.documentElement.doScroll ) ) {

				// Handle it asynchronously to allow scripts the opportunity to delay ready
				window.setTimeout( jQuery.ready );

				} else {

				// Use the handy event callback
				document.addEventListener( "DOMContentLoaded", completed );

				// A fallback to window.onload, that will always work
				window.addEventListener( "load", completed );
				}


				// Multifunctional method to get and set values of a collection
				// The value/s can optionally be executed if it's a function
				var access = function( elems, fn, key, value, chainable, emptyGet, raw ) {
				var i = 0,
				len = elems.length,
				bulk = key == null;

				// Sets many values
				if ( toType( key ) === "object" ) {
				chainable = true;
				for ( i in key ) {
				access( elems, fn, i, key[ i ], true, emptyGet, raw );
				}

				// Sets one value
				} else if ( value !== undefined ) {
				chainable = true;

				if ( !isFunction( value ) ) {
				raw = true;
				}

				if ( bulk ) {

				// Bulk operations run against the entire set
				if ( raw ) {
				fn.call( elems, value );
				fn = null;

				// ...except when executing function values
				} else {
				bulk = fn;
				fn = function( elem, _key, value ) {
				return bulk.call( jQuery( elem ), value );
				};
				}
				}

				if ( fn ) {
				for ( ; i < len; i++ ) {
				fn(
				elems[ i ], key, raw ?
				value :
				value.call( elems[ i ], i, fn( elems[ i ], key ) )
				);
				}
				}
				}

				if ( chainable ) {
				return elems;
				}

				// Gets
				if ( bulk ) {
				return fn.call( elems );
				}

				return len ? fn( elems[ 0 ], key ) : emptyGet;
				};


				// Matches dashed string for camelizing
				var rmsPrefix = /^-ms-/,
				rdashAlpha = /-([a-z])/g;

				// Used by camelCase as callback to replace()
				function fcamelCase( _all, letter ) {
				return letter.toUpperCase();
				}

				// Convert dashed to camelCase; used by the css and data modules
				// Support: IE <=9 - 11, Edge 12 - 15
				// Microsoft forgot to hump their vendor prefix (trac-9572)
				function camelCase( string ) {
				return string.replace( rmsPrefix, "ms-" ).replace( rdashAlpha, fcamelCase );
				}
				var acceptData = function( owner ) {

				// Accepts only:
				// - Node
				// - Node.ELEMENT_NODE
				// - Node.DOCUMENT_NODE
				// - Object
				// - Any
				return owner.nodeType === 1 || owner.nodeType === 9 || !( +owner.nodeType );
				};


				function Data() {
				this.expando = jQuery.expando + Data.uid++;
				}

				Data.uid = 1;

				Data.prototype = {

				cache: function( owner ) {

				// Check if the owner object already has a cache
				var value = owner[ this.expando ];

				// If not, create one
				if ( !value ) {
				value = {};

				// We can accept data for non-element nodes in modern browsers,
				// but we should not, see trac-8335.
				// Always return an empty object.
				if ( acceptData( owner ) ) {

				// If it is a node unlikely to be stringify-ed or looped over
				// use plain assignment
				if ( owner.nodeType ) {
				owner[ this.expando ] = value;

				// Otherwise secure it in a non-enumerable property
				// configurable must be true to allow the property to be
				// deleted when data is removed
				} else {
				Object.defineProperty( owner, this.expando, {
				value: value,
				configurable: true
				} );
				}
				}
				}

				return value;
				},
				set: function( owner, data, value ) {
				var prop,
				cache = this.cache( owner );

				// Handle: [ owner, key, value ] args
				// Always use camelCase key (gh-2257)
				if ( typeof data === "string" ) {
				cache[ camelCase( data ) ] = value;

				// Handle: [ owner, { properties } ] args
				} else {

				// Copy the properties one-by-one to the cache object
				for ( prop in data ) {
				cache[ camelCase( prop ) ] = data[ prop ];
				}
				}
				return cache;
				},
				get: function( owner, key ) {
				return key === undefined ?
				this.cache( owner ) :

				// Always use camelCase key (gh-2257)
				owner[ this.expando ] && owner[ this.expando ][ camelCase( key ) ];
				},
				access: function( owner, key, value ) {

				// In cases where either:
				//
				// 1. No key was specified
				// 2. A string key was specified, but no value provided
				//
				// Take the "read" path and allow the get method to determine
				// which value to return, respectively either:
				//
				// 1. The entire cache object
				// 2. The data stored at the key
				//
				if ( key === undefined ||
				( ( key && typeof key === "string" ) && value === undefined ) ) {

				return this.get( owner, key );
				}

				// When the key is not a string, or both a key and value
				// are specified, set or extend (existing objects) with either:
				//
				// 1. An object of properties
				// 2. A key and value
				//
				this.set( owner, key, value );

				// Since the "set" path can have two possible entry points
				// return the expected data based on which path was taken[*]
				return value !== undefined ? value : key;
				},
				remove: function( owner, key ) {
				var i,
				cache = owner[ this.expando ];

				if ( cache === undefined ) {
				return;
				}

				if ( key !== undefined ) {

				// Support array or space separated string of keys
				if ( Array.isArray( key ) ) {

				// If key is an array of keys...
				// We always set camelCase keys, so remove that.
				key = key.map( camelCase );
				} else {
				key = camelCase( key );

				// If a key with the spaces exists, use it.
				// Otherwise, create an array by matching non-whitespace
				key = key in cache ?
				[ key ] :
				( key.match( rnothtmlwhite ) || [] );
				}

				i = key.length;

				while ( i-- ) {
				delete cache[ key[ i ] ];
				}
				}

				// Remove the expando if there's no more data
				if ( key === undefined || jQuery.isEmptyObject( cache ) ) {

				// Support: Chrome <=35 - 45
				// Webkit & Blink performance suffers when deleting properties
				// from DOM nodes, so set to undefined instead
				// https://bugs.chromium.org/p/chromium/issues/detail?id=378607 (bug restricted)
				if ( owner.nodeType ) {
				owner[ this.expando ] = undefined;
				} else {
				delete owner[ this.expando ];
				}
				}
				},
				hasData: function( owner ) {
				var cache = owner[ this.expando ];
				return cache !== undefined && !jQuery.isEmptyObject( cache );
				}
				};
				var dataPriv = new Data();

				var dataUser = new Data();


				// Implementation Summary
				//
				// 1. Enforce API surface and semantic compatibility with 1.9.x branch
				// 2. Improve the module's maintainability by reducing the storage
				// paths to a single mechanism.
				// 3. Use the same single mechanism to support "private" and "user" data.
				// 4. _Never_ expose "private" data to user code (TODO: Drop _data, _removeData)
				// 5. Avoid exposing implementation details on user objects (eg. expando properties)
				// 6. Provide a clear path for implementation upgrade to WeakMap in 2014

				var rbrace = /^(?:\{[\w\W]*\}|\[[\w\W]*\])$/,
				rmultiDash = /[A-Z]/g;

				function getData( data ) {
				if ( data === "true" ) {
				return true;
				}

				if ( data === "false" ) {
				return false;
				}

				if ( data === "null" ) {
				return null;
				}

				// Only convert to a number if it doesn't change the string
				if ( data === +data + "" ) {
				return +data;
				}

				if ( rbrace.test( data ) ) {
				return JSON.parse( data );
				}

				return data;
				}

				function dataAttr( elem, key, data ) {
				var name;

				// If nothing was found internally, try to fetch any
				// data from the HTML5 data-* attribute
				if ( data === undefined && elem.nodeType === 1 ) {
				name = "data-" + key.replace( rmultiDash, "-$&" ).toLowerCase();
				data = elem.getAttribute( name );

				if ( typeof data === "string" ) {
				try {
				data = getData( data );
				} catch ( e ) {}

				// Make sure we set the data so it isn't changed later
				dataUser.set( elem, key, data );
				} else {
				data = undefined;
				}
				}
				return data;
				}

				jQuery.extend( {
				hasData: function( elem ) {
				return dataUser.hasData( elem ) || dataPriv.hasData( elem );
				},

				data: function( elem, name, data ) {
				return dataUser.access( elem, name, data );
				},

				removeData: function( elem, name ) {
				dataUser.remove( elem, name );
				},

				// TODO: Now that all calls to _data and _removeData have been replaced
				// with direct calls to dataPriv methods, these can be deprecated.
				_data: function( elem, name, data ) {
				return dataPriv.access( elem, name, data );
				},

				_removeData: function( elem, name ) {
				dataPriv.remove( elem, name );
				}
				} );

				jQuery.fn.extend( {
				data: function( key, value ) {
				var i, name, data,
				elem = this[ 0 ],
				attrs = elem && elem.attributes;

				// Gets all values
				if ( key === undefined ) {
				if ( this.length ) {
				data = dataUser.get( elem );

				if ( elem.nodeType === 1 && !dataPriv.get( elem, "hasDataAttrs" ) ) {
				i = attrs.length;
				while ( i-- ) {

				// Support: IE 11 only
				// The attrs elements can be null (trac-14894)
				if ( attrs[ i ] ) {
				name = attrs[ i ].name;
				if ( name.indexOf( "data-" ) === 0 ) {
				name = camelCase( name.slice( 5 ) );
				dataAttr( elem, name, data[ name ] );
				}
				}
				}
				dataPriv.set( elem, "hasDataAttrs", true );
				}
				}

				return data;
				}

				// Sets multiple values
				if ( typeof key === "object" ) {
				return this.each( function() {
				dataUser.set( this, key );
				} );
				}

				return access( this, function( value ) {
				var data;

				// The calling jQuery object (element matches) is not empty
				// (and therefore has an element appears at this[ 0 ]) and the
				// `value` parameter was not undefined. An empty jQuery object
				// will result in `undefined` for elem = this[ 0 ] which will
				// throw an exception if an attempt to read a data cache is made.
				if ( elem && value === undefined ) {

				// Attempt to get data from the cache
				// The key will always be camelCased in Data
				data = dataUser.get( elem, key );
				if ( data !== undefined ) {
				return data;
				}

				// Attempt to "discover" the data in
				// HTML5 custom data-* attrs
				data = dataAttr( elem, key );
				if ( data !== undefined ) {
				return data;
				}

				// We tried really hard, but the data doesn't exist.
				return;
				}

				// Set the data...
				this.each( function() {

				// We always store the camelCased key
				dataUser.set( this, key, value );
				} );
				}, null, value, arguments.length > 1, null, true );
				},

				removeData: function( key ) {
				return this.each( function() {
				dataUser.remove( this, key );
				} );
				}
				} );


				jQuery.extend( {
				queue: function( elem, type, data ) {
				var queue;

				if ( elem ) {
				type = ( type || "fx" ) + "queue";
				queue = dataPriv.get( elem, type );

				// Speed up dequeue by getting out quickly if this is just a lookup
				if ( data ) {
				if ( !queue || Array.isArray( data ) ) {
				queue = dataPriv.access( elem, type, jQuery.makeArray( data ) );
				} else {
				queue.push( data );
				}
				}
				return queue || [];
				}
				},

				dequeue: function( elem, type ) {
				type = type || "fx";

				var queue = jQuery.queue( elem, type ),
				startLength = queue.length,
				fn = queue.shift(),
				hooks = jQuery._queueHooks( elem, type ),
				next = function() {
				jQuery.dequeue( elem, type );
				};

				// If the fx queue is dequeued, always remove the progress sentinel
				if ( fn === "inprogress" ) {
				fn = queue.shift();
				startLength--;
				}

				if ( fn ) {

				// Add a progress sentinel to prevent the fx queue from being
				// automatically dequeued
				if ( type === "fx" ) {
				queue.unshift( "inprogress" );
				}

				// Clear up the last queue stop function
				delete hooks.stop;
				fn.call( elem, next, hooks );
				}

				if ( !startLength && hooks ) {
				hooks.empty.fire();
				}
				},

				// Not public - generate a queueHooks object, or return the current one
				_queueHooks: function( elem, type ) {
				var key = type + "queueHooks";
				return dataPriv.get( elem, key ) || dataPriv.access( elem, key, {
				empty: jQuery.Callbacks( "once memory" ).add( function() {
				dataPriv.remove( elem, [ type + "queue", key ] );
				} )
				} );
				}
				} );

				jQuery.fn.extend( {
				queue: function( type, data ) {
				var setter = 2;

				if ( typeof type !== "string" ) {
				data = type;
				type = "fx";
				setter--;
				}

				if ( arguments.length < setter ) {
				return jQuery.queue( this[ 0 ], type );
				}

				return data === undefined ?
				this :
				this.each( function() {
				var queue = jQuery.queue( this, type, data );

				// Ensure a hooks for this queue
				jQuery._queueHooks( this, type );

				if ( type === "fx" && queue[ 0 ] !== "inprogress" ) {
				jQuery.dequeue( this, type );
				}
				} );
				},
				dequeue: function( type ) {
				return this.each( function() {
				jQuery.dequeue( this, type );
				} );
				},
				clearQueue: function( type ) {
				return this.queue( type || "fx", [] );
				},

				// Get a promise resolved when queues of a certain type
				// are emptied (fx is the type by default)
				promise: function( type, obj ) {
				var tmp,
				count = 1,
				defer = jQuery.Deferred(),
				elements = this,
				i = this.length,
				resolve = function() {
				if ( !( --count ) ) {
				defer.resolveWith( elements, [ elements ] );
				}
				};

				if ( typeof type !== "string" ) {
				obj = type;
				type = undefined;
				}
				type = type || "fx";

				while ( i-- ) {
				tmp = dataPriv.get( elements[ i ], type + "queueHooks" );
				if ( tmp && tmp.empty ) {
				count++;
				tmp.empty.add( resolve );
				}
				}
				resolve();
				return defer.promise( obj );
				}
				} );
				var pnum = ( /[+-]?(?:\d*\.|)\d+(?:[eE][+-]?\d+|)/ ).source;

				var rcssNum = new RegExp( "^(?:([+-])=|)(" + pnum + ")([a-z%]*)$", "i" );


				var cssExpand = [ "Top", "Right", "Bottom", "Left" ];

				var documentElement = document.documentElement;


				var isAttached = function( elem ) {
				return jQuery.contains( elem.ownerDocument, elem );
				},
				composed = { composed: true };

				// Support: IE 9 - 11+, Edge 12 - 18+, iOS 10.0 - 10.2 only
				// Check attachment across shadow DOM boundaries when possible (gh-3504)
				// Support: iOS 10.0-10.2 only
				// Early iOS 10 versions support `attachShadow` but not `getRootNode`,
				// leading to errors. We need to check for `getRootNode`.
				if ( documentElement.getRootNode ) {
				isAttached = function( elem ) {
				return jQuery.contains( elem.ownerDocument, elem ) ||
				elem.getRootNode( composed ) === elem.ownerDocument;
				};
				}
				var isHiddenWithinTree = function( elem, el ) {

				// isHiddenWithinTree might be called from jQuery#filter function;
				// in that case, element will be second argument
				elem = el || elem;

				// Inline style trumps all
				return elem.style.display === "none" ||
				elem.style.display === "" &&

				// Otherwise, check computed style
				// Support: Firefox <=43 - 45
				// Disconnected elements can have computed display: none, so first confirm that elem is
				// in the document.
				isAttached( elem ) &&

				jQuery.css( elem, "display" ) === "none";
				};


				function adjustCSS( elem, prop, valueParts, tween ) {
				var adjusted, scale,
				maxIterations = 20,
				currentValue = tween ?
				function() {
				return tween.cur();
				} :
				function() {
				return jQuery.css( elem, prop, "" );
				},
				initial = currentValue(),
				unit = valueParts && valueParts[ 3 ] || ( jQuery.cssNumber[ prop ] ? "" : "px" ),

				// Starting value computation is required for potential unit mismatches
				initialInUnit = elem.nodeType &&
				( jQuery.cssNumber[ prop ] || unit !== "px" && +initial ) &&
				rcssNum.exec( jQuery.css( elem, prop ) );

				if ( initialInUnit && initialInUnit[ 3 ] !== unit ) {

				// Support: Firefox <=54
				// Halve the iteration target value to prevent interference from CSS upper bounds (gh-2144)
				initial = initial / 2;

				// Trust units reported by jQuery.css
				unit = unit || initialInUnit[ 3 ];

				// Iteratively approximate from a nonzero starting point
				initialInUnit = +initial || 1;

				while ( maxIterations-- ) {

				// Evaluate and update our best guess (doubling guesses that zero out).
				// Finish if the scale equals or crosses 1 (making the old*new product non-positive).
				jQuery.style( elem, prop, initialInUnit + unit );
				if ( ( 1 - scale ) * ( 1 - ( scale = currentValue() / initial || 0.5 ) ) <= 0 ) {
				maxIterations = 0;
				}
				initialInUnit = initialInUnit / scale;

				}

				initialInUnit = initialInUnit * 2;
				jQuery.style( elem, prop, initialInUnit + unit );

				// Make sure we update the tween properties later on
				valueParts = valueParts || [];
				}

				if ( valueParts ) {
				initialInUnit = +initialInUnit || +initial || 0;

				// Apply relative offset (+=/-=) if specified
				adjusted = valueParts[ 1 ] ?
				initialInUnit + ( valueParts[ 1 ] + 1 ) * valueParts[ 2 ] :
				+valueParts[ 2 ];
				if ( tween ) {
				tween.unit = unit;
				tween.start = initialInUnit;
				tween.end = adjusted;
				}
				}
				return adjusted;
				}


				var defaultDisplayMap = {};

				function getDefaultDisplay( elem ) {
				var temp,
				doc = elem.ownerDocument,
				nodeName = elem.nodeName,
				display = defaultDisplayMap[ nodeName ];

				if ( display ) {
				return display;
				}

				temp = doc.body.appendChild( doc.createElement( nodeName ) );
				display = jQuery.css( temp, "display" );

				temp.parentNode.removeChild( temp );

				if ( display === "none" ) {
				display = "block";
				}
				defaultDisplayMap[ nodeName ] = display;

				return display;
				}

				function showHide( elements, show ) {
				var display, elem,
				values = [],
				index = 0,
				length = elements.length;

				// Determine new display value for elements that need to change
				for ( ; index < length; index++ ) {
				elem = elements[ index ];
				if ( !elem.style ) {
				continue;
				}

				display = elem.style.display;
				if ( show ) {

				// Since we force visibility upon cascade-hidden elements, an immediate (and slow)
				// check is required in this first loop unless we have a nonempty display value (either
				// inline or about-to-be-restored)
				if ( display === "none" ) {
				values[ index ] = dataPriv.get( elem, "display" ) || null;
				if ( !values[ index ] ) {
				elem.style.display = "";
				}
				}
				if ( elem.style.display === "" && isHiddenWithinTree( elem ) ) {
				values[ index ] = getDefaultDisplay( elem );
				}
				} else {
				if ( display !== "none" ) {
				values[ index ] = "none";

				// Remember what we're overwriting
				dataPriv.set( elem, "display", display );
				}
				}
				}

				// Set the display of the elements in a second loop to avoid constant reflow
				for ( index = 0; index < length; index++ ) {
				if ( values[ index ] != null ) {
				elements[ index ].style.display = values[ index ];
				}
				}

				return elements;
				}

				jQuery.fn.extend( {
				show: function() {
				return showHide( this, true );
				},
				hide: function() {
				return showHide( this );
				},
				toggle: function( state ) {
				if ( typeof state === "boolean" ) {
				return state ? this.show() : this.hide();
				}

				return this.each( function() {
				if ( isHiddenWithinTree( this ) ) {
				jQuery( this ).show();
				} else {
				jQuery( this ).hide();
				}
				} );
				}
				} );
				var rcheckableType = ( /^(?:checkbox|radio)$/i );

				var rtagName = ( /<([a-z][^\/\0>\x20\t\r\n\f]*)/i );

				var rscriptType = ( /^$|^module$|\/(?:java|ecma)script/i );


				( function() {
				var fragment = document.createDocumentFragment(),
				div = fragment.appendChild( document.createElement( "div" ) ),
				input = document.createElement( "input" );

				// Support: Android 4.0 - 4.3 only
				// Check state lost if the name is set (trac-11217)
				// Support: Windows Web Apps (WWA)
				// `name` and `type` must use .setAttribute for WWA (trac-14901)
				input.setAttribute( "type", "radio" );
				input.setAttribute( "checked", "checked" );
				input.setAttribute( "name", "t" );

				div.appendChild( input );

				// Support: Android <=4.1 only
				// Older WebKit doesn't clone checked state correctly in fragments
				support.checkClone = div.cloneNode( true ).cloneNode( true ).lastChild.checked;

				// Support: IE <=11 only
				// Make sure textarea (and checkbox) defaultValue is properly cloned
				div.innerHTML = "<textarea>x</textarea>";
				support.noCloneChecked = !!div.cloneNode( true ).lastChild.defaultValue;

				// Support: IE <=9 only
				// IE <=9 replaces
				<option> tags with their contents when inserted outside of
					// the select element.
					div.innerHTML = "
				<option></option>
				";
				support.option = !!div.lastChild;
				} )();


				// We have to close these tags to support XHTML (trac-13200)
				var wrapMap = {

				// XHTML parsers do not magically insert elements in the
				// same way that tag soup parsers do. So we cannot shorten
				// this by omitting
				<tbody> or other required elements.
				thead: [ 1, "
				<table>", "</table>
				" ],
				col: [ 2, "
				<table>
					<colgroup>", "</colgroup>
				</table>
				" ],
				tr: [ 2, "
				<table>
					<tbody>", "</tbody>
				</table>
				" ],
				td: [ 3, "
				<table>
					<tbody>
					<tr>", "</tr>
					</tbody>
				</table>
				" ],

				_default: [ 0, "", "" ]
				};

				wrapMap.tbody = wrapMap.tfoot = wrapMap.colgroup = wrapMap.caption = wrapMap.thead;
				wrapMap.th = wrapMap.td;

				// Support: IE <=9 only
				if ( !support.option ) {
				wrapMap.optgroup = wrapMap.option = [ 1, "<select multiple='multiple'>", "</select>" ];
				}


				function getAll( context, tag ) {

				// Support: IE <=9 - 11 only
				// Use typeof to avoid zero-argument method invocation on host objects (trac-15151)
				var ret;

				if ( typeof context.getElementsByTagName !== "undefined" ) {
				ret = context.getElementsByTagName( tag || "*" );

				} else if ( typeof context.querySelectorAll !== "undefined" ) {
				ret = context.querySelectorAll( tag || "*" );

				} else {
				ret = [];
				}

				if ( tag === undefined || tag && nodeName( context, tag ) ) {
				return jQuery.merge( [ context ], ret );
				}

				return ret;
				}


				// Mark scripts as having already been evaluated
				function setGlobalEval( elems, refElements ) {
				var i = 0,
				l = elems.length;

				for ( ; i < l; i++ ) {
				dataPriv.set(
				elems[ i ],
				"globalEval",
				!refElements || dataPriv.get( refElements[ i ], "globalEval" )
				);
				}
				}


				var rhtml = /<|&#?\w+;/;

				function buildFragment( elems, context, scripts, selection, ignored ) {
				var elem, tmp, tag, wrap, attached, j,
				fragment = context.createDocumentFragment(),
				nodes = [],
				i = 0,
				l = elems.length;

				for ( ; i < l; i++ ) {
				elem = elems[ i ];

				if ( elem || elem === 0 ) {

				// Add nodes directly
				if ( toType( elem ) === "object" ) {

				// Support: Android <=4.0 only, PhantomJS 1 only
				// push.apply(_, arraylike) throws on ancient WebKit
				jQuery.merge( nodes, elem.nodeType ? [ elem ] : elem );

				// Convert non-html into a text node
				} else if ( !rhtml.test( elem ) ) {
				nodes.push( context.createTextNode( elem ) );

				// Convert html into DOM nodes
				} else {
				tmp = tmp || fragment.appendChild( context.createElement( "div" ) );

				// Deserialize a standard representation
				tag = ( rtagName.exec( elem ) || [ "", "" ] )[ 1 ].toLowerCase();
				wrap = wrapMap[ tag ] || wrapMap._default;
				tmp.innerHTML = wrap[ 1 ] + jQuery.htmlPrefilter( elem ) + wrap[ 2 ];

				// Descend through wrappers to the right content
				j = wrap[ 0 ];
				while ( j-- ) {
				tmp = tmp.lastChild;
				}

				// Support: Android <=4.0 only, PhantomJS 1 only
				// push.apply(_, arraylike) throws on ancient WebKit
				jQuery.merge( nodes, tmp.childNodes );

				// Remember the top-level container
				tmp = fragment.firstChild;

				// Ensure the created nodes are orphaned (trac-12392)
				tmp.textContent = "";
				}
				}
				}

				// Remove wrapper from fragment
				fragment.textContent = "";

				i = 0;
				while ( ( elem = nodes[ i++ ] ) ) {

				// Skip elements already in the context collection (trac-4087)
				if ( selection && jQuery.inArray( elem, selection ) > -1 ) {
				if ( ignored ) {
				ignored.push( elem );
				}
				continue;
				}

				attached = isAttached( elem );

				// Append to fragment
				tmp = getAll( fragment.appendChild( elem ), "script" );

				// Preserve script evaluation history
				if ( attached ) {
				setGlobalEval( tmp );
				}

				// Capture executables
				if ( scripts ) {
				j = 0;
				while ( ( elem = tmp[ j++ ] ) ) {
				if ( rscriptType.test( elem.type || "" ) ) {
				scripts.push( elem );
				}
				}
				}
				}

				return fragment;
				}


				var rtypenamespace = /^([^.]*)(?:\.(.+)|)/;

				function returnTrue() {
				return true;
				}

				function returnFalse() {
				return false;
				}

				function on( elem, types, selector, data, fn, one ) {
				var origFn, type;

				// Types can be a map of types/handlers
				if ( typeof types === "object" ) {

				// ( types-Object, selector, data )
				if ( typeof selector !== "string" ) {

				// ( types-Object, data )
				data = data || selector;
				selector = undefined;
				}
				for ( type in types ) {
				on( elem, type, selector, data, types[ type ], one );
				}
				return elem;
				}

				if ( data == null && fn == null ) {

				// ( types, fn )
				fn = selector;
				data = selector = undefined;
				} else if ( fn == null ) {
				if ( typeof selector === "string" ) {

				// ( types, selector, fn )
				fn = data;
				data = undefined;
				} else {

				// ( types, data, fn )
				fn = data;
				data = selector;
				selector = undefined;
				}
				}
				if ( fn === false ) {
				fn = returnFalse;
				} else if ( !fn ) {
				return elem;
				}

				if ( one === 1 ) {
				origFn = fn;
				fn = function( event ) {

				// Can use an empty set, since event contains the info
				jQuery().off( event );
				return origFn.apply( this, arguments );
				};

				// Use same guid so caller can remove using origFn
				fn.guid = origFn.guid || ( origFn.guid = jQuery.guid++ );
				}
				return elem.each( function() {
				jQuery.event.add( this, types, fn, data, selector );
				} );
				}

				/*
				* Helper functions for managing events -- not part of the public interface.
				* Props to Dean Edwards' addEvent library for many of the ideas.
				*/
				jQuery.event = {

				global: {},

				add: function( elem, types, handler, data, selector ) {

				var handleObjIn, eventHandle, tmp,
				events, t, handleObj,
				special, handlers, type, namespaces, origType,
				elemData = dataPriv.get( elem );

				// Only attach events to objects that accept data
				if ( !acceptData( elem ) ) {
				return;
				}

				// Caller can pass in an object of custom data in lieu of the handler
				if ( handler.handler ) {
				handleObjIn = handler;
				handler = handleObjIn.handler;
				selector = handleObjIn.selector;
				}

				// Ensure that invalid selectors throw exceptions at attach time
				// Evaluate against documentElement in case elem is a non-element node (e.g., document)
				if ( selector ) {
				jQuery.find.matchesSelector( documentElement, selector );
				}

				// Make sure that the handler has a unique ID, used to find/remove it later
				if ( !handler.guid ) {
				handler.guid = jQuery.guid++;
				}

				// Init the element's event structure and main handler, if this is the first
				if ( !( events = elemData.events ) ) {
				events = elemData.events = Object.create( null );
				}
				if ( !( eventHandle = elemData.handle ) ) {
				eventHandle = elemData.handle = function( e ) {

				// Discard the second event of a jQuery.event.trigger() and
				// when an event is called after a page has unloaded
				return typeof jQuery !== "undefined" && jQuery.event.triggered !== e.type ?
				jQuery.event.dispatch.apply( elem, arguments ) : undefined;
				};
				}

				// Handle multiple events separated by a space
				types = ( types || "" ).match( rnothtmlwhite ) || [ "" ];
				t = types.length;
				while ( t-- ) {
				tmp = rtypenamespace.exec( types[ t ] ) || [];
				type = origType = tmp[ 1 ];
				namespaces = ( tmp[ 2 ] || "" ).split( "." ).sort();

				// There *must* be a type, no attaching namespace-only handlers
				if ( !type ) {
				continue;
				}

				// If event changes its type, use the special event handlers for the changed type
				special = jQuery.event.special[ type ] || {};

				// If selector defined, determine special event api type, otherwise given type
				type = ( selector ? special.delegateType : special.bindType ) || type;

				// Update special based on newly reset type
				special = jQuery.event.special[ type ] || {};

				// handleObj is passed to all event handlers
				handleObj = jQuery.extend( {
				type: type,
				origType: origType,
				data: data,
				handler: handler,
				guid: handler.guid,
				selector: selector,
				needsContext: selector && jQuery.expr.match.needsContext.test( selector ),
				namespace: namespaces.join( "." )
				}, handleObjIn );

				// Init the event handler queue if we're the first
				if ( !( handlers = events[ type ] ) ) {
				handlers = events[ type ] = [];
				handlers.delegateCount = 0;

				// Only use addEventListener if the special events handler returns false
				if ( !special.setup ||
				special.setup.call( elem, data, namespaces, eventHandle ) === false ) {

				if ( elem.addEventListener ) {
				elem.addEventListener( type, eventHandle );
				}
				}
				}

				if ( special.add ) {
				special.add.call( elem, handleObj );

				if ( !handleObj.handler.guid ) {
				handleObj.handler.guid = handler.guid;
				}
				}

				// Add to the element's handler list, delegates in front
				if ( selector ) {
				handlers.splice( handlers.delegateCount++, 0, handleObj );
				} else {
				handlers.push( handleObj );
				}

				// Keep track of which events have ever been used, for event optimization
				jQuery.event.global[ type ] = true;
				}

				},

				// Detach an event or set of events from an element
				remove: function( elem, types, handler, selector, mappedTypes ) {

				var j, origCount, tmp,
				events, t, handleObj,
				special, handlers, type, namespaces, origType,
				elemData = dataPriv.hasData( elem ) && dataPriv.get( elem );

				if ( !elemData || !( events = elemData.events ) ) {
				return;
				}

				// Once for each type.namespace in types; type may be omitted
				types = ( types || "" ).match( rnothtmlwhite ) || [ "" ];
				t = types.length;
				while ( t-- ) {
				tmp = rtypenamespace.exec( types[ t ] ) || [];
				type = origType = tmp[ 1 ];
				namespaces = ( tmp[ 2 ] || "" ).split( "." ).sort();

				// Unbind all events (on this namespace, if provided) for the element
				if ( !type ) {
				for ( type in events ) {
				jQuery.event.remove( elem, type + types[ t ], handler, selector, true );
				}
				continue;
				}

				special = jQuery.event.special[ type ] || {};
				type = ( selector ? special.delegateType : special.bindType ) || type;
				handlers = events[ type ] || [];
				tmp = tmp[ 2 ] &&
				new RegExp( "(^|\\.)" + namespaces.join( "\\.(?:.*\\.|)" ) + "(\\.|$)" );

				// Remove matching events
				origCount = j = handlers.length;
				while ( j-- ) {
				handleObj = handlers[ j ];

				if ( ( mappedTypes || origType === handleObj.origType ) &&
				( !handler || handler.guid === handleObj.guid ) &&
				( !tmp || tmp.test( handleObj.namespace ) ) &&
				( !selector || selector === handleObj.selector ||
				selector === "**" && handleObj.selector ) ) {
				handlers.splice( j, 1 );

				if ( handleObj.selector ) {
				handlers.delegateCount--;
				}
				if ( special.remove ) {
				special.remove.call( elem, handleObj );
				}
				}
				}

				// Remove generic event handler if we removed something and no more handlers exist
				// (avoids potential for endless recursion during removal of special event handlers)
				if ( origCount && !handlers.length ) {
				if ( !special.teardown ||
				special.teardown.call( elem, namespaces, elemData.handle ) === false ) {

				jQuery.removeEvent( elem, type, elemData.handle );
				}

				delete events[ type ];
				}
				}

				// Remove data and the expando if it's no longer used
				if ( jQuery.isEmptyObject( events ) ) {
				dataPriv.remove( elem, "handle events" );
				}
				},

				dispatch: function( nativeEvent ) {

				var i, j, ret, matched, handleObj, handlerQueue,
				args = new Array( arguments.length ),

				// Make a writable jQuery.Event from the native event object
				event = jQuery.event.fix( nativeEvent ),

				handlers = (
				dataPriv.get( this, "events" ) || Object.create( null )
				)[ event.type ] || [],
				special = jQuery.event.special[ event.type ] || {};

				// Use the fix-ed jQuery.Event rather than the (read-only) native event
				args[ 0 ] = event;

				for ( i = 1; i < arguments.length; i++ ) {
				args[ i ] = arguments[ i ];
				}

				event.delegateTarget = this;

				// Call the preDispatch hook for the mapped type, and let it bail if desired
				if ( special.preDispatch && special.preDispatch.call( this, event ) === false ) {
				return;
				}

				// Determine handlers
				handlerQueue = jQuery.event.handlers.call( this, event, handlers );

				// Run delegates first; they may want to stop propagation beneath us
				i = 0;
				while ( ( matched = handlerQueue[ i++ ] ) && !event.isPropagationStopped() ) {
				event.currentTarget = matched.elem;

				j = 0;
				while ( ( handleObj = matched.handlers[ j++ ] ) &&
				!event.isImmediatePropagationStopped() ) {

				// If the event is namespaced, then each handler is only invoked if it is
				// specially universal or its namespaces are a superset of the event's.
				if ( !event.rnamespace || handleObj.namespace === false ||
				event.rnamespace.test( handleObj.namespace ) ) {

				event.handleObj = handleObj;
				event.data = handleObj.data;

				ret = ( ( jQuery.event.special[ handleObj.origType ] || {} ).handle ||
				handleObj.handler ).apply( matched.elem, args );

				if ( ret !== undefined ) {
				if ( ( event.result = ret ) === false ) {
				event.preventDefault();
				event.stopPropagation();
				}
				}
				}
				}
				}

				// Call the postDispatch hook for the mapped type
				if ( special.postDispatch ) {
				special.postDispatch.call( this, event );
				}

				return event.result;
				},

				handlers: function( event, handlers ) {
				var i, handleObj, sel, matchedHandlers, matchedSelectors,
				handlerQueue = [],
				delegateCount = handlers.delegateCount,
				cur = event.target;

				// Find delegate handlers
				if ( delegateCount &&

				// Support: IE <=9
				// Black-hole SVG
				<use> instance trees (trac-13180)
					cur.nodeType &&

					// Support: Firefox <=42
					// Suppress spec-violating clicks indicating a non-primary pointer button (trac-3861)
					// https://www.w3.org/TR/DOM-Level-3-Events/#event-type-click
					// Support: IE 11 only
					// ...but not arrow key "clicks" of radio inputs, which can have `button` -1 (gh-2343)
					!( event.type === "click" && event.button >= 1 ) ) {

					for ( ; cur !== this; cur = cur.parentNode || this ) {

					// Don't check non-elements (trac-13208)
					// Don't process clicks on disabled elements (trac-6911, trac-8165, trac-11382, trac-11764)
					if ( cur.nodeType === 1 && !( event.type === "click" && cur.disabled === true ) ) {
					matchedHandlers = [];
					matchedSelectors = {};
					for ( i = 0; i < delegateCount; i++ ) {
					handleObj = handlers[ i ];

					// Don't conflict with Object.prototype properties (trac-13203)
					sel = handleObj.selector + " ";

					if ( matchedSelectors[ sel ] === undefined ) {
					matchedSelectors[ sel ] = handleObj.needsContext ?
					jQuery( sel, this ).index( cur ) > -1 :
					jQuery.find( sel, this, null, [ cur ] ).length;
					}
					if ( matchedSelectors[ sel ] ) {
					matchedHandlers.push( handleObj );
					}
					}
					if ( matchedHandlers.length ) {
					handlerQueue.push( { elem: cur, handlers: matchedHandlers } );
					}
					}
					}
					}

					// Add the remaining (directly-bound) handlers
					cur = this;
					if ( delegateCount < handlers.length ) {
					handlerQueue.push( { elem: cur, handlers: handlers.slice( delegateCount ) } );
					}

					return handlerQueue;
					},

					addProp: function( name, hook ) {
					Object.defineProperty( jQuery.Event.prototype, name, {
					enumerable: true,
					configurable: true,

					get: isFunction( hook ) ?
					function() {
					if ( this.originalEvent ) {
					return hook( this.originalEvent );
					}
					} :
					function() {
					if ( this.originalEvent ) {
					return this.originalEvent[ name ];
					}
					},

					set: function( value ) {
					Object.defineProperty( this, name, {
					enumerable: true,
					configurable: true,
					writable: true,
					value: value
					} );
					}
					} );
					},

					fix: function( originalEvent ) {
					return originalEvent[ jQuery.expando ] ?
					originalEvent :
					new jQuery.Event( originalEvent );
					},

					special: {
					load: {

					// Prevent triggered image.load events from bubbling to window.load
					noBubble: true
					},
					click: {

					// Utilize native event to ensure correct state for checkable inputs
					setup: function( data ) {

					// For mutual compressibility with _default, replace `this` access with a local var.
					// `|| data` is dead code meant only to preserve the variable through minification.
					var el = this || data;

					// Claim the first handler
					if ( rcheckableType.test( el.type ) &&
					el.click && nodeName( el, "input" ) ) {

					// dataPriv.set( el, "click", ... )
					leverageNative( el, "click", true );
					}

					// Return false to allow normal processing in the caller
					return false;
					},
					trigger: function( data ) {

					// For mutual compressibility with _default, replace `this` access with a local var.
					// `|| data` is dead code meant only to preserve the variable through minification.
					var el = this || data;

					// Force setup before triggering a click
					if ( rcheckableType.test( el.type ) &&
					el.click && nodeName( el, "input" ) ) {

					leverageNative( el, "click" );
					}

					// Return non-false to allow normal event-path propagation
					return true;
					},

					// For cross-browser consistency, suppress native .click() on links
					// Also prevent it if we're currently inside a leveraged native-event stack
					_default: function( event ) {
					var target = event.target;
					return rcheckableType.test( target.type ) &&
					target.click && nodeName( target, "input" ) &&
					dataPriv.get( target, "click" ) ||
					nodeName( target, "a" );
					}
					},

					beforeunload: {
					postDispatch: function( event ) {

					// Support: Firefox 20+
					// Firefox doesn't alert if the returnValue field is not set.
					if ( event.result !== undefined && event.originalEvent ) {
					event.originalEvent.returnValue = event.result;
					}
					}
					}
					}
					};

					// Ensure the presence of an event listener that handles manually-triggered
					// synthetic events by interrupting progress until reinvoked in response to
					// *native* events that it fires directly, ensuring that state changes have
					// already occurred before other listeners are invoked.
					function leverageNative( el, type, isSetup ) {

					// Missing `isSetup` indicates a trigger call, which must force setup through jQuery.event.add
					if ( !isSetup ) {
					if ( dataPriv.get( el, type ) === undefined ) {
					jQuery.event.add( el, type, returnTrue );
					}
					return;
					}

					// Register the controller as a special universal handler for all event namespaces
					dataPriv.set( el, type, false );
					jQuery.event.add( el, type, {
					namespace: false,
					handler: function( event ) {
					var result,
					saved = dataPriv.get( this, type );

					if ( ( event.isTrigger & 1 ) && this[ type ] ) {

					// Interrupt processing of the outer synthetic .trigger()ed event
					if ( !saved ) {

					// Store arguments for use when handling the inner native event
					// There will always be at least one argument (an event object), so this array
					// will not be confused with a leftover capture object.
					saved = slice.call( arguments );
					dataPriv.set( this, type, saved );

					// Trigger the native event and capture its result
					this[ type ]();
					result = dataPriv.get( this, type );
					dataPriv.set( this, type, false );

					if ( saved !== result ) {

					// Cancel the outer synthetic event
					event.stopImmediatePropagation();
					event.preventDefault();

					return result;
					}

					// If this is an inner synthetic event for an event with a bubbling surrogate
					// (focus or blur), assume that the surrogate already propagated from triggering
					// the native event and prevent that from happening again here.
					// This technically gets the ordering wrong w.r.t. to `.trigger()` (in which the
					// bubbling surrogate propagates *after* the non-bubbling base), but that seems
					// less bad than duplication.
					} else if ( ( jQuery.event.special[ type ] || {} ).delegateType ) {
					event.stopPropagation();
					}

					// If this is a native event triggered above, everything is now in order
					// Fire an inner synthetic event with the original arguments
					} else if ( saved ) {

					// ...and capture the result
					dataPriv.set( this, type, jQuery.event.trigger(
					saved[ 0 ],
					saved.slice( 1 ),
					this
					) );

					// Abort handling of the native event by all jQuery handlers while allowing
					// native handlers on the same element to run. On target, this is achieved
					// by stopping immediate propagation just on the jQuery event. However,
					// the native event is re-wrapped by a jQuery one on each level of the
					// propagation so the only way to stop it for jQuery is to stop it for
					// everyone via native `stopPropagation()`. This is not a problem for
					// focus/blur which don't bubble, but it does also stop click on checkboxes
					// and radios. We accept this limitation.
					event.stopPropagation();
					event.isImmediatePropagationStopped = returnTrue;
					}
					}
					} );
					}

					jQuery.removeEvent = function( elem, type, handle ) {

					// This "if" is needed for plain objects
					if ( elem.removeEventListener ) {
					elem.removeEventListener( type, handle );
					}
					};

					jQuery.Event = function( src, props ) {

					// Allow instantiation without the 'new' keyword
					if ( !( this instanceof jQuery.Event ) ) {
					return new jQuery.Event( src, props );
					}

					// Event object
					if ( src && src.type ) {
					this.originalEvent = src;
					this.type = src.type;

					// Events bubbling up the document may have been marked as prevented
					// by a handler lower down the tree; reflect the correct value.
					this.isDefaultPrevented = src.defaultPrevented ||
					src.defaultPrevented === undefined &&

					// Support: Android <=2.3 only
					src.returnValue === false ?
					returnTrue :
					returnFalse;

					// Create target properties
					// Support: Safari <=6 - 7 only
					// Target should not be a text node (trac-504, trac-13143)
					this.target = ( src.target && src.target.nodeType === 3 ) ?
					src.target.parentNode :
					src.target;

					this.currentTarget = src.currentTarget;
					this.relatedTarget = src.relatedTarget;

					// Event type
					} else {
					this.type = src;
					}

					// Put explicitly provided properties onto the event object
					if ( props ) {
					jQuery.extend( this, props );
					}

					// Create a timestamp if incoming event doesn't have one
					this.timeStamp = src && src.timeStamp || Date.now();

					// Mark it as fixed
					this[ jQuery.expando ] = true;
					};

					// jQuery.Event is based on DOM3 Events as specified by the ECMAScript Language Binding
					// https://www.w3.org/TR/2003/WD-DOM-Level-3-Events-20030331/ecma-script-binding.html
					jQuery.Event.prototype = {
					constructor: jQuery.Event,
					isDefaultPrevented: returnFalse,
					isPropagationStopped: returnFalse,
					isImmediatePropagationStopped: returnFalse,
					isSimulated: false,

					preventDefault: function() {
					var e = this.originalEvent;

					this.isDefaultPrevented = returnTrue;

					if ( e && !this.isSimulated ) {
					e.preventDefault();
					}
					},
					stopPropagation: function() {
					var e = this.originalEvent;

					this.isPropagationStopped = returnTrue;

					if ( e && !this.isSimulated ) {
					e.stopPropagation();
					}
					},
					stopImmediatePropagation: function() {
					var e = this.originalEvent;

					this.isImmediatePropagationStopped = returnTrue;

					if ( e && !this.isSimulated ) {
					e.stopImmediatePropagation();
					}

					this.stopPropagation();
					}
					};

					// Includes all common event props including KeyEvent and MouseEvent specific props
					jQuery.each( {
					altKey: true,
					bubbles: true,
					cancelable: true,
					changedTouches: true,
					ctrlKey: true,
					detail: true,
					eventPhase: true,
					metaKey: true,
					pageX: true,
					pageY: true,
					shiftKey: true,
					view: true,
					"char": true,
					code: true,
					charCode: true,
					key: true,
					keyCode: true,
					button: true,
					buttons: true,
					clientX: true,
					clientY: true,
					offsetX: true,
					offsetY: true,
					pointerId: true,
					pointerType: true,
					screenX: true,
					screenY: true,
					targetTouches: true,
					toElement: true,
					touches: true,
					which: true
					}, jQuery.event.addProp );

					jQuery.each( { focus: "focusin", blur: "focusout" }, function( type, delegateType ) {

					function focusMappedHandler( nativeEvent ) {
					if ( document.documentMode ) {

					// Support: IE 11+
					// Attach a single focusin/focusout handler on the document while someone wants
					// focus/blur. This is because the former are synchronous in IE while the latter
					// are async. In other browsers, all those handlers are invoked synchronously.

					// `handle` from private data would already wrap the event, but we need
					// to change the `type` here.
					var handle = dataPriv.get( this, "handle" ),
					event = jQuery.event.fix( nativeEvent );
					event.type = nativeEvent.type === "focusin" ? "focus" : "blur";
					event.isSimulated = true;

					// First, handle focusin/focusout
					handle( nativeEvent );

					// ...then, handle focus/blur
					//
					// focus/blur don't bubble while focusin/focusout do; simulate the former by only
					// invoking the handler at the lower level.
					if ( event.target === event.currentTarget ) {

					// The setup part calls `leverageNative`, which, in turn, calls
					// `jQuery.event.add`, so event handle will already have been set
					// by this point.
					handle( event );
					}
					} else {

					// For non-IE browsers, attach a single capturing handler on the document
					// while someone wants focusin/focusout.
					jQuery.event.simulate( delegateType, nativeEvent.target,
					jQuery.event.fix( nativeEvent ) );
					}
					}

					jQuery.event.special[ type ] = {

					// Utilize native event if possible so blur/focus sequence is correct
					setup: function() {

					var attaches;

					// Claim the first handler
					// dataPriv.set( this, "focus", ... )
					// dataPriv.set( this, "blur", ... )
					leverageNative( this, type, true );

					if ( document.documentMode ) {

					// Support: IE 9 - 11+
					// We use the same native handler for focusin & focus (and focusout & blur)
					// so we need to coordinate setup & teardown parts between those events.
					// Use `delegateType` as the key as `type` is already used by `leverageNative`.
					attaches = dataPriv.get( this, delegateType );
					if ( !attaches ) {
					this.addEventListener( delegateType, focusMappedHandler );
					}
					dataPriv.set( this, delegateType, ( attaches || 0 ) + 1 );
					} else {

					// Return false to allow normal processing in the caller
					return false;
					}
					},
					trigger: function() {

					// Force setup before trigger
					leverageNative( this, type );

					// Return non-false to allow normal event-path propagation
					return true;
					},

					teardown: function() {
					var attaches;

					if ( document.documentMode ) {
					attaches = dataPriv.get( this, delegateType ) - 1;
					if ( !attaches ) {
					this.removeEventListener( delegateType, focusMappedHandler );
					dataPriv.remove( this, delegateType );
					} else {
					dataPriv.set( this, delegateType, attaches );
					}
					} else {

					// Return false to indicate standard teardown should be applied
					return false;
					}
					},

					// Suppress native focus or blur if we're currently inside
					// a leveraged native-event stack
					_default: function( event ) {
					return dataPriv.get( event.target, type );
					},

					delegateType: delegateType
					};

					// Support: Firefox <=44
					// Firefox doesn't have focus(in | out) events
					// Related ticket - https://bugzilla.mozilla.org/show_bug.cgi?id=687787
					//
					// Support: Chrome <=48 - 49, Safari <=9.0 - 9.1
					// focus(in | out) events fire after focus & blur events,
					// which is spec violation - http://www.w3.org/TR/DOM-Level-3-Events/#events-focusevent-event-order
					// Related ticket - https://bugs.chromium.org/p/chromium/issues/detail?id=449857
					//
					// Support: IE 9 - 11+
					// To preserve relative focusin/focus & focusout/blur event order guaranteed on the 3.x branch,
					// attach a single handler for both events in IE.
					jQuery.event.special[ delegateType ] = {
					setup: function() {

					// Handle: regular nodes (via `this.ownerDocument`), window
					// (via `this.document`) & document (via `this`).
					var doc = this.ownerDocument || this.document || this,
					dataHolder = document.documentMode ? this : doc,
					attaches = dataPriv.get( dataHolder, delegateType );

					// Support: IE 9 - 11+
					// We use the same native handler for focusin & focus (and focusout & blur)
					// so we need to coordinate setup & teardown parts between those events.
					// Use `delegateType` as the key as `type` is already used by `leverageNative`.
					if ( !attaches ) {
					if ( document.documentMode ) {
					this.addEventListener( delegateType, focusMappedHandler );
					} else {
					doc.addEventListener( type, focusMappedHandler, true );
					}
					}
					dataPriv.set( dataHolder, delegateType, ( attaches || 0 ) + 1 );
					},
					teardown: function() {
					var doc = this.ownerDocument || this.document || this,
					dataHolder = document.documentMode ? this : doc,
					attaches = dataPriv.get( dataHolder, delegateType ) - 1;

					if ( !attaches ) {
					if ( document.documentMode ) {
					this.removeEventListener( delegateType, focusMappedHandler );
					} else {
					doc.removeEventListener( type, focusMappedHandler, true );
					}
					dataPriv.remove( dataHolder, delegateType );
					} else {
					dataPriv.set( dataHolder, delegateType, attaches );
					}
					}
					};
					} );

					// Create mouseenter/leave events using mouseover/out and event-time checks
					// so that event delegation works in jQuery.
					// Do the same for pointerenter/pointerleave and pointerover/pointerout
					//
					// Support: Safari 7 only
					// Safari sends mouseenter too often; see:
					// https://bugs.chromium.org/p/chromium/issues/detail?id=470258
					// for the description of the bug (it existed in older Chrome versions as well).
					jQuery.each( {
					mouseenter: "mouseover",
					mouseleave: "mouseout",
					pointerenter: "pointerover",
					pointerleave: "pointerout"
					}, function( orig, fix ) {
					jQuery.event.special[ orig ] = {
					delegateType: fix,
					bindType: fix,

					handle: function( event ) {
					var ret,
					target = this,
					related = event.relatedTarget,
					handleObj = event.handleObj;

					// For mouseenter/leave call the handler if related is outside the target.
					// NB: No relatedTarget if the mouse left/entered the browser window
					if ( !related || ( related !== target && !jQuery.contains( target, related ) ) ) {
					event.type = handleObj.origType;
					ret = handleObj.handler.apply( this, arguments );
					event.type = fix;
					}
					return ret;
					}
					};
					} );

					jQuery.fn.extend( {

					on: function( types, selector, data, fn ) {
					return on( this, types, selector, data, fn );
					},
					one: function( types, selector, data, fn ) {
					return on( this, types, selector, data, fn, 1 );
					},
					off: function( types, selector, fn ) {
					var handleObj, type;
					if ( types && types.preventDefault && types.handleObj ) {

					// ( event ) dispatched jQuery.Event
					handleObj = types.handleObj;
					jQuery( types.delegateTarget ).off(
					handleObj.namespace ?
					handleObj.origType + "." + handleObj.namespace :
					handleObj.origType,
					handleObj.selector,
					handleObj.handler
					);
					return this;
					}
					if ( typeof types === "object" ) {

					// ( types-object [, selector] )
					for ( type in types ) {
					this.off( type, selector, types[ type ] );
					}
					return this;
					}
					if ( selector === false || typeof selector === "function" ) {

					// ( types [, fn] )
					fn = selector;
					selector = undefined;
					}
					if ( fn === false ) {
					fn = returnFalse;
					}
					return this.each( function() {
					jQuery.event.remove( this, types, fn, selector );
					} );
					}
					} );


					var

					// Support: IE <=10 - 11, Edge 12 - 13 only
					// In IE/Edge using regex groups here causes severe slowdowns.
					// See https://connect.microsoft.com/IE/feedback/details/1736512/
					rnoInnerhtml = /
					<script
					|
					<style
					|
					<link
					/i,

					// checked="checked" or checked
					rchecked = /checked\s*(?:[^=]|=\s*.checked.)/i,

					rcleanScript = /^\s*<!\[CDATA\[|\]\]>\s*$/g;

					// Prefer a tbody over its parent table for containing new rows
					function manipulationTarget( elem, content ) {
					if ( nodeName( elem, "table" ) &&
					nodeName( content.nodeType !== 11 ? content : content.firstChild, "tr" ) ) {

					return jQuery( elem ).children( "tbody" )[ 0 ] || elem;
					}

					return elem;
					}

					// Replace/restore the type attribute of script elements for safe DOM manipulation
					function disableScript( elem ) {
					elem.type = ( elem.getAttribute( "type" ) !== null ) + "/" + elem.type;
					return elem;
					}
					function restoreScript( elem ) {
					if ( ( elem.type || "" ).slice( 0, 5 ) === "true/" ) {
					elem.type = elem.type.slice( 5 );
					} else {
					elem.removeAttribute( "type" );
					}

					return elem;
					}

					function cloneCopyEvent( src, dest ) {
					var i, l, type, pdataOld, udataOld, udataCur, events;

					if ( dest.nodeType !== 1 ) {
					return;
					}

					// 1. Copy private data: events, handlers, etc.
					if ( dataPriv.hasData( src ) ) {
					pdataOld = dataPriv.get( src );
					events = pdataOld.events;

					if ( events ) {
					dataPriv.remove( dest, "handle events" );

					for ( type in events ) {
					for ( i = 0, l = events[ type ].length; i < l; i++ ) {
					jQuery.event.add( dest, type, events[ type ][ i ] );
					}
					}
					}
					}

					// 2. Copy user data
					if ( dataUser.hasData( src ) ) {
					udataOld = dataUser.access( src );
					udataCur = jQuery.extend( {}, udataOld );

					dataUser.set( dest, udataCur );
					}
					}

					// Fix IE bugs, see support tests
					function fixInput( src, dest ) {
					var nodeName = dest.nodeName.toLowerCase();

					// Fails to persist the checked state of a cloned checkbox or radio button.
					if ( nodeName === "input" && rcheckableType.test( src.type ) ) {
					dest.checked = src.checked;

					// Fails to return the selected option to the default selected state when cloning options
					} else if ( nodeName === "input" || nodeName === "textarea" ) {
					dest.defaultValue = src.defaultValue;
					}
					}

					function domManip( collection, args, callback, ignored ) {

					// Flatten any nested arrays
					args = flat( args );

					var fragment, first, scripts, hasScripts, node, doc,
					i = 0,
					l = collection.length,
					iNoClone = l - 1,
					value = args[ 0 ],
					valueIsFunction = isFunction( value );

					// We can't cloneNode fragments that contain checked, in WebKit
					if ( valueIsFunction ||
					( l > 1 && typeof value === "string" &&
					!support.checkClone && rchecked.test( value ) ) ) {
					return collection.each( function( index ) {
					var self = collection.eq( index );
					if ( valueIsFunction ) {
					args[ 0 ] = value.call( this, index, self.html() );
					}
					domManip( self, args, callback, ignored );
					} );
					}

					if ( l ) {
					fragment = buildFragment( args, collection[ 0 ].ownerDocument, false, collection, ignored );
					first = fragment.firstChild;

					if ( fragment.childNodes.length === 1 ) {
					fragment = first;
					}

					// Require either new content or an interest in ignored elements to invoke the callback
					if ( first || ignored ) {
					scripts = jQuery.map( getAll( fragment, "script" ), disableScript );
					hasScripts = scripts.length;

					// Use the original fragment for the last item
					// instead of the first because it can end up
					// being emptied incorrectly in certain situations (trac-8070).
					for ( ; i < l; i++ ) {
					node = fragment;

					if ( i !== iNoClone ) {
					node = jQuery.clone( node, true, true );

					// Keep references to cloned scripts for later restoration
					if ( hasScripts ) {

					// Support: Android <=4.0 only, PhantomJS 1 only
					// push.apply(_, arraylike) throws on ancient WebKit
					jQuery.merge( scripts, getAll( node, "script" ) );
					}
					}

					callback.call( collection[ i ], node, i );
					}

					if ( hasScripts ) {
					doc = scripts[ scripts.length - 1 ].ownerDocument;

					// Reenable scripts
					jQuery.map( scripts, restoreScript );

					// Evaluate executable scripts on first document insertion
					for ( i = 0; i < hasScripts; i++ ) {
					node = scripts[ i ];
					if ( rscriptType.test( node.type || "" ) &&
					!dataPriv.access( node, "globalEval" ) &&
					jQuery.contains( doc, node ) ) {

					if ( node.src && ( node.type || "" ).toLowerCase() !== "module" ) {

					// Optional AJAX dependency, but won't run scripts if not present
					if ( jQuery._evalUrl && !node.noModule ) {
					jQuery._evalUrl( node.src, {
					nonce: node.nonce || node.getAttribute( "nonce" )
					}, doc );
					}
					} else {

					// Unwrap a CDATA section containing script contents. This shouldn't be
					// needed as in XML documents they're already not visible when
					// inspecting element contents and in HTML documents they have no
					// meaning but we're preserving that logic for backwards compatibility.
					// This will be removed completely in 4.0. See gh-4904.
					DOMEval( node.textContent.replace( rcleanScript, "" ), node, doc );
					}
					}
					}
					}
					}
					}

					return collection;
					}

					function remove( elem, selector, keepData ) {
					var node,
					nodes = selector ? jQuery.filter( selector, elem ) : elem,
					i = 0;

					for ( ; ( node = nodes[ i ] ) != null; i++ ) {
					if ( !keepData && node.nodeType === 1 ) {
					jQuery.cleanData( getAll( node ) );
					}

					if ( node.parentNode ) {
					if ( keepData && isAttached( node ) ) {
					setGlobalEval( getAll( node, "script" ) );
					}
					node.parentNode.removeChild( node );
					}
					}

					return elem;
					}

					jQuery.extend( {
					htmlPrefilter: function( html ) {
					return html;
					},

					clone: function( elem, dataAndEvents, deepDataAndEvents ) {
					var i, l, srcElements, destElements,
					clone = elem.cloneNode( true ),
					inPage = isAttached( elem );

					// Fix IE cloning issues
					if ( !support.noCloneChecked && ( elem.nodeType === 1 || elem.nodeType === 11 ) &&
					!jQuery.isXMLDoc( elem ) ) {

					// We eschew jQuery#find here for performance reasons:
					// https://jsperf.com/getall-vs-sizzle/2
					destElements = getAll( clone );
					srcElements = getAll( elem );

					for ( i = 0, l = srcElements.length; i < l; i++ ) {
					fixInput( srcElements[ i ], destElements[ i ] );
					}
					}

					// Copy the events from the original to the clone
					if ( dataAndEvents ) {
					if ( deepDataAndEvents ) {
					srcElements = srcElements || getAll( elem );
					destElements = destElements || getAll( clone );

					for ( i = 0, l = srcElements.length; i < l; i++ ) {
					cloneCopyEvent( srcElements[ i ], destElements[ i ] );
					}
					} else {
					cloneCopyEvent( elem, clone );
					}
					}

					// Preserve script evaluation history
					destElements = getAll( clone, "script" );
					if ( destElements.length > 0 ) {
					setGlobalEval( destElements, !inPage && getAll( elem, "script" ) );
					}

					// Return the cloned set
					return clone;
					},

					cleanData: function( elems ) {
					var data, elem, type,
					special = jQuery.event.special,
					i = 0;

					for ( ; ( elem = elems[ i ] ) !== undefined; i++ ) {
					if ( acceptData( elem ) ) {
					if ( ( data = elem[ dataPriv.expando ] ) ) {
					if ( data.events ) {
					for ( type in data.events ) {
					if ( special[ type ] ) {
					jQuery.event.remove( elem, type );

					// This is a shortcut to avoid jQuery.event.remove's overhead
					} else {
					jQuery.removeEvent( elem, type, data.handle );
					}
					}
					}

					// Support: Chrome <=35 - 45+
					// Assign undefined instead of using delete, see Data#remove
					elem[ dataPriv.expando ] = undefined;
					}
					if ( elem[ dataUser.expando ] ) {

					// Support: Chrome <=35 - 45+
					// Assign undefined instead of using delete, see Data#remove
					elem[ dataUser.expando ] = undefined;
					}
					}
					}
					}
					} );

					jQuery.fn.extend( {
					detach: function( selector ) {
					return remove( this, selector, true );
					},

					remove: function( selector ) {
					return remove( this, selector );
					},

					text: function( value ) {
					return access( this, function( value ) {
					return value === undefined ?
					jQuery.text( this ) :
					this.empty().each( function() {
					if ( this.nodeType === 1 || this.nodeType === 11 || this.nodeType === 9 ) {
					this.textContent = value;
					}
					} );
					}, null, value, arguments.length );
					},

					append: function() {
					return domManip( this, arguments, function( elem ) {
					if ( this.nodeType === 1 || this.nodeType === 11 || this.nodeType === 9 ) {
					var target = manipulationTarget( this, elem );
					target.appendChild( elem );
					}
					} );
					},

					prepend: function() {
					return domManip( this, arguments, function( elem ) {
					if ( this.nodeType === 1 || this.nodeType === 11 || this.nodeType === 9 ) {
					var target = manipulationTarget( this, elem );
					target.insertBefore( elem, target.firstChild );
					}
					} );
					},

					before: function() {
					return domManip( this, arguments, function( elem ) {
					if ( this.parentNode ) {
					this.parentNode.insertBefore( elem, this );
					}
					} );
					},

					after: function() {
					return domManip( this, arguments, function( elem ) {
					if ( this.parentNode ) {
					this.parentNode.insertBefore( elem, this.nextSibling );
					}
					} );
					},

					empty: function() {
					var elem,
					i = 0;

					for ( ; ( elem = this[ i ] ) != null; i++ ) {
					if ( elem.nodeType === 1 ) {

					// Prevent memory leaks
					jQuery.cleanData( getAll( elem, false ) );

					// Remove any remaining nodes
					elem.textContent = "";
					}
					}

					return this;
					},

					clone: function( dataAndEvents, deepDataAndEvents ) {
					dataAndEvents = dataAndEvents == null ? false : dataAndEvents;
					deepDataAndEvents = deepDataAndEvents == null ? dataAndEvents : deepDataAndEvents;

					return this.map( function() {
					return jQuery.clone( this, dataAndEvents, deepDataAndEvents );
					} );
					},

					html: function( value ) {
					return access( this, function( value ) {
					var elem = this[ 0 ] || {},
					i = 0,
					l = this.length;

					if ( value === undefined && elem.nodeType === 1 ) {
					return elem.innerHTML;
					}

					// See if we can take a shortcut and just use innerHTML
					if ( typeof value === "string" && !rnoInnerhtml.test( value ) &&
					!wrapMap[ ( rtagName.exec( value ) || [ "", "" ] )[ 1 ].toLowerCase() ] ) {

					value = jQuery.htmlPrefilter( value );

					try {
					for ( ; i < l; i++ ) {
					elem = this[ i ] || {};

					// Remove element nodes and prevent memory leaks
					if ( elem.nodeType === 1 ) {
					jQuery.cleanData( getAll( elem, false ) );
					elem.innerHTML = value;
					}
					}

					elem = 0;

					// If using innerHTML throws an exception, use the fallback method
					} catch ( e ) {}
					}

					if ( elem ) {
					this.empty().append( value );
					}
					}, null, value, arguments.length );
					},

					replaceWith: function() {
					var ignored = [];

					// Make the changes, replacing each non-ignored context element with the new content
					return domManip( this, arguments, function( elem ) {
					var parent = this.parentNode;

					if ( jQuery.inArray( this, ignored ) < 0 ) {
					jQuery.cleanData( getAll( this ) );
					if ( parent ) {
					parent.replaceChild( elem, this );
					}
					}

					// Force callback invocation
					}, ignored );
					}
					} );

					jQuery.each( {
					appendTo: "append",
					prependTo: "prepend",
					insertBefore: "before",
					insertAfter: "after",
					replaceAll: "replaceWith"
					}, function( name, original ) {
					jQuery.fn[ name ] = function( selector ) {
					var elems,
					ret = [],
					insert = jQuery( selector ),
					last = insert.length - 1,
					i = 0;

					for ( ; i <= last; i++ ) {
					elems = i === last ? this : this.clone( true );
					jQuery( insert[ i ] )[ original ]( elems );

					// Support: Android <=4.0 only, PhantomJS 1 only
					// .get() because push.apply(_, arraylike) throws on ancient WebKit
					push.apply( ret, elems.get() );
					}

					return this.pushStack( ret );
					};
					} );
					var rnumnonpx = new RegExp( "^(" + pnum + ")(?!px)[a-z%]+$", "i" );

					var rcustomProp = /^--/;


					var getStyles = function( elem ) {

					// Support: IE <=11 only, Firefox <=30 (trac-15098, trac-14150)
					// IE throws on elements created in popups
					// FF meanwhile throws on frame elements through "defaultView.getComputedStyle"
					var view = elem.ownerDocument.defaultView;

					if ( !view || !view.opener ) {
					view = window;
					}

					return view.getComputedStyle( elem );
					};

					var swap = function( elem, options, callback ) {
					var ret, name,
					old = {};

					// Remember the old values, and insert the new ones
					for ( name in options ) {
					old[ name ] = elem.style[ name ];
					elem.style[ name ] = options[ name ];
					}

					ret = callback.call( elem );

					// Revert the old values
					for ( name in options ) {
					elem.style[ name ] = old[ name ];
					}

					return ret;
					};


					var rboxStyle = new RegExp( cssExpand.join( "|" ), "i" );


					( function() {

					// Executing both pixelPosition & boxSizingReliable tests require only one layout
					// so they're executed at the same time to save the second computation.
					function computeStyleTests() {

					// This is a singleton, we need to execute it only once
					if ( !div ) {
					return;
					}

					container.style.cssText = "position:absolute;left:-11111px;width:60px;" +
					"margin-top:1px;padding:0;border:0";
					div.style.cssText =
					"position:relative;display:block;box-sizing:border-box;overflow:scroll;" +
					"margin:auto;border:1px;padding:1px;" +
					"width:60%;top:1%";
					documentElement.appendChild( container ).appendChild( div );

					var divStyle = window.getComputedStyle( div );
					pixelPositionVal = divStyle.top !== "1%";

					// Support: Android 4.0 - 4.3 only, Firefox <=3 - 44
					reliableMarginLeftVal = roundPixelMeasures( divStyle.marginLeft ) === 12;

					// Support: Android 4.0 - 4.3 only, Safari <=9.1 - 10.1, iOS <=7.0 - 9.3
					// Some styles come back with percentage values, even though they shouldn't
					div.style.right = "60%";
					pixelBoxStylesVal = roundPixelMeasures( divStyle.right ) === 36;

					// Support: IE 9 - 11 only
					// Detect misreporting of content dimensions for box-sizing:border-box elements
					boxSizingReliableVal = roundPixelMeasures( divStyle.width ) === 36;

					// Support: IE 9 only
					// Detect overflow:scroll screwiness (gh-3699)
					// Support: Chrome <=64
					// Don't get tricked when zoom affects offsetWidth (gh-4029)
					div.style.position = "absolute";
					scrollboxSizeVal = roundPixelMeasures( div.offsetWidth / 3 ) === 12;

					documentElement.removeChild( container );

					// Nullify the div so it wouldn't be stored in the memory and
					// it will also be a sign that checks already performed
					div = null;
					}

					function roundPixelMeasures( measure ) {
					return Math.round( parseFloat( measure ) );
					}

					var pixelPositionVal, boxSizingReliableVal, scrollboxSizeVal, pixelBoxStylesVal,
					reliableTrDimensionsVal, reliableMarginLeftVal,
					container = document.createElement( "div" ),
					div = document.createElement( "div" );

					// Finish early in limited (non-browser) environments
					if ( !div.style ) {
					return;
					}

					// Support: IE <=9 - 11 only
					// Style of cloned element affects source element cloned (trac-8908)
					div.style.backgroundClip = "content-box";
					div.cloneNode( true ).style.backgroundClip = "";
					support.clearCloneStyle = div.style.backgroundClip === "content-box";

					jQuery.extend( support, {
					boxSizingReliable: function() {
					computeStyleTests();
					return boxSizingReliableVal;
					},
					pixelBoxStyles: function() {
					computeStyleTests();
					return pixelBoxStylesVal;
					},
					pixelPosition: function() {
					computeStyleTests();
					return pixelPositionVal;
					},
					reliableMarginLeft: function() {
					computeStyleTests();
					return reliableMarginLeftVal;
					},
					scrollboxSize: function() {
					computeStyleTests();
					return scrollboxSizeVal;
					},

					// Support: IE 9 - 11+, Edge 15 - 18+
					// IE/Edge misreport `getComputedStyle` of table rows with width/height
					// set in CSS while `offset*` properties report correct values.
					// Behavior in IE 9 is more subtle than in newer versions & it passes
					// some versions of this test; make sure not to make it pass there!
					//
					// Support: Firefox 70+
					// Only Firefox includes border widths
					// in computed dimensions. (gh-4529)
					reliableTrDimensions: function() {
					var table, tr, trChild, trStyle;
					if ( reliableTrDimensionsVal == null ) {
					table = document.createElement( "table" );
					tr = document.createElement( "tr" );
					trChild = document.createElement( "div" );

					table.style.cssText = "position:absolute;left:-11111px;border-collapse:separate";
					tr.style.cssText = "border:1px solid";

					// Support: Chrome 86+
					// Height set through cssText does not get applied.
					// Computed height then comes back as 0.
					tr.style.height = "1px";
					trChild.style.height = "9px";

					// Support: Android 8 Chrome 86+
					// In our bodyBackground.html iframe,
					// display for all div elements is set to "inline",
					// which causes a problem only in Android 8 Chrome 86.
					// Ensuring the div is display: block
					// gets around this issue.
					trChild.style.display = "block";

					documentElement
					.appendChild( table )
					.appendChild( tr )
					.appendChild( trChild );

					trStyle = window.getComputedStyle( tr );
					reliableTrDimensionsVal = ( parseInt( trStyle.height, 10 ) +
					parseInt( trStyle.borderTopWidth, 10 ) +
					parseInt( trStyle.borderBottomWidth, 10 ) ) === tr.offsetHeight;

					documentElement.removeChild( table );
					}
					return reliableTrDimensionsVal;
					}
					} );
					} )();


					function curCSS( elem, name, computed ) {
					var width, minWidth, maxWidth, ret,
					isCustomProp = rcustomProp.test( name ),

					// Support: Firefox 51+
					// Retrieving style before computed somehow
					// fixes an issue with getting wrong values
					// on detached elements
					style = elem.style;

					computed = computed || getStyles( elem );

					// getPropertyValue is needed for:
					// .css('filter') (IE 9 only, trac-12537)
					// .css('--customProperty) (gh-3144)
					if ( computed ) {

					// Support: IE <=9 - 11+
					// IE only supports `"float"` in `getPropertyValue`; in computed styles
					// it's only available as `"cssFloat"`. We no longer modify properties
					// sent to `.css()` apart from camelCasing, so we need to check both.
					// Normally, this would create difference in behavior: if
					// `getPropertyValue` returns an empty string, the value returned
					// by `.css()` would be `undefined`. This is usually the case for
					// disconnected elements. However, in IE even disconnected elements
					// with no styles return `"none"` for `getPropertyValue( "float" )`
					ret = computed.getPropertyValue( name ) || computed[ name ];

					if ( isCustomProp && ret ) {

					// Support: Firefox 105+, Chrome <=105+
					// Spec requires trimming whitespace for custom properties (gh-4926).
					// Firefox only trims leading whitespace. Chrome just collapses
					// both leading & trailing whitespace to a single space.
					//
					// Fall back to `undefined` if empty string returned.
					// This collapses a missing definition with property defined
					// and set to an empty string but there's no standard API
					// allowing us to differentiate them without a performance penalty
					// and returning `undefined` aligns with older jQuery.
					//
					// rtrimCSS treats U+000D CARRIAGE RETURN and U+000C FORM FEED
					// as whitespace while CSS does not, but this is not a problem
					// because CSS preprocessing replaces them with U+000A LINE FEED
					// (which *is* CSS whitespace)
					// https://www.w3.org/TR/css-syntax-3/#input-preprocessing
					ret = ret.replace( rtrimCSS, "$1" ) || undefined;
					}

					if ( ret === "" && !isAttached( elem ) ) {
					ret = jQuery.style( elem, name );
					}

					// A tribute to the "awesome hack by Dean Edwards"
					// Android Browser returns percentage for some values,
					// but width seems to be reliably pixels.
					// This is against the CSSOM draft spec:
					// https://drafts.csswg.org/cssom/#resolved-values
					if ( !support.pixelBoxStyles() && rnumnonpx.test( ret ) && rboxStyle.test( name ) ) {

					// Remember the original values
					width = style.width;
					minWidth = style.minWidth;
					maxWidth = style.maxWidth;

					// Put in the new values to get a computed value out
					style.minWidth = style.maxWidth = style.width = ret;
					ret = computed.width;

					// Revert the changed values
					style.width = width;
					style.minWidth = minWidth;
					style.maxWidth = maxWidth;
					}
					}

					return ret !== undefined ?

					// Support: IE <=9 - 11 only
					// IE returns zIndex value as an integer.
					ret + "" :
					ret;
					}


					function addGetHookIf( conditionFn, hookFn ) {

					// Define the hook, we'll check on the first run if it's really needed.
					return {
					get: function() {
					if ( conditionFn() ) {

					// Hook not needed (or it's not possible to use it due
					// to missing dependency), remove it.
					delete this.get;
					return;
					}

					// Hook needed; redefine it so that the support test is not executed again.
					return ( this.get = hookFn ).apply( this, arguments );
					}
					};
					}


					var cssPrefixes = [ "Webkit", "Moz", "ms" ],
					emptyStyle = document.createElement( "div" ).style,
					vendorProps = {};

					// Return a vendor-prefixed property or undefined
					function vendorPropName( name ) {

					// Check for vendor prefixed names
					var capName = name[ 0 ].toUpperCase() + name.slice( 1 ),
					i = cssPrefixes.length;

					while ( i-- ) {
					name = cssPrefixes[ i ] + capName;
					if ( name in emptyStyle ) {
					return name;
					}
					}
					}

					// Return a potentially-mapped jQuery.cssProps or vendor prefixed property
					function finalPropName( name ) {
					var final = jQuery.cssProps[ name ] || vendorProps[ name ];

					if ( final ) {
					return final;
					}
					if ( name in emptyStyle ) {
					return name;
					}
					return vendorProps[ name ] = vendorPropName( name ) || name;
					}


					var

					// Swappable if display is none or starts with table
					// except "table", "table-cell", or "table-caption"
					// See here for display values: https://developer.mozilla.org/en-US/docs/CSS/display
					rdisplayswap = /^(none|table(?!-c[ea]).+)/,
					cssShow = { position: "absolute", visibility: "hidden", display: "block" },
					cssNormalTransform = {
					letterSpacing: "0",
					fontWeight: "400"
					};

					function setPositiveNumber( _elem, value, subtract ) {

					// Any relative (+/-) values have already been
					// normalized at this point
					var matches = rcssNum.exec( value );
					return matches ?

					// Guard against undefined "subtract", e.g., when used as in cssHooks
					Math.max( 0, matches[ 2 ] - ( subtract || 0 ) ) + ( matches[ 3 ] || "px" ) :
					value;
					}

					function boxModelAdjustment( elem, dimension, box, isBorderBox, styles, computedVal ) {
					var i = dimension === "width" ? 1 : 0,
					extra = 0,
					delta = 0,
					marginDelta = 0;

					// Adjustment may not be necessary
					if ( box === ( isBorderBox ? "border" : "content" ) ) {
					return 0;
					}

					for ( ; i < 4; i += 2 ) {

					// Both box models exclude margin
					// Count margin delta separately to only add it after scroll gutter adjustment.
					// This is needed to make negative margins work with `outerHeight( true )` (gh-3982).
					if ( box === "margin" ) {
					marginDelta += jQuery.css( elem, box + cssExpand[ i ], true, styles );
					}

					// If we get here with a content-box, we're seeking "padding" or "border" or "margin"
					if ( !isBorderBox ) {

					// Add padding
					delta += jQuery.css( elem, "padding" + cssExpand[ i ], true, styles );

					// For "border" or "margin", add border
					if ( box !== "padding" ) {
					delta += jQuery.css( elem, "border" + cssExpand[ i ] + "Width", true, styles );

					// But still keep track of it otherwise
					} else {
					extra += jQuery.css( elem, "border" + cssExpand[ i ] + "Width", true, styles );
					}

					// If we get here with a border-box (content + padding + border), we're seeking "content" or
					// "padding" or "margin"
					} else {

					// For "content", subtract padding
					if ( box === "content" ) {
					delta -= jQuery.css( elem, "padding" + cssExpand[ i ], true, styles );
					}

					// For "content" or "padding", subtract border
					if ( box !== "margin" ) {
					delta -= jQuery.css( elem, "border" + cssExpand[ i ] + "Width", true, styles );
					}
					}
					}

					// Account for positive content-box scroll gutter when requested by providing computedVal
					if ( !isBorderBox && computedVal >= 0 ) {

					// offsetWidth/offsetHeight is a rounded sum of content, padding, scroll gutter, and border
					// Assuming integer scroll gutter, subtract the rest and round down
					delta += Math.max( 0, Math.ceil(
					elem[ "offset" + dimension[ 0 ].toUpperCase() + dimension.slice( 1 ) ] -
					computedVal -
					delta -
					extra -
					0.5

					// If offsetWidth/offsetHeight is unknown, then we can't determine content-box scroll gutter
					// Use an explicit zero to avoid NaN (gh-3964)
					) ) || 0;
					}

					return delta + marginDelta;
					}

					function getWidthOrHeight( elem, dimension, extra ) {

					// Start with computed style
					var styles = getStyles( elem ),

					// To avoid forcing a reflow, only fetch boxSizing if we need it (gh-4322).
					// Fake content-box until we know it's needed to know the true value.
					boxSizingNeeded = !support.boxSizingReliable() || extra,
					isBorderBox = boxSizingNeeded &&
					jQuery.css( elem, "boxSizing", false, styles ) === "border-box",
					valueIsBorderBox = isBorderBox,

					val = curCSS( elem, dimension, styles ),
					offsetProp = "offset" + dimension[ 0 ].toUpperCase() + dimension.slice( 1 );

					// Support: Firefox <=54
					// Return a confounding non-pixel value or feign ignorance, as appropriate.
					if ( rnumnonpx.test( val ) ) {
					if ( !extra ) {
					return val;
					}
					val = "auto";
					}


					// Support: IE 9 - 11 only
					// Use offsetWidth/offsetHeight for when box sizing is unreliable.
					// In those cases, the computed value can be trusted to be border-box.
					if ( ( !support.boxSizingReliable() && isBorderBox ||

					// Support: IE 10 - 11+, Edge 15 - 18+
					// IE/Edge misreport `getComputedStyle` of table rows with width/height
					// set in CSS while `offset*` properties report correct values.
					// Interestingly, in some cases IE 9 doesn't suffer from this issue.
					!support.reliableTrDimensions() && nodeName( elem, "tr" ) ||

					// Fall back to offsetWidth/offsetHeight when value is "auto"
					// This happens for inline elements with no explicit setting (gh-3571)
					val === "auto" ||

					// Support: Android <=4.1 - 4.3 only
					// Also use offsetWidth/offsetHeight for misreported inline dimensions (gh-3602)
					!parseFloat( val ) && jQuery.css( elem, "display", false, styles ) === "inline" ) &&

					// Make sure the element is visible & connected
					elem.getClientRects().length ) {

					isBorderBox = jQuery.css( elem, "boxSizing", false, styles ) === "border-box";

					// Where available, offsetWidth/offsetHeight approximate border box dimensions.
					// Where not available (e.g., SVG), assume unreliable box-sizing and interpret the
					// retrieved value as a content box dimension.
					valueIsBorderBox = offsetProp in elem;
					if ( valueIsBorderBox ) {
					val = elem[ offsetProp ];
					}
					}

					// Normalize "" and auto
					val = parseFloat( val ) || 0;

					// Adjust for the element's box model
					return ( val +
					boxModelAdjustment(
					elem,
					dimension,
					extra || ( isBorderBox ? "border" : "content" ),
					valueIsBorderBox,
					styles,

					// Provide the current computed size to request scroll gutter calculation (gh-3589)
					val
					)
					) + "px";
					}

					jQuery.extend( {

					// Add in style property hooks for overriding the default
					// behavior of getting and setting a style property
					cssHooks: {
					opacity: {
					get: function( elem, computed ) {
					if ( computed ) {

					// We should always get a number back from opacity
					var ret = curCSS( elem, "opacity" );
					return ret === "" ? "1" : ret;
					}
					}
					}
					},

					// Don't automatically add "px" to these possibly-unitless properties
					cssNumber: {
					animationIterationCount: true,
					aspectRatio: true,
					borderImageSlice: true,
					columnCount: true,
					flexGrow: true,
					flexShrink: true,
					fontWeight: true,
					gridArea: true,
					gridColumn: true,
					gridColumnEnd: true,
					gridColumnStart: true,
					gridRow: true,
					gridRowEnd: true,
					gridRowStart: true,
					lineHeight: true,
					opacity: true,
					order: true,
					orphans: true,
					scale: true,
					widows: true,
					zIndex: true,
					zoom: true,

					// SVG-related
					fillOpacity: true,
					floodOpacity: true,
					stopOpacity: true,
					strokeMiterlimit: true,
					strokeOpacity: true
					},

					// Add in properties whose names you wish to fix before
					// setting or getting the value
					cssProps: {},

					// Get and set the style property on a DOM Node
					style: function( elem, name, value, extra ) {

					// Don't set styles on text and comment nodes
					if ( !elem || elem.nodeType === 3 || elem.nodeType === 8 || !elem.style ) {
					return;
					}

					// Make sure that we're working with the right name
					var ret, type, hooks,
					origName = camelCase( name ),
					isCustomProp = rcustomProp.test( name ),
					style = elem.style;

					// Make sure that we're working with the right name. We don't
					// want to query the value if it is a CSS custom property
					// since they are user-defined.
					if ( !isCustomProp ) {
					name = finalPropName( origName );
					}

					// Gets hook for the prefixed version, then unprefixed version
					hooks = jQuery.cssHooks[ name ] || jQuery.cssHooks[ origName ];

					// Check if we're setting a value
					if ( value !== undefined ) {
					type = typeof value;

					// Convert "+=" or "-=" to relative numbers (trac-7345)
					if ( type === "string" && ( ret = rcssNum.exec( value ) ) && ret[ 1 ] ) {
					value = adjustCSS( elem, name, ret );

					// Fixes bug trac-9237
					type = "number";
					}

					// Make sure that null and NaN values aren't set (trac-7116)
					if ( value == null || value !== value ) {
					return;
					}

					// If a number was passed in, add the unit (except for certain CSS properties)
					// The isCustomProp check can be removed in jQuery 4.0 when we only auto-append
					// "px" to a few hardcoded values.
					if ( type === "number" && !isCustomProp ) {
					value += ret && ret[ 3 ] || ( jQuery.cssNumber[ origName ] ? "" : "px" );
					}

					// background-* props affect original clone's values
					if ( !support.clearCloneStyle && value === "" && name.indexOf( "background" ) === 0 ) {
					style[ name ] = "inherit";
					}

					// If a hook was provided, use that value, otherwise just set the specified value
					if ( !hooks || !( "set" in hooks ) ||
					( value = hooks.set( elem, value, extra ) ) !== undefined ) {

					if ( isCustomProp ) {
					style.setProperty( name, value );
					} else {
					style[ name ] = value;
					}
					}

					} else {

					// If a hook was provided get the non-computed value from there
					if ( hooks && "get" in hooks &&
					( ret = hooks.get( elem, false, extra ) ) !== undefined ) {

					return ret;
					}

					// Otherwise just get the value from the style object
					return style[ name ];
					}
					},

					css: function( elem, name, extra, styles ) {
					var val, num, hooks,
					origName = camelCase( name ),
					isCustomProp = rcustomProp.test( name );

					// Make sure that we're working with the right name. We don't
					// want to modify the value if it is a CSS custom property
					// since they are user-defined.
					if ( !isCustomProp ) {
					name = finalPropName( origName );
					}

					// Try prefixed name followed by the unprefixed name
					hooks = jQuery.cssHooks[ name ] || jQuery.cssHooks[ origName ];

					// If a hook was provided get the computed value from there
					if ( hooks && "get" in hooks ) {
					val = hooks.get( elem, true, extra );
					}

					// Otherwise, if a way to get the computed value exists, use that
					if ( val === undefined ) {
					val = curCSS( elem, name, styles );
					}

					// Convert "normal" to computed value
					if ( val === "normal" && name in cssNormalTransform ) {
					val = cssNormalTransform[ name ];
					}

					// Make numeric if forced or a qualifier was provided and val looks numeric
					if ( extra === "" || extra ) {
					num = parseFloat( val );
					return extra === true || isFinite( num ) ? num || 0 : val;
					}

					return val;
					}
					} );

					jQuery.each( [ "height", "width" ], function( _i, dimension ) {
					jQuery.cssHooks[ dimension ] = {
					get: function( elem, computed, extra ) {
					if ( computed ) {

					// Certain elements can have dimension info if we invisibly show them
					// but it must have a current display style that would benefit
					return rdisplayswap.test( jQuery.css( elem, "display" ) ) &&

					// Support: Safari 8+
					// Table columns in Safari have non-zero offsetWidth & zero
					// getBoundingClientRect().width unless display is changed.
					// Support: IE <=11 only
					// Running getBoundingClientRect on a disconnected node
					// in IE throws an error.
					( !elem.getClientRects().length || !elem.getBoundingClientRect().width ) ?
					swap( elem, cssShow, function() {
					return getWidthOrHeight( elem, dimension, extra );
					} ) :
					getWidthOrHeight( elem, dimension, extra );
					}
					},

					set: function( elem, value, extra ) {
					var matches,
					styles = getStyles( elem ),

					// Only read styles.position if the test has a chance to fail
					// to avoid forcing a reflow.
					scrollboxSizeBuggy = !support.scrollboxSize() &&
					styles.position === "absolute",

					// To avoid forcing a reflow, only fetch boxSizing if we need it (gh-3991)
					boxSizingNeeded = scrollboxSizeBuggy || extra,
					isBorderBox = boxSizingNeeded &&
					jQuery.css( elem, "boxSizing", false, styles ) === "border-box",
					subtract = extra ?
					boxModelAdjustment(
					elem,
					dimension,
					extra,
					isBorderBox,
					styles
					) :
					0;

					// Account for unreliable border-box dimensions by comparing offset* to computed and
					// faking a content-box to get border and padding (gh-3699)
					if ( isBorderBox && scrollboxSizeBuggy ) {
					subtract -= Math.ceil(
					elem[ "offset" + dimension[ 0 ].toUpperCase() + dimension.slice( 1 ) ] -
					parseFloat( styles[ dimension ] ) -
					boxModelAdjustment( elem, dimension, "border", false, styles ) -
					0.5
					);
					}

					// Convert to pixels if value adjustment is needed
					if ( subtract && ( matches = rcssNum.exec( value ) ) &&
					( matches[ 3 ] || "px" ) !== "px" ) {

					elem.style[ dimension ] = value;
					value = jQuery.css( elem, dimension );
					}

					return setPositiveNumber( elem, value, subtract );
					}
					};
					} );

					jQuery.cssHooks.marginLeft = addGetHookIf( support.reliableMarginLeft,
					function( elem, computed ) {
					if ( computed ) {
					return ( parseFloat( curCSS( elem, "marginLeft" ) ) ||
					elem.getBoundingClientRect().left -
					swap( elem, { marginLeft: 0 }, function() {
					return elem.getBoundingClientRect().left;
					} )
					) + "px";
					}
					}
					);

					// These hooks are used by animate to expand properties
					jQuery.each( {
					margin: "",
					padding: "",
					border: "Width"
					}, function( prefix, suffix ) {
					jQuery.cssHooks[ prefix + suffix ] = {
					expand: function( value ) {
					var i = 0,
					expanded = {},

					// Assumes a single number if not a string
					parts = typeof value === "string" ? value.split( " " ) : [ value ];

					for ( ; i < 4; i++ ) {
					expanded[ prefix + cssExpand[ i ] + suffix ] =
					parts[ i ] || parts[ i - 2 ] || parts[ 0 ];
					}

					return expanded;
					}
					};

					if ( prefix !== "margin" ) {
					jQuery.cssHooks[ prefix + suffix ].set = setPositiveNumber;
					}
					} );

					jQuery.fn.extend( {
					css: function( name, value ) {
					return access( this, function( elem, name, value ) {
					var styles, len,
					map = {},
					i = 0;

					if ( Array.isArray( name ) ) {
					styles = getStyles( elem );
					len = name.length;

					for ( ; i < len; i++ ) {
					map[ name[ i ] ] = jQuery.css( elem, name[ i ], false, styles );
					}

					return map;
					}

					return value !== undefined ?
					jQuery.style( elem, name, value ) :
					jQuery.css( elem, name );
					}, name, value, arguments.length > 1 );
					}
					} );


					function Tween( elem, options, prop, end, easing ) {
					return new Tween.prototype.init( elem, options, prop, end, easing );
					}
					jQuery.Tween = Tween;

					Tween.prototype = {
					constructor: Tween,
					init: function( elem, options, prop, end, easing, unit ) {
					this.elem = elem;
					this.prop = prop;
					this.easing = easing || jQuery.easing._default;
					this.options = options;
					this.start = this.now = this.cur();
					this.end = end;
					this.unit = unit || ( jQuery.cssNumber[ prop ] ? "" : "px" );
					},
					cur: function() {
					var hooks = Tween.propHooks[ this.prop ];

					return hooks && hooks.get ?
					hooks.get( this ) :
					Tween.propHooks._default.get( this );
					},
					run: function( percent ) {
					var eased,
					hooks = Tween.propHooks[ this.prop ];

					if ( this.options.duration ) {
					this.pos = eased = jQuery.easing[ this.easing ](
					percent, this.options.duration * percent, 0, 1, this.options.duration
					);
					} else {
					this.pos = eased = percent;
					}
					this.now = ( this.end - this.start ) * eased + this.start;

					if ( this.options.step ) {
					this.options.step.call( this.elem, this.now, this );
					}

					if ( hooks && hooks.set ) {
					hooks.set( this );
					} else {
					Tween.propHooks._default.set( this );
					}
					return this;
					}
					};

					Tween.prototype.init.prototype = Tween.prototype;

					Tween.propHooks = {
					_default: {
					get: function( tween ) {
					var result;

					// Use a property on the element directly when it is not a DOM element,
					// or when there is no matching style property that exists.
					if ( tween.elem.nodeType !== 1 ||
					tween.elem[ tween.prop ] != null && tween.elem.style[ tween.prop ] == null ) {
					return tween.elem[ tween.prop ];
					}

					// Passing an empty string as a 3rd parameter to .css will automatically
					// attempt a parseFloat and fallback to a string if the parse fails.
					// Simple values such as "10px" are parsed to Float;
					// complex values such as "rotate(1rad)" are returned as-is.
					result = jQuery.css( tween.elem, tween.prop, "" );

					// Empty strings, null, undefined and "auto" are converted to 0.
					return !result || result === "auto" ? 0 : result;
					},
					set: function( tween ) {

					// Use step hook for back compat.
					// Use cssHook if its there.
					// Use .style if available and use plain properties where available.
					if ( jQuery.fx.step[ tween.prop ] ) {
					jQuery.fx.step[ tween.prop ]( tween );
					} else if ( tween.elem.nodeType === 1 && (
					jQuery.cssHooks[ tween.prop ] ||
					tween.elem.style[ finalPropName( tween.prop ) ] != null ) ) {
					jQuery.style( tween.elem, tween.prop, tween.now + tween.unit );
					} else {
					tween.elem[ tween.prop ] = tween.now;
					}
					}
					}
					};

					// Support: IE <=9 only
					// Panic based approach to setting things on disconnected nodes
					Tween.propHooks.scrollTop = Tween.propHooks.scrollLeft = {
					set: function( tween ) {
					if ( tween.elem.nodeType && tween.elem.parentNode ) {
					tween.elem[ tween.prop ] = tween.now;
					}
					}
					};

					jQuery.easing = {
					linear: function( p ) {
					return p;
					},
					swing: function( p ) {
					return 0.5 - Math.cos( p * Math.PI ) / 2;
					},
					_default: "swing"
					};

					jQuery.fx = Tween.prototype.init;

					// Back compat <1.8 extension point
					jQuery.fx.step = {};


					var
					fxNow, inProgress,
					rfxtypes = /^(?:toggle|show|hide)$/,
					rrun = /queueHooks$/;

					function schedule() {
					if ( inProgress ) {
					if ( document.hidden === false && window.requestAnimationFrame ) {
					window.requestAnimationFrame( schedule );
					} else {
					window.setTimeout( schedule, jQuery.fx.interval );
					}

					jQuery.fx.tick();
					}
					}

					// Animations created synchronously will run synchronously
					function createFxNow() {
					window.setTimeout( function() {
					fxNow = undefined;
					} );
					return ( fxNow = Date.now() );
					}

					// Generate parameters to create a standard animation
					function genFx( type, includeWidth ) {
					var which,
					i = 0,
					attrs = { height: type };

					// If we include width, step value is 1 to do all cssExpand values,
					// otherwise step value is 2 to skip over Left and Right
					includeWidth = includeWidth ? 1 : 0;
					for ( ; i < 4; i += 2 - includeWidth ) {
					which = cssExpand[ i ];
					attrs[ "margin" + which ] = attrs[ "padding" + which ] = type;
					}

					if ( includeWidth ) {
					attrs.opacity = attrs.width = type;
					}

					return attrs;
					}

					function createTween( value, prop, animation ) {
					var tween,
					collection = ( Animation.tweeners[ prop ] || [] ).concat( Animation.tweeners[ "*" ] ),
					index = 0,
					length = collection.length;
					for ( ; index < length; index++ ) {
					if ( ( tween = collection[ index ].call( animation, prop, value ) ) ) {

					// We're done with this property
					return tween;
					}
					}
					}

					function defaultPrefilter( elem, props, opts ) {
					var prop, value, toggle, hooks, oldfire, propTween, restoreDisplay, display,
					isBox = "width" in props || "height" in props,
					anim = this,
					orig = {},
					style = elem.style,
					hidden = elem.nodeType && isHiddenWithinTree( elem ),
					dataShow = dataPriv.get( elem, "fxshow" );

					// Queue-skipping animations hijack the fx hooks
					if ( !opts.queue ) {
					hooks = jQuery._queueHooks( elem, "fx" );
					if ( hooks.unqueued == null ) {
					hooks.unqueued = 0;
					oldfire = hooks.empty.fire;
					hooks.empty.fire = function() {
					if ( !hooks.unqueued ) {
					oldfire();
					}
					};
					}
					hooks.unqueued++;

					anim.always( function() {

					// Ensure the complete handler is called before this completes
					anim.always( function() {
					hooks.unqueued--;
					if ( !jQuery.queue( elem, "fx" ).length ) {
					hooks.empty.fire();
					}
					} );
					} );
					}

					// Detect show/hide animations
					for ( prop in props ) {
					value = props[ prop ];
					if ( rfxtypes.test( value ) ) {
					delete props[ prop ];
					toggle = toggle || value === "toggle";
					if ( value === ( hidden ? "hide" : "show" ) ) {

					// Pretend to be hidden if this is a "show" and
					// there is still data from a stopped show/hide
					if ( value === "show" && dataShow && dataShow[ prop ] !== undefined ) {
					hidden = true;

					// Ignore all other no-op show/hide data
					} else {
					continue;
					}
					}
					orig[ prop ] = dataShow && dataShow[ prop ] || jQuery.style( elem, prop );
					}
					}

					// Bail out if this is a no-op like .hide().hide()
					propTween = !jQuery.isEmptyObject( props );
					if ( !propTween && jQuery.isEmptyObject( orig ) ) {
					return;
					}

					// Restrict "overflow" and "display" styles during box animations
					if ( isBox && elem.nodeType === 1 ) {

					// Support: IE <=9 - 11, Edge 12 - 15
					// Record all 3 overflow attributes because IE does not infer the shorthand
					// from identically-valued overflowX and overflowY and Edge just mirrors
					// the overflowX value there.
					opts.overflow = [ style.overflow, style.overflowX, style.overflowY ];

					// Identify a display type, preferring old show/hide data over the CSS cascade
					restoreDisplay = dataShow && dataShow.display;
					if ( restoreDisplay == null ) {
					restoreDisplay = dataPriv.get( elem, "display" );
					}
					display = jQuery.css( elem, "display" );
					if ( display === "none" ) {
					if ( restoreDisplay ) {
					display = restoreDisplay;
					} else {

					// Get nonempty value(s) by temporarily forcing visibility
					showHide( [ elem ], true );
					restoreDisplay = elem.style.display || restoreDisplay;
					display = jQuery.css( elem, "display" );
					showHide( [ elem ] );
					}
					}

					// Animate inline elements as inline-block
					if ( display === "inline" || display === "inline-block" && restoreDisplay != null ) {
					if ( jQuery.css( elem, "float" ) === "none" ) {

					// Restore the original display value at the end of pure show/hide animations
					if ( !propTween ) {
					anim.done( function() {
					style.display = restoreDisplay;
					} );
					if ( restoreDisplay == null ) {
					display = style.display;
					restoreDisplay = display === "none" ? "" : display;
					}
					}
					style.display = "inline-block";
					}
					}
					}

					if ( opts.overflow ) {
					style.overflow = "hidden";
					anim.always( function() {
					style.overflow = opts.overflow[ 0 ];
					style.overflowX = opts.overflow[ 1 ];
					style.overflowY = opts.overflow[ 2 ];
					} );
					}

					// Implement show/hide animations
					propTween = false;
					for ( prop in orig ) {

					// General show/hide setup for this element animation
					if ( !propTween ) {
					if ( dataShow ) {
					if ( "hidden" in dataShow ) {
					hidden = dataShow.hidden;
					}
					} else {
					dataShow = dataPriv.access( elem, "fxshow", { display: restoreDisplay } );
					}

					// Store hidden/visible for toggle so `.stop().toggle()` "reverses"
					if ( toggle ) {
					dataShow.hidden = !hidden;
					}

					// Show elements before animating them
					if ( hidden ) {
					showHide( [ elem ], true );
					}

					/* eslint-disable no-loop-func */

					anim.done( function() {

					/* eslint-enable no-loop-func */

					// The final step of a "hide" animation is actually hiding the element
					if ( !hidden ) {
					showHide( [ elem ] );
					}
					dataPriv.remove( elem, "fxshow" );
					for ( prop in orig ) {
					jQuery.style( elem, prop, orig[ prop ] );
					}
					} );
					}

					// Per-property setup
					propTween = createTween( hidden ? dataShow[ prop ] : 0, prop, anim );
					if ( !( prop in dataShow ) ) {
					dataShow[ prop ] = propTween.start;
					if ( hidden ) {
					propTween.end = propTween.start;
					propTween.start = 0;
					}
					}
					}
					}

					function propFilter( props, specialEasing ) {
					var index, name, easing, value, hooks;

					// camelCase, specialEasing and expand cssHook pass
					for ( index in props ) {
					name = camelCase( index );
					easing = specialEasing[ name ];
					value = props[ index ];
					if ( Array.isArray( value ) ) {
					easing = value[ 1 ];
					value = props[ index ] = value[ 0 ];
					}

					if ( index !== name ) {
					props[ name ] = value;
					delete props[ index ];
					}

					hooks = jQuery.cssHooks[ name ];
					if ( hooks && "expand" in hooks ) {
					value = hooks.expand( value );
					delete props[ name ];

					// Not quite $.extend, this won't overwrite existing keys.
					// Reusing 'index' because we have the correct "name"
					for ( index in value ) {
					if ( !( index in props ) ) {
					props[ index ] = value[ index ];
					specialEasing[ index ] = easing;
					}
					}
					} else {
					specialEasing[ name ] = easing;
					}
					}
					}

					function Animation( elem, properties, options ) {
					var result,
					stopped,
					index = 0,
					length = Animation.prefilters.length,
					deferred = jQuery.Deferred().always( function() {

					// Don't match elem in the :animated selector
					delete tick.elem;
					} ),
					tick = function() {
					if ( stopped ) {
					return false;
					}
					var currentTime = fxNow || createFxNow(),
					remaining = Math.max( 0, animation.startTime + animation.duration - currentTime ),

					// Support: Android 2.3 only
					// Archaic crash bug won't allow us to use `1 - ( 0.5 || 0 )` (trac-12497)
					temp = remaining / animation.duration || 0,
					percent = 1 - temp,
					index = 0,
					length = animation.tweens.length;

					for ( ; index < length; index++ ) {
					animation.tweens[ index ].run( percent );
					}

					deferred.notifyWith( elem, [ animation, percent, remaining ] );

					// If there's more to do, yield
					if ( percent < 1 && length ) {
					return remaining;
					}

					// If this was an empty animation, synthesize a final progress notification
					if ( !length ) {
					deferred.notifyWith( elem, [ animation, 1, 0 ] );
					}

					// Resolve the animation and report its conclusion
					deferred.resolveWith( elem, [ animation ] );
					return false;
					},
					animation = deferred.promise( {
					elem: elem,
					props: jQuery.extend( {}, properties ),
					opts: jQuery.extend( true, {
					specialEasing: {},
					easing: jQuery.easing._default
					}, options ),
					originalProperties: properties,
					originalOptions: options,
					startTime: fxNow || createFxNow(),
					duration: options.duration,
					tweens: [],
					createTween: function( prop, end ) {
					var tween = jQuery.Tween( elem, animation.opts, prop, end,
					animation.opts.specialEasing[ prop ] || animation.opts.easing );
					animation.tweens.push( tween );
					return tween;
					},
					stop: function( gotoEnd ) {
					var index = 0,

					// If we are going to the end, we want to run all the tweens
					// otherwise we skip this part
					length = gotoEnd ? animation.tweens.length : 0;
					if ( stopped ) {
					return this;
					}
					stopped = true;
					for ( ; index < length; index++ ) {
					animation.tweens[ index ].run( 1 );
					}

					// Resolve when we played the last frame; otherwise, reject
					if ( gotoEnd ) {
					deferred.notifyWith( elem, [ animation, 1, 0 ] );
					deferred.resolveWith( elem, [ animation, gotoEnd ] );
					} else {
					deferred.rejectWith( elem, [ animation, gotoEnd ] );
					}
					return this;
					}
					} ),
					props = animation.props;

					propFilter( props, animation.opts.specialEasing );

					for ( ; index < length; index++ ) {
					result = Animation.prefilters[ index ].call( animation, elem, props, animation.opts );
					if ( result ) {
					if ( isFunction( result.stop ) ) {
					jQuery._queueHooks( animation.elem, animation.opts.queue ).stop =
					result.stop.bind( result );
					}
					return result;
					}
					}

					jQuery.map( props, createTween, animation );

					if ( isFunction( animation.opts.start ) ) {
					animation.opts.start.call( elem, animation );
					}

					// Attach callbacks from options
					animation
					.progress( animation.opts.progress )
					.done( animation.opts.done, animation.opts.complete )
					.fail( animation.opts.fail )
					.always( animation.opts.always );

					jQuery.fx.timer(
					jQuery.extend( tick, {
					elem: elem,
					anim: animation,
					queue: animation.opts.queue
					} )
					);

					return animation;
					}

					jQuery.Animation = jQuery.extend( Animation, {

					tweeners: {
					"*": [ function( prop, value ) {
					var tween = this.createTween( prop, value );
					adjustCSS( tween.elem, prop, rcssNum.exec( value ), tween );
					return tween;
					} ]
					},

					tweener: function( props, callback ) {
					if ( isFunction( props ) ) {
					callback = props;
					props = [ "*" ];
					} else {
					props = props.match( rnothtmlwhite );
					}

					var prop,
					index = 0,
					length = props.length;

					for ( ; index < length; index++ ) {
					prop = props[ index ];
					Animation.tweeners[ prop ] = Animation.tweeners[ prop ] || [];
					Animation.tweeners[ prop ].unshift( callback );
					}
					},

					prefilters: [ defaultPrefilter ],

					prefilter: function( callback, prepend ) {
					if ( prepend ) {
					Animation.prefilters.unshift( callback );
					} else {
					Animation.prefilters.push( callback );
					}
					}
					} );

					jQuery.speed = function( speed, easing, fn ) {
					var opt = speed && typeof speed === "object" ? jQuery.extend( {}, speed ) : {
					complete: fn || !fn && easing ||
					isFunction( speed ) && speed,
					duration: speed,
					easing: fn && easing || easing && !isFunction( easing ) && easing
					};

					// Go to the end state if fx are off
					if ( jQuery.fx.off ) {
					opt.duration = 0;

					} else {
					if ( typeof opt.duration !== "number" ) {
					if ( opt.duration in jQuery.fx.speeds ) {
					opt.duration = jQuery.fx.speeds[ opt.duration ];

					} else {
					opt.duration = jQuery.fx.speeds._default;
					}
					}
					}

					// Normalize opt.queue - true/undefined/null -> "fx"
					if ( opt.queue == null || opt.queue === true ) {
					opt.queue = "fx";
					}

					// Queueing
					opt.old = opt.complete;

					opt.complete = function() {
					if ( isFunction( opt.old ) ) {
					opt.old.call( this );
					}

					if ( opt.queue ) {
					jQuery.dequeue( this, opt.queue );
					}
					};

					return opt;
					};

					jQuery.fn.extend( {
					fadeTo: function( speed, to, easing, callback ) {

					// Show any hidden elements after setting opacity to 0
					return this.filter( isHiddenWithinTree ).css( "opacity", 0 ).show()

					// Animate to the value specified
					.end().animate( { opacity: to }, speed, easing, callback );
					},
					animate: function( prop, speed, easing, callback ) {
					var empty = jQuery.isEmptyObject( prop ),
					optall = jQuery.speed( speed, easing, callback ),
					doAnimation = function() {

					// Operate on a copy of prop so per-property easing won't be lost
					var anim = Animation( this, jQuery.extend( {}, prop ), optall );

					// Empty animations, or finishing resolves immediately
					if ( empty || dataPriv.get( this, "finish" ) ) {
					anim.stop( true );
					}
					};

					doAnimation.finish = doAnimation;

					return empty || optall.queue === false ?
					this.each( doAnimation ) :
					this.queue( optall.queue, doAnimation );
					},
					stop: function( type, clearQueue, gotoEnd ) {
					var stopQueue = function( hooks ) {
					var stop = hooks.stop;
					delete hooks.stop;
					stop( gotoEnd );
					};

					if ( typeof type !== "string" ) {
					gotoEnd = clearQueue;
					clearQueue = type;
					type = undefined;
					}
					if ( clearQueue ) {
					this.queue( type || "fx", [] );
					}

					return this.each( function() {
					var dequeue = true,
					index = type != null && type + "queueHooks",
					timers = jQuery.timers,
					data = dataPriv.get( this );

					if ( index ) {
					if ( data[ index ] && data[ index ].stop ) {
					stopQueue( data[ index ] );
					}
					} else {
					for ( index in data ) {
					if ( data[ index ] && data[ index ].stop && rrun.test( index ) ) {
					stopQueue( data[ index ] );
					}
					}
					}

					for ( index = timers.length; index--; ) {
					if ( timers[ index ].elem === this &&
					( type == null || timers[ index ].queue === type ) ) {

					timers[ index ].anim.stop( gotoEnd );
					dequeue = false;
					timers.splice( index, 1 );
					}
					}

					// Start the next in the queue if the last step wasn't forced.
					// Timers currently will call their complete callbacks, which
					// will dequeue but only if they were gotoEnd.
					if ( dequeue || !gotoEnd ) {
					jQuery.dequeue( this, type );
					}
					} );
					},
					finish: function( type ) {
					if ( type !== false ) {
					type = type || "fx";
					}
					return this.each( function() {
					var index,
					data = dataPriv.get( this ),
					queue = data[ type + "queue" ],
					hooks = data[ type + "queueHooks" ],
					timers = jQuery.timers,
					length = queue ? queue.length : 0;

					// Enable finishing flag on private data
					data.finish = true;

					// Empty the queue first
					jQuery.queue( this, type, [] );

					if ( hooks && hooks.stop ) {
					hooks.stop.call( this, true );
					}

					// Look for any active animations, and finish them
					for ( index = timers.length; index--; ) {
					if ( timers[ index ].elem === this && timers[ index ].queue === type ) {
					timers[ index ].anim.stop( true );
					timers.splice( index, 1 );
					}
					}

					// Look for any animations in the old queue and finish them
					for ( index = 0; index < length; index++ ) {
					if ( queue[ index ] && queue[ index ].finish ) {
					queue[ index ].finish.call( this );
					}
					}

					// Turn off finishing flag
					delete data.finish;
					} );
					}
					} );

					jQuery.each( [ "toggle", "show", "hide" ], function( _i, name ) {
					var cssFn = jQuery.fn[ name ];
					jQuery.fn[ name ] = function( speed, easing, callback ) {
					return speed == null || typeof speed === "boolean" ?
					cssFn.apply( this, arguments ) :
					this.animate( genFx( name, true ), speed, easing, callback );
					};
					} );

					// Generate shortcuts for custom animations
					jQuery.each( {
					slideDown: genFx( "show" ),
					slideUp: genFx( "hide" ),
					slideToggle: genFx( "toggle" ),
					fadeIn: { opacity: "show" },
					fadeOut: { opacity: "hide" },
					fadeToggle: { opacity: "toggle" }
					}, function( name, props ) {
					jQuery.fn[ name ] = function( speed, easing, callback ) {
					return this.animate( props, speed, easing, callback );
					};
					} );

					jQuery.timers = [];
					jQuery.fx.tick = function() {
					var timer,
					i = 0,
					timers = jQuery.timers;

					fxNow = Date.now();

					for ( ; i < timers.length; i++ ) {
					timer = timers[ i ];

					// Run the timer and safely remove it when done (allowing for external removal)
					if ( !timer() && timers[ i ] === timer ) {
					timers.splice( i--, 1 );
					}
					}

					if ( !timers.length ) {
					jQuery.fx.stop();
					}
					fxNow = undefined;
					};

					jQuery.fx.timer = function( timer ) {
					jQuery.timers.push( timer );
					jQuery.fx.start();
					};

					jQuery.fx.interval = 13;
					jQuery.fx.start = function() {
					if ( inProgress ) {
					return;
					}

					inProgress = true;
					schedule();
					};

					jQuery.fx.stop = function() {
					inProgress = null;
					};

					jQuery.fx.speeds = {
					slow: 600,
					fast: 200,

					// Default speed
					_default: 400
					};


					// Based off of the plugin by Clint Helfers, with permission.
					jQuery.fn.delay = function( time, type ) {
					time = jQuery.fx ? jQuery.fx.speeds[ time ] || time : time;
					type = type || "fx";

					return this.queue( type, function( next, hooks ) {
					var timeout = window.setTimeout( next, time );
					hooks.stop = function() {
					window.clearTimeout( timeout );
					};
					} );
					};


					( function() {
					var input = document.createElement( "input" ),
					select = document.createElement( "select" ),
					opt = select.appendChild( document.createElement( "option" ) );

					input.type = "checkbox";

					// Support: Android <=4.3 only
					// Default value for a checkbox should be "on"
					support.checkOn = input.value !== "";

					// Support: IE <=11 only
					// Must access selectedIndex to make default options select
					support.optSelected = opt.selected;

					// Support: IE <=11 only
					// An input loses its value after becoming a radio
					input = document.createElement( "input" );
					input.value = "t";
					input.type = "radio";
					support.radioValue = input.value === "t";
					} )();


					var boolHook,
					attrHandle = jQuery.expr.attrHandle;

					jQuery.fn.extend( {
					attr: function( name, value ) {
					return access( this, jQuery.attr, name, value, arguments.length > 1 );
					},

					removeAttr: function( name ) {
					return this.each( function() {
					jQuery.removeAttr( this, name );
					} );
					}
					} );

					jQuery.extend( {
					attr: function( elem, name, value ) {
					var ret, hooks,
					nType = elem.nodeType;

					// Don't get/set attributes on text, comment and attribute nodes
					if ( nType === 3 || nType === 8 || nType === 2 ) {
					return;
					}

					// Fallback to prop when attributes are not supported
					if ( typeof elem.getAttribute === "undefined" ) {
					return jQuery.prop( elem, name, value );
					}

					// Attribute hooks are determined by the lowercase version
					// Grab necessary hook if one is defined
					if ( nType !== 1 || !jQuery.isXMLDoc( elem ) ) {
					hooks = jQuery.attrHooks[ name.toLowerCase() ] ||
					( jQuery.expr.match.bool.test( name ) ? boolHook : undefined );
					}

					if ( value !== undefined ) {
					if ( value === null ) {
					jQuery.removeAttr( elem, name );
					return;
					}

					if ( hooks && "set" in hooks &&
					( ret = hooks.set( elem, value, name ) ) !== undefined ) {
					return ret;
					}

					elem.setAttribute( name, value + "" );
					return value;
					}

					if ( hooks && "get" in hooks && ( ret = hooks.get( elem, name ) ) !== null ) {
					return ret;
					}

					ret = jQuery.find.attr( elem, name );

					// Non-existent attributes return null, we normalize to undefined
					return ret == null ? undefined : ret;
					},

					attrHooks: {
					type: {
					set: function( elem, value ) {
					if ( !support.radioValue && value === "radio" &&
					nodeName( elem, "input" ) ) {
					var val = elem.value;
					elem.setAttribute( "type", value );
					if ( val ) {
					elem.value = val;
					}
					return value;
					}
					}
					}
					},

					removeAttr: function( elem, value ) {
					var name,
					i = 0,

					// Attribute names can contain non-HTML whitespace characters
					// https://html.spec.whatwg.org/multipage/syntax.html#attributes-2
					attrNames = value && value.match( rnothtmlwhite );

					if ( attrNames && elem.nodeType === 1 ) {
					while ( ( name = attrNames[ i++ ] ) ) {
					elem.removeAttribute( name );
					}
					}
					}
					} );

					// Hooks for boolean attributes
					boolHook = {
					set: function( elem, value, name ) {
					if ( value === false ) {

					// Remove boolean attributes when set to false
					jQuery.removeAttr( elem, name );
					} else {
					elem.setAttribute( name, name );
					}
					return name;
					}
					};

					jQuery.each( jQuery.expr.match.bool.source.match( /\w+/g ), function( _i, name ) {
					var getter = attrHandle[ name ] || jQuery.find.attr;

					attrHandle[ name ] = function( elem, name, isXML ) {
					var ret, handle,
					lowercaseName = name.toLowerCase();

					if ( !isXML ) {

					// Avoid an infinite loop by temporarily removing this function from the getter
					handle = attrHandle[ lowercaseName ];
					attrHandle[ lowercaseName ] = ret;
					ret = getter( elem, name, isXML ) != null ?
					lowercaseName :
					null;
					attrHandle[ lowercaseName ] = handle;
					}
					return ret;
					};
					} );


					var rfocusable = /^(?:input|select|textarea|button)$/i,
					rclickable = /^(?:a|area)$/i;

					jQuery.fn.extend( {
					prop: function( name, value ) {
					return access( this, jQuery.prop, name, value, arguments.length > 1 );
					},

					removeProp: function( name ) {
					return this.each( function() {
					delete this[ jQuery.propFix[ name ] || name ];
					} );
					}
					} );

					jQuery.extend( {
					prop: function( elem, name, value ) {
					var ret, hooks,
					nType = elem.nodeType;

					// Don't get/set properties on text, comment and attribute nodes
					if ( nType === 3 || nType === 8 || nType === 2 ) {
					return;
					}

					if ( nType !== 1 || !jQuery.isXMLDoc( elem ) ) {

					// Fix name and attach hooks
					name = jQuery.propFix[ name ] || name;
					hooks = jQuery.propHooks[ name ];
					}

					if ( value !== undefined ) {
					if ( hooks && "set" in hooks &&
					( ret = hooks.set( elem, value, name ) ) !== undefined ) {
					return ret;
					}

					return ( elem[ name ] = value );
					}

					if ( hooks && "get" in hooks && ( ret = hooks.get( elem, name ) ) !== null ) {
					return ret;
					}

					return elem[ name ];
					},

					propHooks: {
					tabIndex: {
					get: function( elem ) {

					// Support: IE <=9 - 11 only
					// elem.tabIndex doesn't always return the
					// correct value when it hasn't been explicitly set
					// Use proper attribute retrieval (trac-12072)
					var tabindex = jQuery.find.attr( elem, "tabindex" );

					if ( tabindex ) {
					return parseInt( tabindex, 10 );
					}

					if (
					rfocusable.test( elem.nodeName ) ||
					rclickable.test( elem.nodeName ) &&
					elem.href
					) {
					return 0;
					}

					return -1;
					}
					}
					},

					propFix: {
					"for": "htmlFor",
					"class": "className"
					}
					} );

					// Support: IE <=11 only
					// Accessing the selectedIndex property
					// forces the browser to respect setting selected
					// on the option
					// The getter ensures a default option is selected
					// when in an optgroup
					// eslint rule "no-unused-expressions" is disabled for this code
					// since it considers such accessions noop
					if ( !support.optSelected ) {
					jQuery.propHooks.selected = {
					get: function( elem ) {

					/* eslint no-unused-expressions: "off" */

					var parent = elem.parentNode;
					if ( parent && parent.parentNode ) {
					parent.parentNode.selectedIndex;
					}
					return null;
					},
					set: function( elem ) {

					/* eslint no-unused-expressions: "off" */

					var parent = elem.parentNode;
					if ( parent ) {
					parent.selectedIndex;

					if ( parent.parentNode ) {
					parent.parentNode.selectedIndex;
					}
					}
					}
					};
					}

					jQuery.each( [
					"tabIndex",
					"readOnly",
					"maxLength",
					"cellSpacing",
					"cellPadding",
					"rowSpan",
					"colSpan",
					"useMap",
					"frameBorder",
					"contentEditable"
					], function() {
					jQuery.propFix[ this.toLowerCase() ] = this;
					} );


					// Strip and collapse whitespace according to HTML spec
					// https://infra.spec.whatwg.org/#strip-and-collapse-ascii-whitespace
					function stripAndCollapse( value ) {
					var tokens = value.match( rnothtmlwhite ) || [];
					return tokens.join( " " );
					}


					function getClass( elem ) {
					return elem.getAttribute && elem.getAttribute( "class" ) || "";
					}

					function classesToArray( value ) {
					if ( Array.isArray( value ) ) {
					return value;
					}
					if ( typeof value === "string" ) {
					return value.match( rnothtmlwhite ) || [];
					}
					return [];
					}

					jQuery.fn.extend( {
					addClass: function( value ) {
					var classNames, cur, curValue, className, i, finalValue;

					if ( isFunction( value ) ) {
					return this.each( function( j ) {
					jQuery( this ).addClass( value.call( this, j, getClass( this ) ) );
					} );
					}

					classNames = classesToArray( value );

					if ( classNames.length ) {
					return this.each( function() {
					curValue = getClass( this );
					cur = this.nodeType === 1 && ( " " + stripAndCollapse( curValue ) + " " );

					if ( cur ) {
					for ( i = 0; i < classNames.length; i++ ) {
					className = classNames[ i ];
					if ( cur.indexOf( " " + className + " " ) < 0 ) {
					cur += className + " ";
					}
					}

					// Only assign if different to avoid unneeded rendering.
					finalValue = stripAndCollapse( cur );
					if ( curValue !== finalValue ) {
					this.setAttribute( "class", finalValue );
					}
					}
					} );
					}

					return this;
					},

					removeClass: function( value ) {
					var classNames, cur, curValue, className, i, finalValue;

					if ( isFunction( value ) ) {
					return this.each( function( j ) {
					jQuery( this ).removeClass( value.call( this, j, getClass( this ) ) );
					} );
					}

					if ( !arguments.length ) {
					return this.attr( "class", "" );
					}

					classNames = classesToArray( value );

					if ( classNames.length ) {
					return this.each( function() {
					curValue = getClass( this );

					// This expression is here for better compressibility (see addClass)
					cur = this.nodeType === 1 && ( " " + stripAndCollapse( curValue ) + " " );

					if ( cur ) {
					for ( i = 0; i < classNames.length; i++ ) {
					className = classNames[ i ];

					// Remove *all* instances
					while ( cur.indexOf( " " + className + " " ) > -1 ) {
					cur = cur.replace( " " + className + " ", " " );
					}
					}

					// Only assign if different to avoid unneeded rendering.
					finalValue = stripAndCollapse( cur );
					if ( curValue !== finalValue ) {
					this.setAttribute( "class", finalValue );
					}
					}
					} );
					}

					return this;
					},

					toggleClass: function( value, stateVal ) {
					var classNames, className, i, self,
					type = typeof value,
					isValidValue = type === "string" || Array.isArray( value );

					if ( isFunction( value ) ) {
					return this.each( function( i ) {
					jQuery( this ).toggleClass(
					value.call( this, i, getClass( this ), stateVal ),
					stateVal
					);
					} );
					}

					if ( typeof stateVal === "boolean" && isValidValue ) {
					return stateVal ? this.addClass( value ) : this.removeClass( value );
					}

					classNames = classesToArray( value );

					return this.each( function() {
					if ( isValidValue ) {

					// Toggle individual class names
					self = jQuery( this );

					for ( i = 0; i < classNames.length; i++ ) {
					className = classNames[ i ];

					// Check each className given, space separated list
					if ( self.hasClass( className ) ) {
					self.removeClass( className );
					} else {
					self.addClass( className );
					}
					}

					// Toggle whole class name
					} else if ( value === undefined || type === "boolean" ) {
					className = getClass( this );
					if ( className ) {

					// Store className if set
					dataPriv.set( this, "__className__", className );
					}

					// If the element has a class name or if we're passed `false`,
					// then remove the whole classname (if there was one, the above saved it).
					// Otherwise bring back whatever was previously saved (if anything),
					// falling back to the empty string if nothing was stored.
					if ( this.setAttribute ) {
					this.setAttribute( "class",
					className || value === false ?
					"" :
					dataPriv.get( this, "__className__" ) || ""
					);
					}
					}
					} );
					},

					hasClass: function( selector ) {
					var className, elem,
					i = 0;

					className = " " + selector + " ";
					while ( ( elem = this[ i++ ] ) ) {
					if ( elem.nodeType === 1 &&
					( " " + stripAndCollapse( getClass( elem ) ) + " " ).indexOf( className ) > -1 ) {
					return true;
					}
					}

					return false;
					}
					} );


					var rreturn = /\r/g;

					jQuery.fn.extend( {
					val: function( value ) {
					var hooks, ret, valueIsFunction,
					elem = this[ 0 ];

					if ( !arguments.length ) {
					if ( elem ) {
					hooks = jQuery.valHooks[ elem.type ] ||
					jQuery.valHooks[ elem.nodeName.toLowerCase() ];

					if ( hooks &&
					"get" in hooks &&
					( ret = hooks.get( elem, "value" ) ) !== undefined
					) {
					return ret;
					}

					ret = elem.value;

					// Handle most common string cases
					if ( typeof ret === "string" ) {
					return ret.replace( rreturn, "" );
					}

					// Handle cases where value is null/undef or number
					return ret == null ? "" : ret;
					}

					return;
					}

					valueIsFunction = isFunction( value );

					return this.each( function( i ) {
					var val;

					if ( this.nodeType !== 1 ) {
					return;
					}

					if ( valueIsFunction ) {
					val = value.call( this, i, jQuery( this ).val() );
					} else {
					val = value;
					}

					// Treat null/undefined as ""; convert numbers to string
					if ( val == null ) {
					val = "";

					} else if ( typeof val === "number" ) {
					val += "";

					} else if ( Array.isArray( val ) ) {
					val = jQuery.map( val, function( value ) {
					return value == null ? "" : value + "";
					} );
					}

					hooks = jQuery.valHooks[ this.type ] || jQuery.valHooks[ this.nodeName.toLowerCase() ];

					// If set returns undefined, fall back to normal setting
					if ( !hooks || !( "set" in hooks ) || hooks.set( this, val, "value" ) === undefined ) {
					this.value = val;
					}
					} );
					}
					} );

					jQuery.extend( {
					valHooks: {
					option: {
					get: function( elem ) {

					var val = jQuery.find.attr( elem, "value" );
					return val != null ?
					val :

					// Support: IE <=10 - 11 only
					// option.text throws exceptions (trac-14686, trac-14858)
					// Strip and collapse whitespace
					// https://html.spec.whatwg.org/#strip-and-collapse-whitespace
					stripAndCollapse( jQuery.text( elem ) );
					}
					},
					select: {
					get: function( elem ) {
					var value, option, i,
					options = elem.options,
					index = elem.selectedIndex,
					one = elem.type === "select-one",
					values = one ? null : [],
					max = one ? index + 1 : options.length;

					if ( index < 0 ) {
					i = max;

					} else {
					i = one ? index : 0;
					}

					// Loop through all the selected options
					for ( ; i < max; i++ ) {
					option = options[ i ];

					// Support: IE <=9 only
					// IE8-9 doesn't update selected after form reset (trac-2551)
					if ( ( option.selected || i === index ) &&

					// Don't return options that are disabled or in a disabled optgroup
					!option.disabled &&
					( !option.parentNode.disabled ||
					!nodeName( option.parentNode, "optgroup" ) ) ) {

					// Get the specific value for the option
					value = jQuery( option ).val();

					// We don't need an array for one selects
					if ( one ) {
					return value;
					}

					// Multi-Selects return an array
					values.push( value );
					}
					}

					return values;
					},

					set: function( elem, value ) {
					var optionSet, option,
					options = elem.options,
					values = jQuery.makeArray( value ),
					i = options.length;

					while ( i-- ) {
					option = options[ i ];

					/* eslint-disable no-cond-assign */

					if ( option.selected =
					jQuery.inArray( jQuery.valHooks.option.get( option ), values ) > -1
					) {
					optionSet = true;
					}

					/* eslint-enable no-cond-assign */
					}

					// Force browsers to behave consistently when non-matching value is set
					if ( !optionSet ) {
					elem.selectedIndex = -1;
					}
					return values;
					}
					}
					}
					} );

					// Radios and checkboxes getter/setter
					jQuery.each( [ "radio", "checkbox" ], function() {
					jQuery.valHooks[ this ] = {
					set: function( elem, value ) {
					if ( Array.isArray( value ) ) {
					return ( elem.checked = jQuery.inArray( jQuery( elem ).val(), value ) > -1 );
					}
					}
					};
					if ( !support.checkOn ) {
					jQuery.valHooks[ this ].get = function( elem ) {
					return elem.getAttribute( "value" ) === null ? "on" : elem.value;
					};
					}
					} );


					// Return jQuery for attributes-only inclusion
					var location = window.location;

					var nonce = { guid: Date.now() };

					var rquery = ( /\?/ );


					// Cross-browser xml parsing
					jQuery.parseXML = function( data ) {
					var xml, parserErrorElem;
					if ( !data || typeof data !== "string" ) {
					return null;
					}

					// Support: IE 9 - 11 only
					// IE throws on parseFromString with invalid input.
					try {
					xml = ( new window.DOMParser() ).parseFromString( data, "text/xml" );
					} catch ( e ) {}

					parserErrorElem = xml && xml.getElementsByTagName( "parsererror" )[ 0 ];
					if ( !xml || parserErrorElem ) {
					jQuery.error( "Invalid XML: " + (
					parserErrorElem ?
					jQuery.map( parserErrorElem.childNodes, function( el ) {
					return el.textContent;
					} ).join( "\n" ) :
					data
					) );
					}
					return xml;
					};


					var rfocusMorph = /^(?:focusinfocus|focusoutblur)$/,
					stopPropagationCallback = function( e ) {
					e.stopPropagation();
					};

					jQuery.extend( jQuery.event, {

					trigger: function( event, data, elem, onlyHandlers ) {

					var i, cur, tmp, bubbleType, ontype, handle, special, lastElement,
					eventPath = [ elem || document ],
					type = hasOwn.call( event, "type" ) ? event.type : event,
					namespaces = hasOwn.call( event, "namespace" ) ? event.namespace.split( "." ) : [];

					cur = lastElement = tmp = elem = elem || document;

					// Don't do events on text and comment nodes
					if ( elem.nodeType === 3 || elem.nodeType === 8 ) {
					return;
					}

					// focus/blur morphs to focusin/out; ensure we're not firing them right now
					if ( rfocusMorph.test( type + jQuery.event.triggered ) ) {
					return;
					}

					if ( type.indexOf( "." ) > -1 ) {

					// Namespaced trigger; create a regexp to match event type in handle()
					namespaces = type.split( "." );
					type = namespaces.shift();
					namespaces.sort();
					}
					ontype = type.indexOf( ":" ) < 0 && "on" + type;

					// Caller can pass in a jQuery.Event object, Object, or just an event type string
					event = event[ jQuery.expando ] ?
					event :
					new jQuery.Event( type, typeof event === "object" && event );

					// Trigger bitmask: & 1 for native handlers; & 2 for jQuery (always true)
					event.isTrigger = onlyHandlers ? 2 : 3;
					event.namespace = namespaces.join( "." );
					event.rnamespace = event.namespace ?
					new RegExp( "(^|\\.)" + namespaces.join( "\\.(?:.*\\.|)" ) + "(\\.|$)" ) :
					null;

					// Clean up the event in case it is being reused
					event.result = undefined;
					if ( !event.target ) {
					event.target = elem;
					}

					// Clone any incoming data and prepend the event, creating the handler arg list
					data = data == null ?
					[ event ] :
					jQuery.makeArray( data, [ event ] );

					// Allow special events to draw outside the lines
					special = jQuery.event.special[ type ] || {};
					if ( !onlyHandlers && special.trigger && special.trigger.apply( elem, data ) === false ) {
					return;
					}

					// Determine event propagation path in advance, per W3C events spec (trac-9951)
					// Bubble up to document, then to window; watch for a global ownerDocument var (trac-9724)
					if ( !onlyHandlers && !special.noBubble && !isWindow( elem ) ) {

					bubbleType = special.delegateType || type;
					if ( !rfocusMorph.test( bubbleType + type ) ) {
					cur = cur.parentNode;
					}
					for ( ; cur; cur = cur.parentNode ) {
					eventPath.push( cur );
					tmp = cur;
					}

					// Only add window if we got to document (e.g., not plain obj or detached DOM)
					if ( tmp === ( elem.ownerDocument || document ) ) {
					eventPath.push( tmp.defaultView || tmp.parentWindow || window );
					}
					}

					// Fire handlers on the event path
					i = 0;
					while ( ( cur = eventPath[ i++ ] ) && !event.isPropagationStopped() ) {
					lastElement = cur;
					event.type = i > 1 ?
					bubbleType :
					special.bindType || type;

					// jQuery handler
					handle = ( dataPriv.get( cur, "events" ) || Object.create( null ) )[ event.type ] &&
					dataPriv.get( cur, "handle" );
					if ( handle ) {
					handle.apply( cur, data );
					}

					// Native handler
					handle = ontype && cur[ ontype ];
					if ( handle && handle.apply && acceptData( cur ) ) {
					event.result = handle.apply( cur, data );
					if ( event.result === false ) {
					event.preventDefault();
					}
					}
					}
					event.type = type;

					// If nobody prevented the default action, do it now
					if ( !onlyHandlers && !event.isDefaultPrevented() ) {

					if ( ( !special._default ||
					special._default.apply( eventPath.pop(), data ) === false ) &&
					acceptData( elem ) ) {

					// Call a native DOM method on the target with the same name as the event.
					// Don't do default actions on window, that's where global variables be (trac-6170)
					if ( ontype && isFunction( elem[ type ] ) && !isWindow( elem ) ) {

					// Don't re-trigger an onFOO event when we call its FOO() method
					tmp = elem[ ontype ];

					if ( tmp ) {
					elem[ ontype ] = null;
					}

					// Prevent re-triggering of the same event, since we already bubbled it above
					jQuery.event.triggered = type;

					if ( event.isPropagationStopped() ) {
					lastElement.addEventListener( type, stopPropagationCallback );
					}

					elem[ type ]();

					if ( event.isPropagationStopped() ) {
					lastElement.removeEventListener( type, stopPropagationCallback );
					}

					jQuery.event.triggered = undefined;

					if ( tmp ) {
					elem[ ontype ] = tmp;
					}
					}
					}
					}

					return event.result;
					},

					// Piggyback on a donor event to simulate a different one
					// Used only for `focus(in | out)` events
					simulate: function( type, elem, event ) {
					var e = jQuery.extend(
					new jQuery.Event(),
					event,
					{
					type: type,
					isSimulated: true
					}
					);

					jQuery.event.trigger( e, null, elem );
					}

					} );

					jQuery.fn.extend( {

					trigger: function( type, data ) {
					return this.each( function() {
					jQuery.event.trigger( type, data, this );
					} );
					},
					triggerHandler: function( type, data ) {
					var elem = this[ 0 ];
					if ( elem ) {
					return jQuery.event.trigger( type, data, elem, true );
					}
					}
					} );


					var
					rbracket = /\[\]$/,
					rCRLF = /\r?\n/g,
					rsubmitterTypes = /^(?:submit|button|image|reset|file)$/i,
					rsubmittable = /^(?:input|select|textarea|keygen)/i;

					function buildParams( prefix, obj, traditional, add ) {
					var name;

					if ( Array.isArray( obj ) ) {

					// Serialize array item.
					jQuery.each( obj, function( i, v ) {
					if ( traditional || rbracket.test( prefix ) ) {

					// Treat each array item as a scalar.
					add( prefix, v );

					} else {

					// Item is non-scalar (array or object), encode its numeric index.
					buildParams(
					prefix + "[" + ( typeof v === "object" && v != null ? i : "" ) + "]",
					v,
					traditional,
					add
					);
					}
					} );

					} else if ( !traditional && toType( obj ) === "object" ) {

					// Serialize object item.
					for ( name in obj ) {
					buildParams( prefix + "[" + name + "]", obj[ name ], traditional, add );
					}

					} else {

					// Serialize scalar item.
					add( prefix, obj );
					}
					}

					// Serialize an array of form elements or a set of
					// key/values into a query string
					jQuery.param = function( a, traditional ) {
					var prefix,
					s = [],
					add = function( key, valueOrFunction ) {

					// If value is a function, invoke it and use its return value
					var value = isFunction( valueOrFunction ) ?
					valueOrFunction() :
					valueOrFunction;

					s[ s.length ] = encodeURIComponent( key ) + "=" +
					encodeURIComponent( value == null ? "" : value );
					};

					if ( a == null ) {
					return "";
					}

					// If an array was passed in, assume that it is an array of form elements.
					if ( Array.isArray( a ) || ( a.jquery && !jQuery.isPlainObject( a ) ) ) {

					// Serialize the form elements
					jQuery.each( a, function() {
					add( this.name, this.value );
					} );

					} else {

					// If traditional, encode the "old" way (the way 1.3.2 or older
					// did it), otherwise encode params recursively.
					for ( prefix in a ) {
					buildParams( prefix, a[ prefix ], traditional, add );
					}
					}

					// Return the resulting serialization
					return s.join( "&" );
					};

					jQuery.fn.extend( {
					serialize: function() {
					return jQuery.param( this.serializeArray() );
					},
					serializeArray: function() {
					return this.map( function() {

					// Can add propHook for "elements" to filter or add form elements
					var elements = jQuery.prop( this, "elements" );
					return elements ? jQuery.makeArray( elements ) : this;
					} ).filter( function() {
					var type = this.type;

					// Use .is( ":disabled" ) so that fieldset[disabled] works
					return this.name && !jQuery( this ).is( ":disabled" ) &&
					rsubmittable.test( this.nodeName ) && !rsubmitterTypes.test( type ) &&
					( this.checked || !rcheckableType.test( type ) );
					} ).map( function( _i, elem ) {
					var val = jQuery( this ).val();

					if ( val == null ) {
					return null;
					}

					if ( Array.isArray( val ) ) {
					return jQuery.map( val, function( val ) {
					return { name: elem.name, value: val.replace( rCRLF, "\r\n" ) };
					} );
					}

					return { name: elem.name, value: val.replace( rCRLF, "\r\n" ) };
					} ).get();
					}
					} );


					var
					r20 = /%20/g,
					rhash = /#.*$/,
					rantiCache = /([?&])_=[^&]*/,
					rheaders = /^(.*?):[ \t]*([^\r\n]*)$/mg,

					// trac-7653, trac-8125, trac-8152: local protocol detection
					rlocalProtocol = /^(?:about|app|app-storage|.+-extension|file|res|widget):$/,
					rnoContent = /^(?:GET|HEAD)$/,
					rprotocol = /^\/\//,

					/* Prefilters
					* 1) They are useful to introduce custom dataTypes (see ajax/jsonp.js for an example)
					* 2) These are called:
					* - BEFORE asking for a transport
					* - AFTER param serialization (s.data is a string if s.processData is true)
					* 3) key is the dataType
					* 4) the catchall symbol "*" can be used
					* 5) execution will start with transport dataType and THEN continue down to "*" if needed
					*/
					prefilters = {},

					/* Transports bindings
					* 1) key is the dataType
					* 2) the catchall symbol "*" can be used
					* 3) selection will start with transport dataType and THEN go to "*" if needed
					*/
					transports = {},

					// Avoid comment-prolog char sequence (trac-10098); must appease lint and evade compression
					allTypes = "*/".concat( "*" ),

					// Anchor tag for parsing the document origin
					originAnchor = document.createElement( "a" );

					originAnchor.href = location.href;

					// Base "constructor" for jQuery.ajaxPrefilter and jQuery.ajaxTransport
					function addToPrefiltersOrTransports( structure ) {

					// dataTypeExpression is optional and defaults to "*"
					return function( dataTypeExpression, func ) {

					if ( typeof dataTypeExpression !== "string" ) {
					func = dataTypeExpression;
					dataTypeExpression = "*";
					}

					var dataType,
					i = 0,
					dataTypes = dataTypeExpression.toLowerCase().match( rnothtmlwhite ) || [];

					if ( isFunction( func ) ) {

					// For each dataType in the dataTypeExpression
					while ( ( dataType = dataTypes[ i++ ] ) ) {

					// Prepend if requested
					if ( dataType[ 0 ] === "+" ) {
					dataType = dataType.slice( 1 ) || "*";
					( structure[ dataType ] = structure[ dataType ] || [] ).unshift( func );

					// Otherwise append
					} else {
					( structure[ dataType ] = structure[ dataType ] || [] ).push( func );
					}
					}
					}
					};
					}

					// Base inspection function for prefilters and transports
					function inspectPrefiltersOrTransports( structure, options, originalOptions, jqXHR ) {

					var inspected = {},
					seekingTransport = ( structure === transports );

					function inspect( dataType ) {
					var selected;
					inspected[ dataType ] = true;
					jQuery.each( structure[ dataType ] || [], function( _, prefilterOrFactory ) {
					var dataTypeOrTransport = prefilterOrFactory( options, originalOptions, jqXHR );
					if ( typeof dataTypeOrTransport === "string" &&
					!seekingTransport && !inspected[ dataTypeOrTransport ] ) {

					options.dataTypes.unshift( dataTypeOrTransport );
					inspect( dataTypeOrTransport );
					return false;
					} else if ( seekingTransport ) {
					return !( selected = dataTypeOrTransport );
					}
					} );
					return selected;
					}

					return inspect( options.dataTypes[ 0 ] ) || !inspected[ "*" ] && inspect( "*" );
					}

					// A special extend for ajax options
					// that takes "flat" options (not to be deep extended)
					// Fixes trac-9887
					function ajaxExtend( target, src ) {
					var key, deep,
					flatOptions = jQuery.ajaxSettings.flatOptions || {};

					for ( key in src ) {
					if ( src[ key ] !== undefined ) {
					( flatOptions[ key ] ? target : ( deep || ( deep = {} ) ) )[ key ] = src[ key ];
					}
					}
					if ( deep ) {
					jQuery.extend( true, target, deep );
					}

					return target;
					}

					/* Handles responses to an ajax request:
					* - finds the right dataType (mediates between content-type and expected dataType)
					* - returns the corresponding response
					*/
					function ajaxHandleResponses( s, jqXHR, responses ) {

					var ct, type, finalDataType, firstDataType,
					contents = s.contents,
					dataTypes = s.dataTypes;

					// Remove auto dataType and get content-type in the process
					while ( dataTypes[ 0 ] === "*" ) {
					dataTypes.shift();
					if ( ct === undefined ) {
					ct = s.mimeType || jqXHR.getResponseHeader( "Content-Type" );
					}
					}

					// Check if we're dealing with a known content-type
					if ( ct ) {
					for ( type in contents ) {
					if ( contents[ type ] && contents[ type ].test( ct ) ) {
					dataTypes.unshift( type );
					break;
					}
					}
					}

					// Check to see if we have a response for the expected dataType
					if ( dataTypes[ 0 ] in responses ) {
					finalDataType = dataTypes[ 0 ];
					} else {

					// Try convertible dataTypes
					for ( type in responses ) {
					if ( !dataTypes[ 0 ] || s.converters[ type + " " + dataTypes[ 0 ] ] ) {
					finalDataType = type;
					break;
					}
					if ( !firstDataType ) {
					firstDataType = type;
					}
					}

					// Or just use first one
					finalDataType = finalDataType || firstDataType;
					}

					// If we found a dataType
					// We add the dataType to the list if needed
					// and return the corresponding response
					if ( finalDataType ) {
					if ( finalDataType !== dataTypes[ 0 ] ) {
					dataTypes.unshift( finalDataType );
					}
					return responses[ finalDataType ];
					}
					}

					/* Chain conversions given the request and the original response
					* Also sets the responseXXX fields on the jqXHR instance
					*/
					function ajaxConvert( s, response, jqXHR, isSuccess ) {
					var conv2, current, conv, tmp, prev,
					converters = {},

					// Work with a copy of dataTypes in case we need to modify it for conversion
					dataTypes = s.dataTypes.slice();

					// Create converters map with lowercased keys
					if ( dataTypes[ 1 ] ) {
					for ( conv in s.converters ) {
					converters[ conv.toLowerCase() ] = s.converters[ conv ];
					}
					}

					current = dataTypes.shift();

					// Convert to each sequential dataType
					while ( current ) {

					if ( s.responseFields[ current ] ) {
					jqXHR[ s.responseFields[ current ] ] = response;
					}

					// Apply the dataFilter if provided
					if ( !prev && isSuccess && s.dataFilter ) {
					response = s.dataFilter( response, s.dataType );
					}

					prev = current;
					current = dataTypes.shift();

					if ( current ) {

					// There's only work to do if current dataType is non-auto
					if ( current === "*" ) {

					current = prev;

					// Convert response if prev dataType is non-auto and differs from current
					} else if ( prev !== "*" && prev !== current ) {

					// Seek a direct converter
					conv = converters[ prev + " " + current ] || converters[ "* " + current ];

					// If none found, seek a pair
					if ( !conv ) {
					for ( conv2 in converters ) {

					// If conv2 outputs current
					tmp = conv2.split( " " );
					if ( tmp[ 1 ] === current ) {

					// If prev can be converted to accepted input
					conv = converters[ prev + " " + tmp[ 0 ] ] ||
					converters[ "* " + tmp[ 0 ] ];
					if ( conv ) {

					// Condense equivalence converters
					if ( conv === true ) {
					conv = converters[ conv2 ];

					// Otherwise, insert the intermediate dataType
					} else if ( converters[ conv2 ] !== true ) {
					current = tmp[ 0 ];
					dataTypes.unshift( tmp[ 1 ] );
					}
					break;
					}
					}
					}
					}

					// Apply converter (if not an equivalence)
					if ( conv !== true ) {

					// Unless errors are allowed to bubble, catch and return them
					if ( conv && s.throws ) {
					response = conv( response );
					} else {
					try {
					response = conv( response );
					} catch ( e ) {
					return {
					state: "parsererror",
					error: conv ? e : "No conversion from " + prev + " to " + current
					};
					}
					}
					}
					}
					}
					}

					return { state: "success", data: response };
					}

					jQuery.extend( {

					// Counter for holding the number of active queries
					active: 0,

					// Last-Modified header cache for next request
					lastModified: {},
					etag: {},

					ajaxSettings: {
					url: location.href,
					type: "GET",
					isLocal: rlocalProtocol.test( location.protocol ),
					global: true,
					processData: true,
					async: true,
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",

					/*
					timeout: 0,
					data: null,
					dataType: null,
					username: null,
					password: null,
					cache: null,
					throws: false,
					traditional: false,
					headers: {},
					*/

					accepts: {
					"*": allTypes,
					text: "text/plain",
					html: "text/html",
					xml: "application/xml, text/xml",
					json: "application/json, text/javascript"
					},

					contents: {
					xml: /\bxml\b/,
					html: /\bhtml/,
					json: /\bjson\b/
					},

					responseFields: {
					xml: "responseXML",
					text: "responseText",
					json: "responseJSON"
					},

					// Data converters
					// Keys separate source (or catchall "*") and destination types with a single space
					converters: {

					// Convert anything to text
					"* text": String,

					// Text to html (true = no transformation)
					"text html": true,

					// Evaluate text as a json expression
					"text json": JSON.parse,

					// Parse text as xml
					"text xml": jQuery.parseXML
					},

					// For options that shouldn't be deep extended:
					// you can add your own custom options here if
					// and when you create one that shouldn't be
					// deep extended (see ajaxExtend)
					flatOptions: {
					url: true,
					context: true
					}
					},

					// Creates a full fledged settings object into target
					// with both ajaxSettings and settings fields.
					// If target is omitted, writes into ajaxSettings.
					ajaxSetup: function( target, settings ) {
					return settings ?

					// Building a settings object
					ajaxExtend( ajaxExtend( target, jQuery.ajaxSettings ), settings ) :

					// Extending ajaxSettings
					ajaxExtend( jQuery.ajaxSettings, target );
					},

					ajaxPrefilter: addToPrefiltersOrTransports( prefilters ),
					ajaxTransport: addToPrefiltersOrTransports( transports ),

					// Main method
					ajax: function( url, options ) {

					// If url is an object, simulate pre-1.5 signature
					if ( typeof url === "object" ) {
					options = url;
					url = undefined;
					}

					// Force options to be an object
					options = options || {};

					var transport,

					// URL without anti-cache param
					cacheURL,

					// Response headers
					responseHeadersString,
					responseHeaders,

					// timeout handle
					timeoutTimer,

					// Url cleanup var
					urlAnchor,

					// Request state (becomes false upon send and true upon completion)
					completed,

					// To know if global events are to be dispatched
					fireGlobals,

					// Loop variable
					i,

					// uncached part of the url
					uncached,

					// Create the final options object
					s = jQuery.ajaxSetup( {}, options ),

					// Callbacks context
					callbackContext = s.context || s,

					// Context for global events is callbackContext if it is a DOM node or jQuery collection
					globalEventContext = s.context &&
					( callbackContext.nodeType || callbackContext.jquery ) ?
					jQuery( callbackContext ) :
					jQuery.event,

					// Deferreds
					deferred = jQuery.Deferred(),
					completeDeferred = jQuery.Callbacks( "once memory" ),

					// Status-dependent callbacks
					statusCode = s.statusCode || {},

					// Headers (they are sent all at once)
					requestHeaders = {},
					requestHeadersNames = {},

					// Default abort message
					strAbort = "canceled",

					// Fake xhr
					jqXHR = {
					readyState: 0,

					// Builds headers hashtable if needed
					getResponseHeader: function( key ) {
					var match;
					if ( completed ) {
					if ( !responseHeaders ) {
					responseHeaders = {};
					while ( ( match = rheaders.exec( responseHeadersString ) ) ) {
					responseHeaders[ match[ 1 ].toLowerCase() + " " ] =
					( responseHeaders[ match[ 1 ].toLowerCase() + " " ] || [] )
					.concat( match[ 2 ] );
					}
					}
					match = responseHeaders[ key.toLowerCase() + " " ];
					}
					return match == null ? null : match.join( ", " );
					},

					// Raw string
					getAllResponseHeaders: function() {
					return completed ? responseHeadersString : null;
					},

					// Caches the header
					setRequestHeader: function( name, value ) {
					if ( completed == null ) {
					name = requestHeadersNames[ name.toLowerCase() ] =
					requestHeadersNames[ name.toLowerCase() ] || name;
					requestHeaders[ name ] = value;
					}
					return this;
					},

					// Overrides response content-type header
					overrideMimeType: function( type ) {
					if ( completed == null ) {
					s.mimeType = type;
					}
					return this;
					},

					// Status-dependent callbacks
					statusCode: function( map ) {
					var code;
					if ( map ) {
					if ( completed ) {

					// Execute the appropriate callbacks
					jqXHR.always( map[ jqXHR.status ] );
					} else {

					// Lazy-add the new callbacks in a way that preserves old ones
					for ( code in map ) {
					statusCode[ code ] = [ statusCode[ code ], map[ code ] ];
					}
					}
					}
					return this;
					},

					// Cancel the request
					abort: function( statusText ) {
					var finalText = statusText || strAbort;
					if ( transport ) {
					transport.abort( finalText );
					}
					done( 0, finalText );
					return this;
					}
					};

					// Attach deferreds
					deferred.promise( jqXHR );

					// Add protocol if not provided (prefilters might expect it)
					// Handle falsy url in the settings object (trac-10093: consistency with old signature)
					// We also use the url parameter if available
					s.url = ( ( url || s.url || location.href ) + "" )
					.replace( rprotocol, location.protocol + "//" );

					// Alias method option to type as per ticket trac-12004
					s.type = options.method || options.type || s.method || s.type;

					// Extract dataTypes list
					s.dataTypes = ( s.dataType || "*" ).toLowerCase().match( rnothtmlwhite ) || [ "" ];

					// A cross-domain request is in order when the origin doesn't match the current origin.
					if ( s.crossDomain == null ) {
					urlAnchor = document.createElement( "a" );

					// Support: IE <=8 - 11, Edge 12 - 15
					// IE throws exception on accessing the href property if url is malformed,
					// e.g. http://example.com:80x/
					try {
					urlAnchor.href = s.url;

					// Support: IE <=8 - 11 only
					// Anchor's host property isn't correctly set when s.url is relative
					urlAnchor.href = urlAnchor.href;
					s.crossDomain = originAnchor.protocol + "//" + originAnchor.host !==
					urlAnchor.protocol + "//" + urlAnchor.host;
					} catch ( e ) {

					// If there is an error parsing the URL, assume it is crossDomain,
					// it can be rejected by the transport if it is invalid
					s.crossDomain = true;
					}
					}

					// Convert data if not already a string
					if ( s.data && s.processData && typeof s.data !== "string" ) {
					s.data = jQuery.param( s.data, s.traditional );
					}

					// Apply prefilters
					inspectPrefiltersOrTransports( prefilters, s, options, jqXHR );

					// If request was aborted inside a prefilter, stop there
					if ( completed ) {
					return jqXHR;
					}

					// We can fire global events as of now if asked to
					// Don't fire events if jQuery.event is undefined in an AMD-usage scenario (trac-15118)
					fireGlobals = jQuery.event && s.global;

					// Watch for a new set of requests
					if ( fireGlobals && jQuery.active++ === 0 ) {
					jQuery.event.trigger( "ajaxStart" );
					}

					// Uppercase the type
					s.type = s.type.toUpperCase();

					// Determine if request has content
					s.hasContent = !rnoContent.test( s.type );

					// Save the URL in case we're toying with the If-Modified-Since
					// and/or If-None-Match header later on
					// Remove hash to simplify url manipulation
					cacheURL = s.url.replace( rhash, "" );

					// More options handling for requests with no content
					if ( !s.hasContent ) {

					// Remember the hash so we can put it back
					uncached = s.url.slice( cacheURL.length );

					// If data is available and should be processed, append data to url
					if ( s.data && ( s.processData || typeof s.data === "string" ) ) {
					cacheURL += ( rquery.test( cacheURL ) ? "&" : "?" ) + s.data;

					// trac-9682: remove data so that it's not used in an eventual retry
					delete s.data;
					}

					// Add or update anti-cache param if needed
					if ( s.cache === false ) {
					cacheURL = cacheURL.replace( rantiCache, "$1" );
					uncached = ( rquery.test( cacheURL ) ? "&" : "?" ) + "_=" + ( nonce.guid++ ) +
					uncached;
					}

					// Put hash and anti-cache on the URL that will be requested (gh-1732)
					s.url = cacheURL + uncached;

					// Change '%20' to '+' if this is encoded form body content (gh-2658)
					} else if ( s.data && s.processData &&
					( s.contentType || "" ).indexOf( "application/x-www-form-urlencoded" ) === 0 ) {
					s.data = s.data.replace( r20, "+" );
					}

					// Set the If-Modified-Since and/or If-None-Match header, if in ifModified mode.
					if ( s.ifModified ) {
					if ( jQuery.lastModified[ cacheURL ] ) {
					jqXHR.setRequestHeader( "If-Modified-Since", jQuery.lastModified[ cacheURL ] );
					}
					if ( jQuery.etag[ cacheURL ] ) {
					jqXHR.setRequestHeader( "If-None-Match", jQuery.etag[ cacheURL ] );
					}
					}

					// Set the correct header, if data is being sent
					if ( s.data && s.hasContent && s.contentType !== false || options.contentType ) {
					jqXHR.setRequestHeader( "Content-Type", s.contentType );
					}

					// Set the Accepts header for the server, depending on the dataType
					jqXHR.setRequestHeader(
					"Accept",
					s.dataTypes[ 0 ] && s.accepts[ s.dataTypes[ 0 ] ] ?
					s.accepts[ s.dataTypes[ 0 ] ] +
					( s.dataTypes[ 0 ] !== "*" ? ", " + allTypes + "; q=0.01" : "" ) :
					s.accepts[ "*" ]
					);

					// Check for headers option
					for ( i in s.headers ) {
					jqXHR.setRequestHeader( i, s.headers[ i ] );
					}

					// Allow custom headers/mimetypes and early abort
					if ( s.beforeSend &&
					( s.beforeSend.call( callbackContext, jqXHR, s ) === false || completed ) ) {

					// Abort if not done already and return
					return jqXHR.abort();
					}

					// Aborting is no longer a cancellation
					strAbort = "abort";

					// Install callbacks on deferreds
					completeDeferred.add( s.complete );
					jqXHR.done( s.success );
					jqXHR.fail( s.error );

					// Get transport
					transport = inspectPrefiltersOrTransports( transports, s, options, jqXHR );

					// If no transport, we auto-abort
					if ( !transport ) {
					done( -1, "No Transport" );
					} else {
					jqXHR.readyState = 1;

					// Send global event
					if ( fireGlobals ) {
					globalEventContext.trigger( "ajaxSend", [ jqXHR, s ] );
					}

					// If request was aborted inside ajaxSend, stop there
					if ( completed ) {
					return jqXHR;
					}

					// Timeout
					if ( s.async && s.timeout > 0 ) {
					timeoutTimer = window.setTimeout( function() {
					jqXHR.abort( "timeout" );
					}, s.timeout );
					}

					try {
					completed = false;
					transport.send( requestHeaders, done );
					} catch ( e ) {

					// Rethrow post-completion exceptions
					if ( completed ) {
					throw e;
					}

					// Propagate others as results
					done( -1, e );
					}
					}

					// Callback for when everything is done
					function done( status, nativeStatusText, responses, headers ) {
					var isSuccess, success, error, response, modified,
					statusText = nativeStatusText;

					// Ignore repeat invocations
					if ( completed ) {
					return;
					}

					completed = true;

					// Clear timeout if it exists
					if ( timeoutTimer ) {
					window.clearTimeout( timeoutTimer );
					}

					// Dereference transport for early garbage collection
					// (no matter how long the jqXHR object will be used)
					transport = undefined;

					// Cache response headers
					responseHeadersString = headers || "";

					// Set readyState
					jqXHR.readyState = status > 0 ? 4 : 0;

					// Determine if successful
					isSuccess = status >= 200 && status < 300 || status === 304;

					// Get response data
					if ( responses ) {
					response = ajaxHandleResponses( s, jqXHR, responses );
					}

					// Use a noop converter for missing script but not if jsonp
					if ( !isSuccess &&
					jQuery.inArray( "script", s.dataTypes ) > -1 &&
					jQuery.inArray( "json", s.dataTypes ) < 0 ) {
					s.converters[ "text script" ] = function() {};
					}

					// Convert no matter what (that way responseXXX fields are always set)
					response = ajaxConvert( s, response, jqXHR, isSuccess );

					// If successful, handle type chaining
					if ( isSuccess ) {

					// Set the If-Modified-Since and/or If-None-Match header, if in ifModified mode.
					if ( s.ifModified ) {
					modified = jqXHR.getResponseHeader( "Last-Modified" );
					if ( modified ) {
					jQuery.lastModified[ cacheURL ] = modified;
					}
					modified = jqXHR.getResponseHeader( "etag" );
					if ( modified ) {
					jQuery.etag[ cacheURL ] = modified;
					}
					}

					// if no content
					if ( status === 204 || s.type === "HEAD" ) {
					statusText = "nocontent";

					// if not modified
					} else if ( status === 304 ) {
					statusText = "notmodified";

					// If we have data, let's convert it
					} else {
					statusText = response.state;
					success = response.data;
					error = response.error;
					isSuccess = !error;
					}
					} else {

					// Extract error from statusText and normalize for non-aborts
					error = statusText;
					if ( status || !statusText ) {
					statusText = "error";
					if ( status < 0 ) {
					status = 0;
					}
					}
					}

					// Set data for the fake xhr object
					jqXHR.status = status;
					jqXHR.statusText = ( nativeStatusText || statusText ) + "";

					// Success/Error
					if ( isSuccess ) {
					deferred.resolveWith( callbackContext, [ success, statusText, jqXHR ] );
					} else {
					deferred.rejectWith( callbackContext, [ jqXHR, statusText, error ] );
					}

					// Status-dependent callbacks
					jqXHR.statusCode( statusCode );
					statusCode = undefined;

					if ( fireGlobals ) {
					globalEventContext.trigger( isSuccess ? "ajaxSuccess" : "ajaxError",
					[ jqXHR, s, isSuccess ? success : error ] );
					}

					// Complete
					completeDeferred.fireWith( callbackContext, [ jqXHR, statusText ] );

					if ( fireGlobals ) {
					globalEventContext.trigger( "ajaxComplete", [ jqXHR, s ] );

					// Handle the global AJAX counter
					if ( !( --jQuery.active ) ) {
					jQuery.event.trigger( "ajaxStop" );
					}
					}
					}

					return jqXHR;
					},

					getJSON: function( url, data, callback ) {
					return jQuery.get( url, data, callback, "json" );
					},

					getScript: function( url, callback ) {
					return jQuery.get( url, undefined, callback, "script" );
					}
					} );

					jQuery.each( [ "get", "post" ], function( _i, method ) {
					jQuery[ method ] = function( url, data, callback, type ) {

					// Shift arguments if data argument was omitted
					if ( isFunction( data ) ) {
					type = type || callback;
					callback = data;
					data = undefined;
					}

					// The url can be an options object (which then must have .url)
					return jQuery.ajax( jQuery.extend( {
					url: url,
					type: method,
					dataType: type,
					data: data,
					success: callback
					}, jQuery.isPlainObject( url ) && url ) );
					};
					} );

					jQuery.ajaxPrefilter( function( s ) {
					var i;
					for ( i in s.headers ) {
					if ( i.toLowerCase() === "content-type" ) {
					s.contentType = s.headers[ i ] || "";
					}
					}
					} );


					jQuery._evalUrl = function( url, options, doc ) {
					return jQuery.ajax( {
					url: url,

					// Make this explicit, since user can override this through ajaxSetup (trac-11264)
					type: "GET",
					dataType: "script",
					cache: true,
					async: false,
					global: false,

					// Only evaluate the response if it is successful (gh-4126)
					// dataFilter is not invoked for failure responses, so using it instead
					// of the default converter is kludgy but it works.
					converters: {
					"text script": function() {}
					},
					dataFilter: function( response ) {
					jQuery.globalEval( response, options, doc );
					}
					} );
					};


					jQuery.fn.extend( {
					wrapAll: function( html ) {
					var wrap;

					if ( this[ 0 ] ) {
					if ( isFunction( html ) ) {
					html = html.call( this[ 0 ] );
					}

					// The elements to wrap the target around
					wrap = jQuery( html, this[ 0 ].ownerDocument ).eq( 0 ).clone( true );

					if ( this[ 0 ].parentNode ) {
					wrap.insertBefore( this[ 0 ] );
					}

					wrap.map( function() {
					var elem = this;

					while ( elem.firstElementChild ) {
					elem = elem.firstElementChild;
					}

					return elem;
					} ).append( this );
					}

					return this;
					},

					wrapInner: function( html ) {
					if ( isFunction( html ) ) {
					return this.each( function( i ) {
					jQuery( this ).wrapInner( html.call( this, i ) );
					} );
					}

					return this.each( function() {
					var self = jQuery( this ),
					contents = self.contents();

					if ( contents.length ) {
					contents.wrapAll( html );

					} else {
					self.append( html );
					}
					} );
					},

					wrap: function( html ) {
					var htmlIsFunction = isFunction( html );

					return this.each( function( i ) {
					jQuery( this ).wrapAll( htmlIsFunction ? html.call( this, i ) : html );
					} );
					},

					unwrap: function( selector ) {
					this.parent( selector ).not( "body" ).each( function() {
					jQuery( this ).replaceWith( this.childNodes );
					} );
					return this;
					}
					} );


					jQuery.expr.pseudos.hidden = function( elem ) {
					return !jQuery.expr.pseudos.visible( elem );
					};
					jQuery.expr.pseudos.visible = function( elem ) {
					return !!( elem.offsetWidth || elem.offsetHeight || elem.getClientRects().length );
					};


					jQuery.ajaxSettings.xhr = function() {
					try {
					return new window.XMLHttpRequest();
					} catch ( e ) {}
					};

					var xhrSuccessStatus = {

					// File protocol always yields status code 0, assume 200
					0: 200,

					// Support: IE <=9 only
					// trac-1450: sometimes IE returns 1223 when it should be 204
					1223: 204
					},
					xhrSupported = jQuery.ajaxSettings.xhr();

					support.cors = !!xhrSupported && ( "withCredentials" in xhrSupported );
					support.ajax = xhrSupported = !!xhrSupported;

					jQuery.ajaxTransport( function( options ) {
					var callback, errorCallback;

					// Cross domain only allowed if supported through XMLHttpRequest
					if ( support.cors || xhrSupported && !options.crossDomain ) {
					return {
					send: function( headers, complete ) {
					var i,
					xhr = options.xhr();

					xhr.open(
					options.type,
					options.url,
					options.async,
					options.username,
					options.password
					);

					// Apply custom fields if provided
					if ( options.xhrFields ) {
					for ( i in options.xhrFields ) {
					xhr[ i ] = options.xhrFields[ i ];
					}
					}

					// Override mime type if needed
					if ( options.mimeType && xhr.overrideMimeType ) {
					xhr.overrideMimeType( options.mimeType );
					}

					// X-Requested-With header
					// For cross-domain requests, seeing as conditions for a preflight are
					// akin to a jigsaw puzzle, we simply never set it to be sure.
					// (it can always be set on a per-request basis or even using ajaxSetup)
					// For same-domain requests, won't change header if already provided.
					if ( !options.crossDomain && !headers[ "X-Requested-With" ] ) {
					headers[ "X-Requested-With" ] = "XMLHttpRequest";
					}

					// Set headers
					for ( i in headers ) {
					xhr.setRequestHeader( i, headers[ i ] );
					}

					// Callback
					callback = function( type ) {
					return function() {
					if ( callback ) {
					callback = errorCallback = xhr.onload =
					xhr.onerror = xhr.onabort = xhr.ontimeout =
					xhr.onreadystatechange = null;

					if ( type === "abort" ) {
					xhr.abort();
					} else if ( type === "error" ) {

					// Support: IE <=9 only
					// On a manual native abort, IE9 throws
					// errors on any property access that is not readyState
					if ( typeof xhr.status !== "number" ) {
					complete( 0, "error" );
					} else {
					complete(

					// File: protocol always yields status 0; see trac-8605, trac-14207
					xhr.status,
					xhr.statusText
					);
					}
					} else {
					complete(
					xhrSuccessStatus[ xhr.status ] || xhr.status,
					xhr.statusText,

					// Support: IE <=9 only
					// IE9 has no XHR2 but throws on binary (trac-11426)
					// For XHR2 non-text, let the caller handle it (gh-2498)
					( xhr.responseType || "text" ) !== "text" ||
					typeof xhr.responseText !== "string" ?
					{ binary: xhr.response } :
					{ text: xhr.responseText },
					xhr.getAllResponseHeaders()
					);
					}
					}
					};
					};

					// Listen to events
					xhr.onload = callback();
					errorCallback = xhr.onerror = xhr.ontimeout = callback( "error" );

					// Support: IE 9 only
					// Use onreadystatechange to replace onabort
					// to handle uncaught aborts
					if ( xhr.onabort !== undefined ) {
					xhr.onabort = errorCallback;
					} else {
					xhr.onreadystatechange = function() {

					// Check readyState before timeout as it changes
					if ( xhr.readyState === 4 ) {

					// Allow onerror to be called first,
					// but that will not handle a native abort
					// Also, save errorCallback to a variable
					// as xhr.onerror cannot be accessed
					window.setTimeout( function() {
					if ( callback ) {
					errorCallback();
					}
					} );
					}
					};
					}

					// Create the abort callback
					callback = callback( "abort" );

					try {

					// Do send the request (this may raise an exception)
					xhr.send( options.hasContent && options.data || null );
					} catch ( e ) {

					// trac-14683: Only rethrow if this hasn't been notified as an error yet
					if ( callback ) {
					throw e;
					}
					}
					},

					abort: function() {
					if ( callback ) {
					callback();
					}
					}
					};
					}
					} );


					// Prevent auto-execution of scripts when no explicit dataType was provided (See gh-2432)
					jQuery.ajaxPrefilter( function( s ) {
					if ( s.crossDomain ) {
					s.contents.script = false;
					}
					} );

					// Install script dataType
					jQuery.ajaxSetup( {
					accepts: {
					script: "text/javascript, application/javascript, " +
					"application/ecmascript, application/x-ecmascript"
					},
					contents: {
					script: /\b(?:java|ecma)script\b/
					},
					converters: {
					"text script": function( text ) {
					jQuery.globalEval( text );
					return text;
					}
					}
					} );

					// Handle cache's special case and crossDomain
					jQuery.ajaxPrefilter( "script", function( s ) {
					if ( s.cache === undefined ) {
					s.cache = false;
					}
					if ( s.crossDomain ) {
					s.type = "GET";
					}
					} );

					// Bind script tag hack transport
					jQuery.ajaxTransport( "script", function( s ) {

					// This transport only deals with cross domain or forced-by-attrs requests
					if ( s.crossDomain || s.scriptAttrs ) {
					var script, callback;
					return {
					send: function( _, complete ) {
					script = jQuery( "
					<script>" )
							.attr(s.scriptAttrs || {})
							.prop({charset: s.scriptCharset, src: s.url})
							.on("load error", callback = function (evt) {
								script.remove();
								callback = null;
								if (evt) {
									complete(evt.type === "error" ? 404 : 200, evt.type);
								}
							});

					// Use native DOM manipulation to avoid our domManip AJAX trickery
					document.head.appendChild(script[0]);
					},
					abort: function () {
						if (callback) {
							callback();
						}
					}
					}
					;
					}
					} )
					;


					var oldCallbacks = [],
							rjsonp = /(=)\?(?=&|$)|\?\?/;

					// Default jsonp settings
					jQuery.ajaxSetup({
						jsonp: "callback",
						jsonpCallback: function () {
							var callback = oldCallbacks.pop() || (jQuery.expando + "_" + (nonce.guid++));
							this[callback] = true;
							return callback;
						}
					});

					// Detect, normalize options and install callbacks for jsonp requests
					jQuery.ajaxPrefilter("json jsonp", function (s, originalSettings, jqXHR) {

						var callbackName, overwritten, responseContainer,
								jsonProp = s.jsonp !== false && (rjsonp.test(s.url) ?
												"url" :
												typeof s.data === "string" &&
												(s.contentType || "")
														.indexOf("application/x-www-form-urlencoded") === 0 &&
												rjsonp.test(s.data) && "data"
								);

						// Handle iff the expected data type is "jsonp" or we have a parameter to set
						if (jsonProp || s.dataTypes[0] === "jsonp") {

							// Get callback name, remembering preexisting value associated with it
							callbackName = s.jsonpCallback = isFunction(s.jsonpCallback) ?
									s.jsonpCallback() :
									s.jsonpCallback;

							// Insert callback into url or form data
							if (jsonProp) {
								s[jsonProp] = s[jsonProp].replace(rjsonp, "$1" + callbackName);
							} else if (s.jsonp !== false) {
								s.url += (rquery.test(s.url) ? "&" : "?") + s.jsonp + "=" + callbackName;
							}

							// Use data converter to retrieve json after script execution
							s.converters["script json"] = function () {
								if (!responseContainer) {
									jQuery.error(callbackName + " was not called");
								}
								return responseContainer[0];
							};

							// Force json dataType
							s.dataTypes[0] = "json";

							// Install callback
							overwritten = window[callbackName];
							window[callbackName] = function () {
								responseContainer = arguments;
							};

							// Clean-up function (fires after converters)
							jqXHR.always(function () {

								// If previous value didn't exist - remove it
								if (overwritten === undefined) {
									jQuery(window).removeProp(callbackName);

									// Otherwise restore preexisting value
								} else {
									window[callbackName] = overwritten;
								}

								// Save back as free
								if (s[callbackName]) {

									// Make sure that re-using the options doesn't screw things around
									s.jsonpCallback = originalSettings.jsonpCallback;

									// Save the callback name for future use
									oldCallbacks.push(callbackName);
								}

								// Call if it was a function and we have a response
								if (responseContainer && isFunction(overwritten)) {
									overwritten(responseContainer[0]);
								}

								responseContainer = overwritten = undefined;
							});

							// Delegate to script
							return "script";
						}
					});


					// Support: Safari 8 only
					// In Safari 8 documents created via document.implementation.createHTMLDocument
					// collapse sibling forms: the second one becomes a child of the first one.
					// Because of that, this security measure has to be disabled in Safari 8.
					// https://bugs.webkit.org/show_bug.cgi?id=137337
					support.createHTMLDocument = (function () {
						var body = document.implementation.createHTMLDocument("").body;
						body.innerHTML = "<form></form><form></form>";
						return body.childNodes.length === 2;
					})();


					// Argument "data" should be string of html
					// context (optional): If specified, the fragment will be created in this context,
					// defaults to document
					// keepScripts (optional): If true, will include scripts passed in the html string
					jQuery.parseHTML = function (data, context, keepScripts) {
						if (typeof data !== "string") {
							return [];
						}
						if (typeof context === "boolean") {
							keepScripts = context;
							context = false;
						}

						var base, parsed, scripts;

						if (!context) {

							// Stop scripts or inline event handlers from being executed immediately
							// by using document.implementation
							if (support.createHTMLDocument) {
								context = document.implementation.createHTMLDocument("");

								// Set the base href for the created document
								// so any parsed elements with URLs
								// are based on the document's URL (gh-2965)
								base = context.createElement("base");
								base.href = document.location.href;
								context.head.appendChild(base);
							} else {
								context = document;
							}
						}

						parsed = rsingleTag.exec(data);
						scripts = !keepScripts && [];

						// Single tag
						if (parsed) {
							return [context.createElement(parsed[1])];
						}

						parsed = buildFragment([data], context, scripts);

						if (scripts && scripts.length) {
							jQuery(scripts).remove();
						}

						return jQuery.merge([], parsed.childNodes);
					};


					/**
					 * Load a url into a page
					 */
					jQuery.fn.load = function (url, params, callback) {
						var selector, type, response,
								self = this,
								off = url.indexOf(" ");

						if (off > -1) {
							selector = stripAndCollapse(url.slice(off));
							url = url.slice(0, off);
						}

						// If it's a function
						if (isFunction(params)) {

							// We assume that it's the callback
							callback = params;
							params = undefined;

							// Otherwise, build a param string
						} else if (params && typeof params === "object") {
							type = "POST";
						}

						// If we have elements to modify, make the request
						if (self.length > 0) {
							jQuery.ajax({
								url: url,

								// If "type" variable is undefined, then "GET" method will be used.
								// Make value of this field explicit since
								// user can override it through ajaxSetup method
								type: type || "GET",
								dataType: "html",
								data: params
							}).done(function (responseText) {

								// Save response for use in complete callback
								response = arguments;

								self.html(selector ?

										// If a selector was specified, locate the right elements in a dummy div
										// Exclude scripts to avoid IE 'Permission Denied' errors
										jQuery("<div>").append(jQuery.parseHTML(responseText)).find(selector) :

										// Otherwise use the full result
										responseText);

								// If the request succeeds, this function gets "data", "status", "jqXHR"
								// but they are ignored because response was set above.
								// If it fails, this function gets "jqXHR", "status", "error"
							}).always(callback && function (jqXHR, status) {
								self.each(function () {
									callback.apply(this, response || [jqXHR.responseText, status, jqXHR]);
								});
							});
						}

						return this;
					};


					jQuery.expr.pseudos.animated = function (elem) {
						return jQuery.grep(jQuery.timers, function (fn) {
							return elem === fn.elem;
						}).length;
					};


					jQuery.offset = {
						setOffset: function (elem, options, i) {
							var curPosition, curLeft, curCSSTop, curTop, curOffset, curCSSLeft, calculatePosition,
									position = jQuery.css(elem, "position"),
									curElem = jQuery(elem),
									props = {};

							// Set position first, in-case top/left are set even on static elem
							if (position === "static") {
								elem.style.position = "relative";
							}

							curOffset = curElem.offset();
							curCSSTop = jQuery.css(elem, "top");
							curCSSLeft = jQuery.css(elem, "left");
							calculatePosition = (position === "absolute" || position === "fixed") &&
									(curCSSTop + curCSSLeft).indexOf("auto") > -1;

							// Need to be able to calculate position if either
							// top or left is auto and position is either absolute or fixed
							if (calculatePosition) {
								curPosition = curElem.position();
								curTop = curPosition.top;
								curLeft = curPosition.left;

							} else {
								curTop = parseFloat(curCSSTop) || 0;
								curLeft = parseFloat(curCSSLeft) || 0;
							}

							if (isFunction(options)) {

								// Use jQuery.extend here to allow modification of coordinates argument (gh-1848)
								options = options.call(elem, i, jQuery.extend({}, curOffset));
							}

							if (options.top != null) {
								props.top = (options.top - curOffset.top) + curTop;
							}
							if (options.left != null) {
								props.left = (options.left - curOffset.left) + curLeft;
							}

							if ("using" in options) {
								options.using.call(elem, props);

							} else {
								curElem.css(props);
							}
						}
					};

					jQuery.fn.extend({

						// offset() relates an element's border box to the document origin
						offset: function (options) {

							// Preserve chaining for setter
							if (arguments.length) {
								return options === undefined ?
										this :
										this.each(function (i) {
											jQuery.offset.setOffset(this, options, i);
										});
							}

							var rect, win,
									elem = this[0];

							if (!elem) {
								return;
							}

							// Return zeros for disconnected and hidden (display: none) elements (gh-2310)
							// Support: IE <=11 only
							// Running getBoundingClientRect on a
							// disconnected node in IE throws an error
							if (!elem.getClientRects().length) {
								return {top: 0, left: 0};
							}

							// Get document-relative position by adding viewport scroll to viewport-relative gBCR
							rect = elem.getBoundingClientRect();
							win = elem.ownerDocument.defaultView;
							return {
								top: rect.top + win.pageYOffset,
								left: rect.left + win.pageXOffset
							};
						},

						// position() relates an element's margin box to its offset parent's padding box
						// This corresponds to the behavior of CSS absolute positioning
						position: function () {
							if (!this[0]) {
								return;
							}

							var offsetParent, offset, doc,
									elem = this[0],
									parentOffset = {top: 0, left: 0};

							// position:fixed elements are offset from the viewport, which itself always has zero offset
							if (jQuery.css(elem, "position") === "fixed") {

								// Assume position:fixed implies availability of getBoundingClientRect
								offset = elem.getBoundingClientRect();

							} else {
								offset = this.offset();

								// Account for the *real* offset parent, which can be the document or its root element
								// when a statically positioned element is identified
								doc = elem.ownerDocument;
								offsetParent = elem.offsetParent || doc.documentElement;
								while (offsetParent &&
								(offsetParent === doc.body || offsetParent === doc.documentElement) &&
								jQuery.css(offsetParent, "position") === "static") {

									offsetParent = offsetParent.parentNode;
								}
								if (offsetParent && offsetParent !== elem && offsetParent.nodeType === 1) {

									// Incorporate borders into its offset, since they are outside its content origin
									parentOffset = jQuery(offsetParent).offset();
									parentOffset.top += jQuery.css(offsetParent, "borderTopWidth", true);
									parentOffset.left += jQuery.css(offsetParent, "borderLeftWidth", true);
								}
							}

							// Subtract parent offsets and element margins
							return {
								top: offset.top - parentOffset.top - jQuery.css(elem, "marginTop", true),
								left: offset.left - parentOffset.left - jQuery.css(elem, "marginLeft", true)
							};
						},

						// This method will return documentElement in the following cases:
						// 1) For the element inside the iframe without offsetParent, this method will return
						//    documentElement of the parent window
						// 2) For the hidden or detached element
						// 3) For body or html element, i.e. in case of the html node - it will return itself
						//
						// but those exceptions were never presented as a real life use-cases
						// and might be considered as more preferable results.
						//
						// This logic, however, is not guaranteed and can change at any point in the future
						offsetParent: function () {
							return this.map(function () {
								var offsetParent = this.offsetParent;

								while (offsetParent && jQuery.css(offsetParent, "position") === "static") {
									offsetParent = offsetParent.offsetParent;
								}

								return offsetParent || documentElement;
							});
						}
					});

					// Create scrollLeft and scrollTop methods
					jQuery.each({scrollLeft: "pageXOffset", scrollTop: "pageYOffset"}, function (method, prop) {
						var top = "pageYOffset" === prop;

						jQuery.fn[method] = function (val) {
							return access(this, function (elem, method, val) {

								// Coalesce documents and windows
								var win;
								if (isWindow(elem)) {
									win = elem;
								} else if (elem.nodeType === 9) {
									win = elem.defaultView;
								}

								if (val === undefined) {
									return win ? win[prop] : elem[method];
								}

								if (win) {
									win.scrollTo(
											!top ? val : win.pageXOffset,
											top ? val : win.pageYOffset
									);

								} else {
									elem[method] = val;
								}
							}, method, val, arguments.length);
						};
					});

					// Support: Safari <=7 - 9.1, Chrome <=37 - 49
					// Add the top/left cssHooks using jQuery.fn.position
					// Webkit bug: https://bugs.webkit.org/show_bug.cgi?id=29084
					// Blink bug: https://bugs.chromium.org/p/chromium/issues/detail?id=589347
					// getComputedStyle returns percent when specified for top/left/bottom/right;
					// rather than make the css module depend on the offset module, just check for it here
					jQuery.each(["top", "left"], function (_i, prop) {
						jQuery.cssHooks[prop] = addGetHookIf(support.pixelPosition,
								function (elem, computed) {
									if (computed) {
										computed = curCSS(elem, prop);

										// If curCSS returns percentage, fallback to offset
										return rnumnonpx.test(computed) ?
												jQuery(elem).position()[prop] + "px" :
												computed;
									}
								}
						);
					});


					// Create innerHeight, innerWidth, height, width, outerHeight and outerWidth methods
					jQuery.each({Height: "height", Width: "width"}, function (name, type) {
						jQuery.each({
							padding: "inner" + name,
							content: type,
							"": "outer" + name
						}, function (defaultExtra, funcName) {

							// Margin is only for outerHeight, outerWidth
							jQuery.fn[funcName] = function (margin, value) {
								var chainable = arguments.length && (defaultExtra || typeof margin !== "boolean"),
										extra = defaultExtra || (margin === true || value === true ? "margin" : "border");

								return access(this, function (elem, type, value) {
									var doc;

									if (isWindow(elem)) {

										// $( window ).outerWidth/Height return w/h including scrollbars (gh-1729)
										return funcName.indexOf("outer") === 0 ?
												elem["inner" + name] :
												elem.document.documentElement["client" + name];
									}

									// Get document width or height
									if (elem.nodeType === 9) {
										doc = elem.documentElement;

										// Either scroll[Width/Height] or offset[Width/Height] or client[Width/Height],
										// whichever is greatest
										return Math.max(
												elem.body["scroll" + name], doc["scroll" + name],
												elem.body["offset" + name], doc["offset" + name],
												doc["client" + name]
										);
									}

									return value === undefined ?

											// Get width or height on the element, requesting but not forcing parseFloat
											jQuery.css(elem, type, extra) :

											// Set width or height on the element
											jQuery.style(elem, type, value, extra);
								}, type, chainable ? margin : undefined, chainable);
							};
						});
					});


					jQuery.each([
						"ajaxStart",
						"ajaxStop",
						"ajaxComplete",
						"ajaxError",
						"ajaxSuccess",
						"ajaxSend"
					], function (_i, type) {
						jQuery.fn[type] = function (fn) {
							return this.on(type, fn);
						};
					});


					jQuery.fn.extend({

						bind: function (types, data, fn) {
							return this.on(types, null, data, fn);
						},
						unbind: function (types, fn) {
							return this.off(types, null, fn);
						},

						delegate: function (selector, types, data, fn) {
							return this.on(types, selector, data, fn);
						},
						undelegate: function (selector, types, fn) {

							// ( namespace ) or ( selector, types [, fn] )
							return arguments.length === 1 ?
									this.off(selector, "**") :
									this.off(types, selector || "**", fn);
						},

						hover: function (fnOver, fnOut) {
							return this.mouseenter(fnOver).mouseleave(fnOut || fnOver);
						}
					});

					jQuery.each(
							("blur focus focusin focusout resize scroll click dblclick " +
									"mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave " +
									"change select submit keydown keypress keyup contextmenu").split(" "),
							function (_i, name) {

								// Handle event binding
								jQuery.fn[name] = function (data, fn) {
									return arguments.length > 0 ?
											this.on(name, null, data, fn) :
											this.trigger(name);
								};
							}
					);


					// Support: Android <=4.0 only
					// Make sure we trim BOM and NBSP
					// Require that the "whitespace run" starts from a non-whitespace
					// to avoid O(N^2) behavior when the engine would try matching "\s+$" at each space position.
					var rtrim = /^[\s\uFEFF\xA0]+|([^\s\uFEFF\xA0])[\s\uFEFF\xA0]+$/g;

					// Bind a function to a context, optionally partially applying any
					// arguments.
					// jQuery.proxy is deprecated to promote standards (specifically Function#bind)
					// However, it is not slated for removal any time soon
					jQuery.proxy = function (fn, context) {
						var tmp, args, proxy;

						if (typeof context === "string") {
							tmp = fn[context];
							context = fn;
							fn = tmp;
						}

						// Quick check to determine if target is callable, in the spec
						// this throws a TypeError, but we will just return undefined.
						if (!isFunction(fn)) {
							return undefined;
						}

						// Simulated bind
						args = slice.call(arguments, 2);
						proxy = function () {
							return fn.apply(context || this, args.concat(slice.call(arguments)));
						};

						// Set the guid of unique handler to the same of original handler, so it can be removed
						proxy.guid = fn.guid = fn.guid || jQuery.guid++;

						return proxy;
					};

					jQuery.holdReady = function (hold) {
						if (hold) {
							jQuery.readyWait++;
						} else {
							jQuery.ready(true);
						}
					};
					jQuery.isArray = Array.isArray;
					jQuery.parseJSON = JSON.parse;
					jQuery.nodeName = nodeName;
					jQuery.isFunction = isFunction;
					jQuery.isWindow = isWindow;
					jQuery.camelCase = camelCase;
					jQuery.type = toType;

					jQuery.now = Date.now;

					jQuery.isNumeric = function (obj) {

						// As of jQuery 3.0, isNumeric is limited to
						// strings and numbers (primitives or objects)
						// that can be coerced to finite numbers (gh-2662)
						var type = jQuery.type(obj);
						return (type === "number" || type === "string") &&

								// parseFloat NaNs numeric-cast false positives ("")
								// ...but misinterprets leading-number strings, particularly hex literals ("0x...")
								// subtraction forces infinities to NaN
								!isNaN(obj - parseFloat(obj));
					};

					jQuery.trim = function (text) {
						return text == null ?
								"" :
								(text + "").replace(rtrim, "$1");
					};


					// Register as a named AMD module, since jQuery can be concatenated with other
					// files that may use define, but not via a proper concatenation script that
					// understands anonymous AMD modules. A named AMD is safest and most robust
					// way to register. Lowercase jquery is used because AMD module names are
					// derived from file names, and jQuery is normally delivered in a lowercase
					// file name. Do this after creating the global so that if an AMD module wants
					// to call noConflict to hide this version of jQuery, it will work.

					// Note that for maximum portability, libraries that are not jQuery should
					// declare themselves as anonymous modules, and avoid setting a global if an
					// AMD loader is present. jQuery is a special case. For more information, see
					// https://github.com/jrburke/requirejs/wiki/Updating-existing-libraries#wiki-anon

					if (typeof define === "function" && define.amd) {
						define("jquery", [], function () {
							return jQuery;
						});
					}


					var

							// Map over jQuery in case of overwrite
							_jQuery = window.jQuery,

							// Map over the $ in case of overwrite
							_$ = window.$;

					jQuery.noConflict = function (deep) {
						if (window.$ === jQuery) {
							window.$ = _$;
						}

						if (deep && window.jQuery === jQuery) {
							window.jQuery = _jQuery;
						}

						return jQuery;
					};

					// Expose jQuery and $ identifiers, even in AMD
					// (trac-7102#comment:10, https://github.com/jquery/jquery/pull/557)
					// and CommonJS for browser emulators (trac-13566)
					if (typeof noGlobal === "undefined") {
						window.jQuery = window.$ = jQuery;
					}


					return jQuery;
					} )
					;




/*!
 * Sizzle CSS Selector Engine
 *  Copyright 2011, The Dojo Foundation
 *  Released under the MIT, BSD, and GPL Licenses.
 *  More information: http://sizzlejs.com/
 */
(function(){

var chunker = /((?:\((?:\([^()]+\)|[^()]+)+\)|\[(?:\[[^\[\]]*\]|['"][^'"]*['"]|[^\[\]'"]+)+\]|\\.|[^ >+~,(\[\\]+)+|[>+~])(\s*,\s*)?((?:.|\r|\n)*)/g,
	done = 0,
	toString = Object.prototype.toString,
	hasDuplicate = false,
	baseHasDuplicate = true,
	rBackslash = /\\/g,
	rNonWord = /\W/;

// Here we check if the JavaScript engine is using some sort of
// optimization where it does not always call our comparision
// function. If that is the case, discard the hasDuplicate value.
//   Thus far that includes Google Chrome.
[0, 0].sort(function() {
	baseHasDuplicate = false;
	return 0;
});

var Sizzle = function( selector, context, results, seed ) {
	results = results || [];
	context = context || document;

	var origContext = context;

	if ( context.nodeType !== 1 && context.nodeType !== 9 ) {
		return [];
	}
	
	if ( !selector || typeof selector !== "string" ) {
		return results;
	}

	var m, set, checkSet, extra, ret, cur, pop, i,
		prune = true,
		contextXML = Sizzle.isXML( context ),
		parts = [],
		soFar = selector;
	
	// Reset the position of the chunker regexp (start from head)
	do {
		chunker.exec( "" );
		m = chunker.exec( soFar );

		if ( m ) {
			soFar = m[3];
		
			parts.push( m[1] );
		
			if ( m[2] ) {
				extra = m[3];
				break;
			}
		}
	} while ( m );

	if ( parts.length > 1 && origPOS.exec( selector ) ) {

		if ( parts.length === 2 && Expr.relative[ parts[0] ] ) {
			set = posProcess( parts[0] + parts[1], context );

		} else {
			set = Expr.relative[ parts[0] ] ?
				[ context ] :
				Sizzle( parts.shift(), context );

			while ( parts.length ) {
				selector = parts.shift();

				if ( Expr.relative[ selector ] ) {
					selector += parts.shift();
				}
				
				set = posProcess( selector, set );
			}
		}

	} else {
		// Take a shortcut and set the context if the root selector is an ID
		// (but not if it'll be faster if the inner selector is an ID)
		if ( !seed && parts.length > 1 && context.nodeType === 9 && !contextXML &&
				Expr.match.ID.test(parts[0]) && !Expr.match.ID.test(parts[parts.length - 1]) ) {

			ret = Sizzle.find( parts.shift(), context, contextXML );
			context = ret.expr ?
				Sizzle.filter( ret.expr, ret.set )[0] :
				ret.set[0];
		}

		if ( context ) {
			ret = seed ?
				{ expr: parts.pop(), set: makeArray(seed) } :
				Sizzle.find( parts.pop(), parts.length === 1 && (parts[0] === "~" || parts[0] === "+") && context.parentNode ? context.parentNode : context, contextXML );

			set = ret.expr ?
				Sizzle.filter( ret.expr, ret.set ) :
				ret.set;

			if ( parts.length > 0 ) {
				checkSet = makeArray( set );

			} else {
				prune = false;
			}

			while ( parts.length ) {
				cur = parts.pop();
				pop = cur;

				if ( !Expr.relative[ cur ] ) {
					cur = "";
				} else {
					pop = parts.pop();
				}

				if ( pop == null ) {
					pop = context;
				}

				Expr.relative[ cur ]( checkSet, pop, contextXML );
			}

		} else {
			checkSet = parts = [];
		}
	}

	if ( !checkSet ) {
		checkSet = set;
	}

	if ( !checkSet ) {
		Sizzle.error( cur || selector );
	}

	if ( toString.call(checkSet) === "[object Array]" ) {
		if ( !prune ) {
			results.push.apply( results, checkSet );

		} else if ( context && context.nodeType === 1 ) {
			for ( i = 0; checkSet[i] != null; i++ ) {
				if ( checkSet[i] && (checkSet[i] === true || checkSet[i].nodeType === 1 && Sizzle.contains(context, checkSet[i])) ) {
					results.push( set[i] );
				}
			}

		} else {
			for ( i = 0; checkSet[i] != null; i++ ) {
				if ( checkSet[i] && checkSet[i].nodeType === 1 ) {
					results.push( set[i] );
				}
			}
		}

	} else {
		makeArray( checkSet, results );
	}

	if ( extra ) {
		Sizzle( extra, origContext, results, seed );
		Sizzle.uniqueSort( results );
	}

	return results;
};

Sizzle.uniqueSort = function( results ) {
	if ( sortOrder ) {
		hasDuplicate = baseHasDuplicate;
		results.sort( sortOrder );

		if ( hasDuplicate ) {
			for ( var i = 1; i < results.length; i++ ) {
				if ( results[i] === results[ i - 1 ] ) {
					results.splice( i--, 1 );
				}
			}
		}
	}

	return results;
};

Sizzle.matches = function( expr, set ) {
	return Sizzle( expr, null, null, set );
};

Sizzle.matchesSelector = function( node, expr ) {
	return Sizzle( expr, null, null, [node] ).length > 0;
};

Sizzle.find = function( expr, context, isXML ) {
	var set;

	if ( !expr ) {
		return [];
	}

	for ( var i = 0, l = Expr.order.length; i < l; i++ ) {
		var match,
			type = Expr.order[i];
		
		if ( (match = Expr.leftMatch[ type ].exec( expr )) ) {
			var left = match[1];
			match.splice( 1, 1 );

			if ( left.substr( left.length - 1 ) !== "\\" ) {
				match[1] = (match[1] || "").replace( rBackslash, "" );
				set = Expr.find[ type ]( match, context, isXML );

				if ( set != null ) {
					expr = expr.replace( Expr.match[ type ], "" );
					break;
				}
			}
		}
	}

	if ( !set ) {
		set = typeof context.getElementsByTagName !== "undefined" ?
			context.getElementsByTagName( "*" ) :
			[];
	}

	return { set: set, expr: expr };
};

Sizzle.filter = function( expr, set, inplace, not ) {
	var match, anyFound,
		old = expr,
		result = [],
		curLoop = set,
		isXMLFilter = set && set[0] && Sizzle.isXML( set[0] );

	while ( expr && set.length ) {
		for ( var type in Expr.filter ) {
			if ( (match = Expr.leftMatch[ type ].exec( expr )) != null && match[2] ) {
				var found, item,
					filter = Expr.filter[ type ],
					left = match[1];

				anyFound = false;

				match.splice(1,1);

				if ( left.substr( left.length - 1 ) === "\\" ) {
					continue;
				}

				if ( curLoop === result ) {
					result = [];
				}

				if ( Expr.preFilter[ type ] ) {
					match = Expr.preFilter[ type ]( match, curLoop, inplace, result, not, isXMLFilter );

					if ( !match ) {
						anyFound = found = true;

					} else if ( match === true ) {
						continue;
					}
				}

				if ( match ) {
					for ( var i = 0; (item = curLoop[i]) != null; i++ ) {
						if ( item ) {
							found = filter( item, match, i, curLoop );
							var pass = not ^ !!found;

							if ( inplace && found != null ) {
								if ( pass ) {
									anyFound = true;

								} else {
									curLoop[i] = false;
								}

							} else if ( pass ) {
								result.push( item );
								anyFound = true;
							}
						}
					}
				}

				if ( found !== undefined ) {
					if ( !inplace ) {
						curLoop = result;
					}

					expr = expr.replace( Expr.match[ type ], "" );

					if ( !anyFound ) {
						return [];
					}

					break;
				}
			}
		}

		// Improper expression
		if ( expr === old ) {
			if ( anyFound == null ) {
				Sizzle.error( expr );

			} else {
				break;
			}
		}

		old = expr;
	}

	return curLoop;
};

Sizzle.error = function( msg ) {
	throw "Syntax error, unrecognized expression: " + msg;
};

var Expr = Sizzle.selectors = {
	order: [ "ID", "NAME", "TAG" ],

	match: {
		ID: /#((?:[\w\u00c0-\uFFFF\-]|\\.)+)/,
		CLASS: /\.((?:[\w\u00c0-\uFFFF\-]|\\.)+)/,
		NAME: /\[name=['"]*((?:[\w\u00c0-\uFFFF\-]|\\.)+)['"]*\]/,
		ATTR: /\[\s*((?:[\w\u00c0-\uFFFF\-]|\\.)+)\s*(?:(\S?=)\s*(?:(['"])(.*?)\3|(#?(?:[\w\u00c0-\uFFFF\-]|\\.)*)|)|)\s*\]/,
		TAG: /^((?:[\w\u00c0-\uFFFF\*\-]|\\.)+)/,
		CHILD: /:(only|nth|last|first)-child(?:\(\s*(even|odd|(?:[+\-]?\d+|(?:[+\-]?\d*)?n\s*(?:[+\-]\s*\d+)?))\s*\))?/,
		POS: /:(nth|eq|gt|lt|first|last|even|odd)(?:\((\d*)\))?(?=[^\-]|$)/,
		PSEUDO: /:((?:[\w\u00c0-\uFFFF\-]|\\.)+)(?:\((['"]?)((?:\([^\)]+\)|[^\(\)]*)+)\2\))?/
	},

	leftMatch: {},

	attrMap: {
		"class": "className",
		"for": "htmlFor"
	},

	attrHandle: {
		href: function( elem ) {
			return elem.getAttribute( "href" );
		},
		type: function( elem ) {
			return elem.getAttribute( "type" );
		}
	},

	relative: {
		"+": function(checkSet, part){
			var isPartStr = typeof part === "string",
				isTag = isPartStr && !rNonWord.test( part ),
				isPartStrNotTag = isPartStr && !isTag;

			if ( isTag ) {
				part = part.toLowerCase();
			}

			for ( var i = 0, l = checkSet.length, elem; i < l; i++ ) {
				if ( (elem = checkSet[i]) ) {
					while ( (elem = elem.previousSibling) && elem.nodeType !== 1 ) {}

					checkSet[i] = isPartStrNotTag || elem && elem.nodeName.toLowerCase() === part ?
						elem || false :
						elem === part;
				}
			}

			if ( isPartStrNotTag ) {
				Sizzle.filter( part, checkSet, true );
			}
		},

		">": function( checkSet, part ) {
			var elem,
				isPartStr = typeof part === "string",
				i = 0,
				l = checkSet.length;

			if ( isPartStr && !rNonWord.test( part ) ) {
				part = part.toLowerCase();

				for ( ; i < l; i++ ) {
					elem = checkSet[i];

					if ( elem ) {
						var parent = elem.parentNode;
						checkSet[i] = parent.nodeName.toLowerCase() === part ? parent : false;
					}
				}

			} else {
				for ( ; i < l; i++ ) {
					elem = checkSet[i];

					if ( elem ) {
						checkSet[i] = isPartStr ?
							elem.parentNode :
							elem.parentNode === part;
					}
				}

				if ( isPartStr ) {
					Sizzle.filter( part, checkSet, true );
				}
			}
		},

		"": function(checkSet, part, isXML){
			var nodeCheck,
				doneName = done++,
				checkFn = dirCheck;

			if ( typeof part === "string" && !rNonWord.test( part ) ) {
				part = part.toLowerCase();
				nodeCheck = part;
				checkFn = dirNodeCheck;
			}

			checkFn( "parentNode", part, doneName, checkSet, nodeCheck, isXML );
		},

		"~": function( checkSet, part, isXML ) {
			var nodeCheck,
				doneName = done++,
				checkFn = dirCheck;

			if ( typeof part === "string" && !rNonWord.test( part ) ) {
				part = part.toLowerCase();
				nodeCheck = part;
				checkFn = dirNodeCheck;
			}

			checkFn( "previousSibling", part, doneName, checkSet, nodeCheck, isXML );
		}
	},

	find: {
		ID: function( match, context, isXML ) {
			if ( typeof context.getElementById !== "undefined" && !isXML ) {
				var m = context.getElementById(match[1]);
				// Check parentNode to catch when Blackberry 4.6 returns
				// nodes that are no longer in the document #6963
				return m && m.parentNode ? [m] : [];
			}
		},

		NAME: function( match, context ) {
			if ( typeof context.getElementsByName !== "undefined" ) {
				var ret = [],
					results = context.getElementsByName( match[1] );

				for ( var i = 0, l = results.length; i < l; i++ ) {
					if ( results[i].getAttribute("name") === match[1] ) {
						ret.push( results[i] );
					}
				}

				return ret.length === 0 ? null : ret;
			}
		},

		TAG: function( match, context ) {
			if ( typeof context.getElementsByTagName !== "undefined" ) {
				return context.getElementsByTagName( match[1] );
			}
		}
	},
	preFilter: {
		CLASS: function( match, curLoop, inplace, result, not, isXML ) {
			match = " " + match[1].replace( rBackslash, "" ) + " ";

			if ( isXML ) {
				return match;
			}

			for ( var i = 0, elem; (elem = curLoop[i]) != null; i++ ) {
				if ( elem ) {
					if ( not ^ (elem.className && (" " + elem.className + " ").replace(/[\t\n\r]/g, " ").indexOf(match) >= 0) ) {
						if ( !inplace ) {
							result.push( elem );
						}

					} else if ( inplace ) {
						curLoop[i] = false;
					}
				}
			}

			return false;
		},

		ID: function( match ) {
			return match[1].replace( rBackslash, "" );
		},

		TAG: function( match, curLoop ) {
			return match[1].replace( rBackslash, "" ).toLowerCase();
		},

		CHILD: function( match ) {
			if ( match[1] === "nth" ) {
				if ( !match[2] ) {
					Sizzle.error( match[0] );
				}

				match[2] = match[2].replace(/^\+|\s*/g, '');

				// parse equations like 'even', 'odd', '5', '2n', '3n+2', '4n-1', '-n+6'
				var test = /(-?)(\d*)(?:n([+\-]?\d*))?/.exec(
					match[2] === "even" && "2n" || match[2] === "odd" && "2n+1" ||
					!/\D/.test( match[2] ) && "0n+" + match[2] || match[2]);

				// calculate the numbers (first)n+(last) including if they are negative
				match[2] = (test[1] + (test[2] || 1)) - 0;
				match[3] = test[3] - 0;
			}
			else if ( match[2] ) {
				Sizzle.error( match[0] );
			}

			// TODO: Move to normal caching system
			match[0] = done++;

			return match;
		},

		ATTR: function( match, curLoop, inplace, result, not, isXML ) {
			var name = match[1] = match[1].replace( rBackslash, "" );
			
			if ( !isXML && Expr.attrMap[name] ) {
				match[1] = Expr.attrMap[name];
			}

			// Handle if an un-quoted value was used
			match[4] = ( match[4] || match[5] || "" ).replace( rBackslash, "" );

			if ( match[2] === "~=" ) {
				match[4] = " " + match[4] + " ";
			}

			return match;
		},

		PSEUDO: function( match, curLoop, inplace, result, not ) {
			if ( match[1] === "not" ) {
				// If we're dealing with a complex expression, or a simple one
				if ( ( chunker.exec(match[3]) || "" ).length > 1 || /^\w/.test(match[3]) ) {
					match[3] = Sizzle(match[3], null, null, curLoop);

				} else {
					var ret = Sizzle.filter(match[3], curLoop, inplace, true ^ not);

					if ( !inplace ) {
						result.push.apply( result, ret );
					}

					return false;
				}

			} else if ( Expr.match.POS.test( match[0] ) || Expr.match.CHILD.test( match[0] ) ) {
				return true;
			}
			
			return match;
		},

		POS: function( match ) {
			match.unshift( true );

			return match;
		}
	},
	
	filters: {
		enabled: function( elem ) {
			return elem.disabled === false && elem.type !== "hidden";
		},

		disabled: function( elem ) {
			return elem.disabled === true;
		},

		checked: function( elem ) {
			return elem.checked === true;
		},
		
		selected: function( elem ) {
			// Accessing this property makes selected-by-default
			// options in Safari work properly
			if ( elem.parentNode ) {
				elem.parentNode.selectedIndex;
			}
			
			return elem.selected === true;
		},

		parent: function( elem ) {
			return !!elem.firstChild;
		},

		empty: function( elem ) {
			return !elem.firstChild;
		},

		has: function( elem, i, match ) {
			return !!Sizzle( match[3], elem ).length;
		},

		header: function( elem ) {
			return (/h\d/i).test( elem.nodeName );
		},

		text: function( elem ) {
			var attr = elem.getAttribute( "type" ), type = elem.type;
			// IE6 and 7 will map elem.type to 'text' for new HTML5 types (search, etc) 
			// use getAttribute instead to test this case
			return elem.nodeName.toLowerCase() === "input" && "text" === type && ( attr === type || attr === null );
		},

		radio: function( elem ) {
			return elem.nodeName.toLowerCase() === "input" && "radio" === elem.type;
		},

		checkbox: function( elem ) {
			return elem.nodeName.toLowerCase() === "input" && "checkbox" === elem.type;
		},

		file: function( elem ) {
			return elem.nodeName.toLowerCase() === "input" && "file" === elem.type;
		},

		password: function( elem ) {
			return elem.nodeName.toLowerCase() === "input" && "password" === elem.type;
		},

		submit: function( elem ) {
			var name = elem.nodeName.toLowerCase();
			return (name === "input" || name === "button") && "submit" === elem.type;
		},

		image: function( elem ) {
			return elem.nodeName.toLowerCase() === "input" && "image" === elem.type;
		},

		reset: function( elem ) {
			var name = elem.nodeName.toLowerCase();
			return (name === "input" || name === "button") && "reset" === elem.type;
		},

		button: function( elem ) {
			var name = elem.nodeName.toLowerCase();
			return name === "input" && "button" === elem.type || name === "button";
		},

		input: function( elem ) {
			return (/input|select|textarea|button/i).test( elem.nodeName );
		},

		focus: function( elem ) {
			return elem === elem.ownerDocument.activeElement;
		}
	},
	setFilters: {
		first: function( elem, i ) {
			return i === 0;
		},

		last: function( elem, i, match, array ) {
			return i === array.length - 1;
		},

		even: function( elem, i ) {
			return i % 2 === 0;
		},

		odd: function( elem, i ) {
			return i % 2 === 1;
		},

		lt: function( elem, i, match ) {
			return i < match[3] - 0;
		},

		gt: function( elem, i, match ) {
			return i > match[3] - 0;
		},

		nth: function( elem, i, match ) {
			return match[3] - 0 === i;
		},

		eq: function( elem, i, match ) {
			return match[3] - 0 === i;
		}
	},
	filter: {
		PSEUDO: function( elem, match, i, array ) {
			var name = match[1],
				filter = Expr.filters[ name ];

			if ( filter ) {
				return filter( elem, i, match, array );

			} else if ( name === "contains" ) {
				return (elem.textContent || elem.innerText || Sizzle.getText([ elem ]) || "").indexOf(match[3]) >= 0;

			} else if ( name === "not" ) {
				var not = match[3];

				for ( var j = 0, l = not.length; j < l; j++ ) {
					if ( not[j] === elem ) {
						return false;
					}
				}

				return true;

			} else {
				Sizzle.error( name );
			}
		},

		CHILD: function( elem, match ) {
			var type = match[1],
				node = elem;

			switch ( type ) {
				case "only":
				case "first":
					while ( (node = node.previousSibling) )	 {
						if ( node.nodeType === 1 ) { 
							return false; 
						}
					}

					if ( type === "first" ) { 
						return true; 
					}

					node = elem;

				case "last":
					while ( (node = node.nextSibling) )	 {
						if ( node.nodeType === 1 ) { 
							return false; 
						}
					}

					return true;

				case "nth":
					var first = match[2],
						last = match[3];

					if ( first === 1 && last === 0 ) {
						return true;
					}
					
					var doneName = match[0],
						parent = elem.parentNode;
	
					if ( parent && (parent.sizcache !== doneName || !elem.nodeIndex) ) {
						var count = 0;
						
						for ( node = parent.firstChild; node; node = node.nextSibling ) {
							if ( node.nodeType === 1 ) {
								node.nodeIndex = ++count;
							}
						} 

						parent.sizcache = doneName;
					}
					
					var diff = elem.nodeIndex - last;

					if ( first === 0 ) {
						return diff === 0;

					} else {
						return ( diff % first === 0 && diff / first >= 0 );
					}
			}
		},

		ID: function( elem, match ) {
			return elem.nodeType === 1 && elem.getAttribute("id") === match;
		},

		TAG: function( elem, match ) {
			return (match === "*" && elem.nodeType === 1) || elem.nodeName.toLowerCase() === match;
		},
		
		CLASS: function( elem, match ) {
			return (" " + (elem.className || elem.getAttribute("class")) + " ")
				.indexOf( match ) > -1;
		},

		ATTR: function( elem, match ) {
			var name = match[1],
				result = Expr.attrHandle[ name ] ?
					Expr.attrHandle[ name ]( elem ) :
					elem[ name ] != null ?
						elem[ name ] :
						elem.getAttribute( name ),
				value = result + "",
				type = match[2],
				check = match[4];

			return result == null ?
				type === "!=" :
				type === "=" ?
				value === check :
				type === "*=" ?
				value.indexOf(check) >= 0 :
				type === "~=" ?
				(" " + value + " ").indexOf(check) >= 0 :
				!check ?
				value && result !== false :
				type === "!=" ?
				value !== check :
				type === "^=" ?
				value.indexOf(check) === 0 :
				type === "$=" ?
				value.substr(value.length - check.length) === check :
				type === "|=" ?
				value === check || value.substr(0, check.length + 1) === check + "-" :
				false;
		},

		POS: function( elem, match, i, array ) {
			var name = match[2],
				filter = Expr.setFilters[ name ];

			if ( filter ) {
				return filter( elem, i, match, array );
			}
		}
	}
};

var origPOS = Expr.match.POS,
	fescape = function(all, num){
		return "\\" + (num - 0 + 1);
	};

for ( var type in Expr.match ) {
	Expr.match[ type ] = new RegExp( Expr.match[ type ].source + (/(?![^\[]*\])(?![^\(]*\))/.source) );
	Expr.leftMatch[ type ] = new RegExp( /(^(?:.|\r|\n)*?)/.source + Expr.match[ type ].source.replace(/\\(\d+)/g, fescape) );
}

var makeArray = function( array, results ) {
	array = Array.prototype.slice.call( array, 0 );

	if ( results ) {
		results.push.apply( results, array );
		return results;
	}
	
	return array;
};

// Perform a simple check to determine if the browser is capable of
// converting a NodeList to an array using builtin methods.
// Also verifies that the returned array holds DOM nodes
// (which is not the case in the Blackberry browser)
try {
	Array.prototype.slice.call( document.documentElement.childNodes, 0 )[0].nodeType;

// Provide a fallback method if it does not work
} catch( e ) {
	makeArray = function( array, results ) {
		var i = 0,
			ret = results || [];

		if ( toString.call(array) === "[object Array]" ) {
			Array.prototype.push.apply( ret, array );

		} else {
			if ( typeof array.length === "number" ) {
				for ( var l = array.length; i < l; i++ ) {
					ret.push( array[i] );
				}

			} else {
				for ( ; array[i]; i++ ) {
					ret.push( array[i] );
				}
			}
		}

		return ret;
	};
}

var sortOrder, siblingCheck;

if ( document.documentElement.compareDocumentPosition ) {
	sortOrder = function( a, b ) {
		if ( a === b ) {
			hasDuplicate = true;
			return 0;
		}

		if ( !a.compareDocumentPosition || !b.compareDocumentPosition ) {
			return a.compareDocumentPosition ? -1 : 1;
		}

		return a.compareDocumentPosition(b) & 4 ? -1 : 1;
	};

} else {
	sortOrder = function( a, b ) {
		// The nodes are identical, we can exit early
		if ( a === b ) {
			hasDuplicate = true;
			return 0;

		// Fallback to using sourceIndex (in IE) if it's available on both nodes
		} else if ( a.sourceIndex && b.sourceIndex ) {
			return a.sourceIndex - b.sourceIndex;
		}

		var al, bl,
			ap = [],
			bp = [],
			aup = a.parentNode,
			bup = b.parentNode,
			cur = aup;

		// If the nodes are siblings (or identical) we can do a quick check
		if ( aup === bup ) {
			return siblingCheck( a, b );

		// If no parents were found then the nodes are disconnected
		} else if ( !aup ) {
			return -1;

		} else if ( !bup ) {
			return 1;
		}

		// Otherwise they're somewhere else in the tree so we need
		// to build up a full list of the parentNodes for comparison
		while ( cur ) {
			ap.unshift( cur );
			cur = cur.parentNode;
		}

		cur = bup;

		while ( cur ) {
			bp.unshift( cur );
			cur = cur.parentNode;
		}

		al = ap.length;
		bl = bp.length;

		// Start walking down the tree looking for a discrepancy
		for ( var i = 0; i < al && i < bl; i++ ) {
			if ( ap[i] !== bp[i] ) {
				return siblingCheck( ap[i], bp[i] );
			}
		}

		// We ended someplace up the tree so do a sibling check
		return i === al ?
			siblingCheck( a, bp[i], -1 ) :
			siblingCheck( ap[i], b, 1 );
	};

	siblingCheck = function( a, b, ret ) {
		if ( a === b ) {
			return ret;
		}

		var cur = a.nextSibling;

		while ( cur ) {
			if ( cur === b ) {
				return -1;
			}

			cur = cur.nextSibling;
		}

		return 1;
	};
}

// Utility function for retreiving the text value of an array of DOM nodes
Sizzle.getText = function( elems ) {
	var ret = "", elem;

	for ( var i = 0; elems[i]; i++ ) {
		elem = elems[i];

		// Get the text from text nodes and CDATA nodes
		if ( elem.nodeType === 3 || elem.nodeType === 4 ) {
			ret += elem.nodeValue;

		// Traverse everything else, except comment nodes
		} else if ( elem.nodeType !== 8 ) {
			ret += Sizzle.getText( elem.childNodes );
		}
	}

	return ret;
};

// Check to see if the browser returns elements by name when
// querying by getElementById (and provide a workaround)
(function(){
	// We're going to inject a fake input element with a specified name
	var form = document.createElement("div"),
		id = "script" + (new Date()).getTime(),
		root = document.documentElement;

	form.innerHTML = "<a name='" + id + "'/>";

	// Inject it into the root element, check its status, and remove it quickly
	root.insertBefore( form, root.firstChild );

	// The workaround has to do additional checks after a getElementById
	// Which slows things down for other browsers (hence the branching)
	if ( document.getElementById( id ) ) {
		Expr.find.ID = function( match, context, isXML ) {
			if ( typeof context.getElementById !== "undefined" && !isXML ) {
				var m = context.getElementById(match[1]);

				return m ?
					m.id === match[1] || typeof m.getAttributeNode !== "undefined" && m.getAttributeNode("id").nodeValue === match[1] ?
						[m] :
						undefined :
					[];
			}
		};

		Expr.filter.ID = function( elem, match ) {
			var node = typeof elem.getAttributeNode !== "undefined" && elem.getAttributeNode("id");

			return elem.nodeType === 1 && node && node.nodeValue === match;
		};
	}

	root.removeChild( form );

	// release memory in IE
	root = form = null;
})();

(function(){
	// Check to see if the browser returns only elements
	// when doing getElementsByTagName("*")

	// Create a fake element
	var div = document.createElement("div");
	div.appendChild( document.createComment("") );

	// Make sure no comments are found
	if ( div.getElementsByTagName("*").length > 0 ) {
		Expr.find.TAG = function( match, context ) {
			var results = context.getElementsByTagName( match[1] );

			// Filter out possible comments
			if ( match[1] === "*" ) {
				var tmp = [];

				for ( var i = 0; results[i]; i++ ) {
					if ( results[i].nodeType === 1 ) {
						tmp.push( results[i] );
					}
				}

				results = tmp;
			}

			return results;
		};
	}

	// Check to see if an attribute returns normalized href attributes
	div.innerHTML = "<a href='#'></a>";

	if ( div.firstChild && typeof div.firstChild.getAttribute !== "undefined" &&
			div.firstChild.getAttribute("href") !== "#" ) {

		Expr.attrHandle.href = function( elem ) {
			return elem.getAttribute( "href", 2 );
		};
	}

	// release memory in IE
	div = null;
})();

if ( document.querySelectorAll ) {
	(function(){
		var oldSizzle = Sizzle,
			div = document.createElement("div"),
			id = "__sizzle__";

		div.innerHTML = "<p class='TEST'></p>";

		// Safari can't handle uppercase or unicode characters when
		// in quirks mode.
		if ( div.querySelectorAll && div.querySelectorAll(".TEST").length === 0 ) {
			return;
		}
	
		Sizzle = function( query, context, extra, seed ) {
			context = context || document;

			// Only use querySelectorAll on non-XML documents
			// (ID selectors don't work in non-HTML documents)
			if ( !seed && !Sizzle.isXML(context) ) {
				// See if we find a selector to speed up
				var match = /^(\w+$)|^\.([\w\-]+$)|^#([\w\-]+$)/.exec( query );
				
				if ( match && (context.nodeType === 1 || context.nodeType === 9) ) {
					// Speed-up: Sizzle("TAG")
					if ( match[1] ) {
						return makeArray( context.getElementsByTagName( query ), extra );
					
					// Speed-up: Sizzle(".CLASS")
					} else if ( match[2] && Expr.find.CLASS && context.getElementsByClassName ) {
						return makeArray( context.getElementsByClassName( match[2] ), extra );
					}
				}
				
				if ( context.nodeType === 9 ) {
					// Speed-up: Sizzle("body")
					// The body element only exists once, optimize finding it
					if ( query === "body" && context.body ) {
						return makeArray( [ context.body ], extra );
						
					// Speed-up: Sizzle("#ID")
					} else if ( match && match[3] ) {
						var elem = context.getElementById( match[3] );

						// Check parentNode to catch when Blackberry 4.6 returns
						// nodes that are no longer in the document #6963
						if ( elem && elem.parentNode ) {
							// Handle the case where IE and Opera return items
							// by name instead of ID
							if ( elem.id === match[3] ) {
								return makeArray( [ elem ], extra );
							}
							
						} else {
							return makeArray( [], extra );
						}
					}
					
					try {
						return makeArray( context.querySelectorAll(query), extra );
					} catch(qsaError) {}

				// qSA works strangely on Element-rooted queries
				// We can work around this by specifying an extra ID on the root
				// and working up from there (Thanks to Andrew Dupont for the technique)
				// IE 8 doesn't work on object elements
				} else if ( context.nodeType === 1 && context.nodeName.toLowerCase() !== "object" ) {
					var oldContext = context,
						old = context.getAttribute( "id" ),
						nid = old || id,
						hasParent = context.parentNode,
						relativeHierarchySelector = /^\s*[+~]/.test( query );

					if ( !old ) {
						context.setAttribute( "id", nid );
					} else {
						nid = nid.replace( /'/g, "\\$&" );
					}
					if ( relativeHierarchySelector && hasParent ) {
						context = context.parentNode;
					}

					try {
						if ( !relativeHierarchySelector || hasParent ) {
							return makeArray( context.querySelectorAll( "[id='" + nid + "'] " + query ), extra );
						}

					} catch(pseudoError) {
					} finally {
						if ( !old ) {
							oldContext.removeAttribute( "id" );
						}
					}
				}
			}
		
			return oldSizzle(query, context, extra, seed);
		};

		for ( var prop in oldSizzle ) {
			Sizzle[ prop ] = oldSizzle[ prop ];
		}

		// release memory in IE
		div = null;
	})();
}

(function(){
	var html = document.documentElement,
		matches = html.matchesSelector || html.mozMatchesSelector || html.webkitMatchesSelector || html.msMatchesSelector;

	if ( matches ) {
		// Check to see if it's possible to do matchesSelector
		// on a disconnected node (IE 9 fails this)
		var disconnectedMatch = !matches.call( document.createElement( "div" ), "div" ),
			pseudoWorks = false;

		try {
			// This should fail with an exception
			// Gecko does not error, returns false instead
			matches.call( document.documentElement, "[test!='']:sizzle" );
	
		} catch( pseudoError ) {
			pseudoWorks = true;
		}

		Sizzle.matchesSelector = function( node, expr ) {
			// Make sure that attribute selectors are quoted
			expr = expr.replace(/\=\s*([^'"\]]*)\s*\]/g, "='$1']");

			if ( !Sizzle.isXML( node ) ) {
				try { 
					if ( pseudoWorks || !Expr.match.PSEUDO.test( expr ) && !/!=/.test( expr ) ) {
						var ret = matches.call( node, expr );

						// IE 9's matchesSelector returns false on disconnected nodes
						if ( ret || !disconnectedMatch ||
								// As well, disconnected nodes are said to be in a document
								// fragment in IE 9, so check for that
								node.document && node.document.nodeType !== 11 ) {
							return ret;
						}
					}
				} catch(e) {}
			}

			return Sizzle(expr, null, null, [node]).length > 0;
		};
	}
})();

(function(){
	var div = document.createElement("div");

	div.innerHTML = "<div class='test e'></div><div class='test'></div>";

	// Opera can't find a second classname (in 9.6)
	// Also, make sure that getElementsByClassName actually exists
	if ( !div.getElementsByClassName || div.getElementsByClassName("e").length === 0 ) {
		return;
	}

	// Safari caches class attributes, doesn't catch changes (in 3.2)
	div.lastChild.className = "e";

	if ( div.getElementsByClassName("e").length === 1 ) {
		return;
	}
	
	Expr.order.splice(1, 0, "CLASS");
	Expr.find.CLASS = function( match, context, isXML ) {
		if ( typeof context.getElementsByClassName !== "undefined" && !isXML ) {
			return context.getElementsByClassName(match[1]);
		}
	};

	// release memory in IE
	div = null;
})();

function dirNodeCheck( dir, cur, doneName, checkSet, nodeCheck, isXML ) {
	for ( var i = 0, l = checkSet.length; i < l; i++ ) {
		var elem = checkSet[i];

		if ( elem ) {
			var match = false;

			elem = elem[dir];

			while ( elem ) {
				if ( elem.sizcache === doneName ) {
					match = checkSet[elem.sizset];
					break;
				}

				if ( elem.nodeType === 1 && !isXML ){
					elem.sizcache = doneName;
					elem.sizset = i;
				}

				if ( elem.nodeName.toLowerCase() === cur ) {
					match = elem;
					break;
				}

				elem = elem[dir];
			}

			checkSet[i] = match;
		}
	}
}

function dirCheck( dir, cur, doneName, checkSet, nodeCheck, isXML ) {
	for ( var i = 0, l = checkSet.length; i < l; i++ ) {
		var elem = checkSet[i];

		if ( elem ) {
			var match = false;
			
			elem = elem[dir];

			while ( elem ) {
				if ( elem.sizcache === doneName ) {
					match = checkSet[elem.sizset];
					break;
				}

				if ( elem.nodeType === 1 ) {
					if ( !isXML ) {
						elem.sizcache = doneName;
						elem.sizset = i;
					}

					if ( typeof cur !== "string" ) {
						if ( elem === cur ) {
							match = true;
							break;
						}

					} else if ( Sizzle.filter( cur, [elem] ).length > 0 ) {
						match = elem;
						break;
					}
				}

				elem = elem[dir];
			}

			checkSet[i] = match;
		}
	}
}

if ( document.documentElement.contains ) {
	Sizzle.contains = function( a, b ) {
		return a !== b && (a.contains ? a.contains(b) : true);
	};

} else if ( document.documentElement.compareDocumentPosition ) {
	Sizzle.contains = function( a, b ) {
		return !!(a.compareDocumentPosition(b) & 16);
	};

} else {
	Sizzle.contains = function() {
		return false;
	};
}

Sizzle.isXML = function( elem ) {
	// documentElement is verified for cases where it doesn't yet exist
	// (such as loading iframes in IE - #4833) 
	var documentElement = (elem ? elem.ownerDocument || elem : 0).documentElement;

	return documentElement ? documentElement.nodeName !== "HTML" : false;
};

var posProcess = function( selector, context ) {
	var match,
		tmpSet = [],
		later = "",
		root = context.nodeType ? [context] : context;

	// Position selectors must be done after the filter
	// And so must :not(positional) so we move all PSEUDOs to the end
	while ( (match = Expr.match.PSEUDO.exec( selector )) ) {
		later += match[0];
		selector = selector.replace( Expr.match.PSEUDO, "" );
	}

	selector = Expr.relative[selector] ? selector + "*" : selector;

	for ( var i = 0, l = root.length; i < l; i++ ) {
		Sizzle( selector, root[i], tmpSet );
	}

	return Sizzle.filter( later, tmpSet );
};

// EXPOSE
jQuery.find = Sizzle;
jQuery.expr = Sizzle.selectors;
jQuery.expr[":"] = jQuery.expr.filters;
jQuery.unique = Sizzle.uniqueSort;
jQuery.text = Sizzle.getText;
jQuery.isXMLDoc = Sizzle.isXML;
jQuery.contains = Sizzle.contains;


})();


var runtil = /Until$/,
	rparentsprev = /^(?:parents|prevUntil|prevAll)/,
	// Note: This RegExp should be improved, or likely pulled from Sizzle
	rmultiselector = /,/,
	isSimple = /^.[^:#\[\.,]*$/,
	slice = Array.prototype.slice,
	POS = jQuery.expr.match.POS,
	// methods guaranteed to produce a unique set when starting from a unique set
	guaranteedUnique = {
		children: true,
		contents: true,
		next: true,
		prev: true
	};

jQuery.fn.extend({
	find: function( selector ) {
		var self = this,
			i, l;

		if ( typeof selector !== "string" ) {
			return jQuery( selector ).filter(function() {
				for ( i = 0, l = self.length; i < l; i++ ) {
					if ( jQuery.contains( self[ i ], this ) ) {
						return true;
					}
				}
			});
		}

		var ret = this.pushStack( "", "find", selector ),
			length, n, r;

		for ( i = 0, l = this.length; i < l; i++ ) {
			length = ret.length;
			jQuery.find( selector, this[i], ret );

			if ( i > 0 ) {
				// Make sure that the results are unique
				for ( n = length; n < ret.length; n++ ) {
					for ( r = 0; r < length; r++ ) {
						if ( ret[r] === ret[n] ) {
							ret.splice(n--, 1);
							break;
						}
					}
				}
			}
		}

		return ret;
	},

	has: function( target ) {
		var targets = jQuery( target );
		return this.filter(function() {
			for ( var i = 0, l = targets.length; i < l; i++ ) {
				if ( jQuery.contains( this, targets[i] ) ) {
					return true;
				}
			}
		});
	},

	not: function( selector ) {
		return this.pushStack( winnow(this, selector, false), "not", selector);
	},

	filter: function( selector ) {
		return this.pushStack( winnow(this, selector, true), "filter", selector );
	},

	is: function( selector ) {
		return !!selector && ( typeof selector === "string" ?
			jQuery.filter( selector, this ).length > 0 :
			this.filter( selector ).length > 0 );
	},

	closest: function( selectors, context ) {
		var ret = [], i, l, cur = this[0];
		
		// Array
		if ( jQuery.isArray( selectors ) ) {
			var match, selector,
				matches = {},
				level = 1;

			if ( cur && selectors.length ) {
				for ( i = 0, l = selectors.length; i < l; i++ ) {
					selector = selectors[i];

					if ( !matches[ selector ] ) {
						matches[ selector ] = POS.test( selector ) ?
							jQuery( selector, context || this.context ) :
							selector;
					}
				}

				while ( cur && cur.ownerDocument && cur !== context ) {
					for ( selector in matches ) {
						match = matches[ selector ];

						if ( match.jquery ? match.index( cur ) > -1 : jQuery( cur ).is( match ) ) {
							ret.push({ selector: selector, elem: cur, level: level });
						}
					}

					cur = cur.parentNode;
					level++;
				}
			}

			return ret;
		}

		// String
		var pos = POS.test( selectors ) || typeof selectors !== "string" ?
				jQuery( selectors, context || this.context ) :
				0;

		for ( i = 0, l = this.length; i < l; i++ ) {
			cur = this[i];

			while ( cur ) {
				if ( pos ? pos.index(cur) > -1 : jQuery.find.matchesSelector(cur, selectors) ) {
					ret.push( cur );
					break;

				} else {
					cur = cur.parentNode;
					if ( !cur || !cur.ownerDocument || cur === context || cur.nodeType === 11 ) {
						break;
					}
				}
			}
		}

		ret = ret.length > 1 ? jQuery.unique( ret ) : ret;

		return this.pushStack( ret, "closest", selectors );
	},

	// Determine the position of an element within
	// the matched set of elements
	index: function( elem ) {
		if ( !elem || typeof elem === "string" ) {
			return jQuery.inArray( this[0],
				// If it receives a string, the selector is used
				// If it receives nothing, the siblings are used
				elem ? jQuery( elem ) : this.parent().children() );
		}
		// Locate the position of the desired element
		return jQuery.inArray(
			// If it receives a jQuery object, the first element is used
			elem.jquery ? elem[0] : elem, this );
	},

	add: function( selector, context ) {
		var set = typeof selector === "string" ?
				jQuery( selector, context ) :
				jQuery.makeArray( selector && selector.nodeType ? [ selector ] : selector ),
			all = jQuery.merge( this.get(), set );

		return this.pushStack( isDisconnected( set[0] ) || isDisconnected( all[0] ) ?
			all :
			jQuery.unique( all ) );
	},

	andSelf: function() {
		return this.add( this.prevObject );
	}
});

// A painfully simple check to see if an element is disconnected
// from a document (should be improved, where feasible).
function isDisconnected( node ) {
	return !node || !node.parentNode || node.parentNode.nodeType === 11;
}

jQuery.each({
	parent: function( elem ) {
		var parent = elem.parentNode;
		return parent && parent.nodeType !== 11 ? parent : null;
	},
	parents: function( elem ) {
		return jQuery.dir( elem, "parentNode" );
	},
	parentsUntil: function( elem, i, until ) {
		return jQuery.dir( elem, "parentNode", until );
	},
	next: function( elem ) {
		return jQuery.nth( elem, 2, "nextSibling" );
	},
	prev: function( elem ) {
		return jQuery.nth( elem, 2, "previousSibling" );
	},
	nextAll: function( elem ) {
		return jQuery.dir( elem, "nextSibling" );
	},
	prevAll: function( elem ) {
		return jQuery.dir( elem, "previousSibling" );
	},
	nextUntil: function( elem, i, until ) {
		return jQuery.dir( elem, "nextSibling", until );
	},
	prevUntil: function( elem, i, until ) {
		return jQuery.dir( elem, "previousSibling", until );
	},
	siblings: function( elem ) {
		return jQuery.sibling( elem.parentNode.firstChild, elem );
	},
	children: function( elem ) {
		return jQuery.sibling( elem.firstChild );
	},
	contents: function( elem ) {
		return jQuery.nodeName( elem, "iframe" ) ?
			elem.contentDocument || elem.contentWindow.document :
			jQuery.makeArray( elem.childNodes );
	}
}, function( name, fn ) {
	jQuery.fn[ name ] = function( until, selector ) {
		var ret = jQuery.map( this, fn, until ),
			// The variable 'args' was introduced in
			// https://github.com/jquery/jquery/commit/52a0238
			// to work around a bug in Chrome 10 (Dev) and should be removed when the bug is fixed.
			// http://code.google.com/p/v8/issues/detail?id=1050
			args = slice.call(arguments);

		if ( !runtil.test( name ) ) {
			selector = until;
		}

		if ( selector && typeof selector === "string" ) {
			ret = jQuery.filter( selector, ret );
		}

		ret = this.length > 1 && !guaranteedUnique[ name ] ? jQuery.unique( ret ) : ret;

		if ( (this.length > 1 || rmultiselector.test( selector )) && rparentsprev.test( name ) ) {
			ret = ret.reverse();
		}

		return this.pushStack( ret, name, args.join(",") );
	};
});

jQuery.extend({
	filter: function( expr, elems, not ) {
		if ( not ) {
			expr = ":not(" + expr + ")";
		}

		return elems.length === 1 ?
			jQuery.find.matchesSelector(elems[0], expr) ? [ elems[0] ] : [] :
			jQuery.find.matches(expr, elems);
	},

	dir: function( elem, dir, until ) {
		var matched = [],
			cur = elem[ dir ];

		while ( cur && cur.nodeType !== 9 && (until === undefined || cur.nodeType !== 1 || !jQuery( cur ).is( until )) ) {
			if ( cur.nodeType === 1 ) {
				matched.push( cur );
			}
			cur = cur[dir];
		}
		return matched;
	},

	nth: function( cur, result, dir, elem ) {
		result = result || 1;
		var num = 0;

		for ( ; cur; cur = cur[dir] ) {
			if ( cur.nodeType === 1 && ++num === result ) {
				break;
			}
		}

		return cur;
	},

	sibling: function( n, elem ) {
		var r = [];

		for ( ; n; n = n.nextSibling ) {
			if ( n.nodeType === 1 && n !== elem ) {
				r.push( n );
			}
		}

		return r;
	}
});

// Implement the identical functionality for filter and not
function winnow( elements, qualifier, keep ) {

	// Can't pass null or undefined to indexOf in Firefox 4
	// Set to 0 to skip string check
	qualifier = qualifier || 0;

	if ( jQuery.isFunction( qualifier ) ) {
		return jQuery.grep(elements, function( elem, i ) {
			var retVal = !!qualifier.call( elem, i, elem );
			return retVal === keep;
		});

	} else if ( qualifier.nodeType ) {
		return jQuery.grep(elements, function( elem, i ) {
			return (elem === qualifier) === keep;
		});

	} else if ( typeof qualifier === "string" ) {
		var filtered = jQuery.grep(elements, function( elem ) {
			return elem.nodeType === 1;
		});

		if ( isSimple.test( qualifier ) ) {
			return jQuery.filter(qualifier, filtered, !keep);
		} else {
			qualifier = jQuery.filter( qualifier, filtered );
		}
	}

	return jQuery.grep(elements, function( elem, i ) {
		return (jQuery.inArray( elem, qualifier ) >= 0) === keep;
	});
}




var rinlinejQuery = / jQuery\d+="(?:\d+|null)"/g,
	rleadingWhitespace = /^\s+/,
	rxhtmlTag = /<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/ig,
	rtagName = /<([\w:]+)/,
	rtbody = /<tbody/i,
	rhtml = /<|&#?\w+;/,
	rnocache = /<(?:script|object|embed|option|style)/i,
	// checked="checked" or checked
	rchecked = /checked\s*(?:[^=]|=\s*.checked.)/i,
	rscriptType = /\/(java|ecma)script/i,
	rcleanScript = /^\s*<!(?:\[CDATA\[|\-\-)/,
	wrapMap = {
		option: [ 1, "<select multiple='multiple'>", "</select>" ],
		legend: [ 1, "<fieldset>", "</fieldset>" ],
		thead: [ 1, "<table>", "</table>" ],
		tr: [ 2, "<table><tbody>", "</tbody></table>" ],
		td: [ 3, "<table><tbody><tr>", "</tr></tbody></table>" ],
		col: [ 2, "<table><tbody></tbody><colgroup>", "</colgroup></table>" ],
		area: [ 1, "<map>", "</map>" ],
		_default: [ 0, "", "" ]
	};

wrapMap.optgroup = wrapMap.option;
wrapMap.tbody = wrapMap.tfoot = wrapMap.colgroup = wrapMap.caption = wrapMap.thead;
wrapMap.th = wrapMap.td;

// IE can't serialize <link> and <script> tags normally
if ( !jQuery.support.htmlSerialize ) {
	wrapMap._default = [ 1, "div<div>", "</div>" ];
}

jQuery.fn.extend({
	text: function( text ) {
		if ( jQuery.isFunction(text) ) {
			return this.each(function(i) {
				var self = jQuery( this );

				self.text( text.call(this, i, self.text()) );
			});
		}

		if ( typeof text !== "object" && text !== undefined ) {
			return this.empty().append( (this[0] && this[0].ownerDocument || document).createTextNode( text ) );
		}

		return jQuery.text( this );
	},

	wrapAll: function( html ) {
		if ( jQuery.isFunction( html ) ) {
			return this.each(function(i) {
				jQuery(this).wrapAll( html.call(this, i) );
			});
		}

		if ( this[0] ) {
			// The elements to wrap the target around
			var wrap = jQuery( html, this[0].ownerDocument ).eq(0).clone(true);

			if ( this[0].parentNode ) {
				wrap.insertBefore( this[0] );
			}

			wrap.map(function() {
				var elem = this;

				while ( elem.firstChild && elem.firstChild.nodeType === 1 ) {
					elem = elem.firstChild;
				}

				return elem;
			}).append( this );
		}

		return this;
	},

	wrapInner: function( html ) {
		if ( jQuery.isFunction( html ) ) {
			return this.each(function(i) {
				jQuery(this).wrapInner( html.call(this, i) );
			});
		}

		return this.each(function() {
			var self = jQuery( this ),
				contents = self.contents();

			if ( contents.length ) {
				contents.wrapAll( html );

			} else {
				self.append( html );
			}
		});
	},

	wrap: function( html ) {
		return this.each(function() {
			jQuery( this ).wrapAll( html );
		});
	},

	unwrap: function() {
		return this.parent().each(function() {
			if ( !jQuery.nodeName( this, "body" ) ) {
				jQuery( this ).replaceWith( this.childNodes );
			}
		}).end();
	},

	append: function() {
		return this.domManip(arguments, true, function( elem ) {
			if ( this.nodeType === 1 ) {
				this.appendChild( elem );
			}
		});
	},

	prepend: function() {
		return this.domManip(arguments, true, function( elem ) {
			if ( this.nodeType === 1 ) {
				this.insertBefore( elem, this.firstChild );
			}
		});
	},

	before: function() {
		if ( this[0] && this[0].parentNode ) {
			return this.domManip(arguments, false, function( elem ) {
				this.parentNode.insertBefore( elem, this );
			});
		} else if ( arguments.length ) {
			var set = jQuery(arguments[0]);
			set.push.apply( set, this.toArray() );
			return this.pushStack( set, "before", arguments );
		}
	},

	after: function() {
		if ( this[0] && this[0].parentNode ) {
			return this.domManip(arguments, false, function( elem ) {
				this.parentNode.insertBefore( elem, this.nextSibling );
			});
		} else if ( arguments.length ) {
			var set = this.pushStack( this, "after", arguments );
			set.push.apply( set, jQuery(arguments[0]).toArray() );
			return set;
		}
	},

	// keepData is for internal use only--do not document
	remove: function( selector, keepData ) {
		for ( var i = 0, elem; (elem = this[i]) != null; i++ ) {
			if ( !selector || jQuery.filter( selector, [ elem ] ).length ) {
				if ( !keepData && elem.nodeType === 1 ) {
					jQuery.cleanData( elem.getElementsByTagName("*") );
					jQuery.cleanData( [ elem ] );
				}

				if ( elem.parentNode ) {
					elem.parentNode.removeChild( elem );
				}
			}
		}

		return this;
	},

	empty: function() {
		for ( var i = 0, elem; (elem = this[i]) != null; i++ ) {
			// Remove element nodes and prevent memory leaks
			if ( elem.nodeType === 1 ) {
				jQuery.cleanData( elem.getElementsByTagName("*") );
			}

			// Remove any remaining nodes
			while ( elem.firstChild ) {
				elem.removeChild( elem.firstChild );
			}
		}

		return this;
	},

	clone: function( dataAndEvents, deepDataAndEvents ) {
		dataAndEvents = dataAndEvents == null ? false : dataAndEvents;
		deepDataAndEvents = deepDataAndEvents == null ? dataAndEvents : deepDataAndEvents;

		return this.map( function () {
			return jQuery.clone( this, dataAndEvents, deepDataAndEvents );
		});
	},

	html: function( value ) {
		if ( value === undefined ) {
			return this[0] && this[0].nodeType === 1 ?
				this[0].innerHTML.replace(rinlinejQuery, "") :
				null;

		// See if we can take a shortcut and just use innerHTML
		} else if ( typeof value === "string" && !rnocache.test( value ) &&
			(jQuery.support.leadingWhitespace || !rleadingWhitespace.test( value )) &&
			!wrapMap[ (rtagName.exec( value ) || ["", ""])[1].toLowerCase() ] ) {

			value = value.replace(rxhtmlTag, "<$1></$2>");

			try {
				for ( var i = 0, l = this.length; i < l; i++ ) {
					// Remove element nodes and prevent memory leaks
					if ( this[i].nodeType === 1 ) {
						jQuery.cleanData( this[i].getElementsByTagName("*") );
						this[i].innerHTML = value;
					}
				}

			// If using innerHTML throws an exception, use the fallback method
			} catch(e) {
				this.empty().append( value );
			}

		} else if ( jQuery.isFunction( value ) ) {
			this.each(function(i){
				var self = jQuery( this );

				self.html( value.call(this, i, self.html()) );
			});

		} else {
			this.empty().append( value );
		}

		return this;
	},

	replaceWith: function( value ) {
		if ( this[0] && this[0].parentNode ) {
			// Make sure that the elements are removed from the DOM before they are inserted
			// this can help fix replacing a parent with child elements
			if ( jQuery.isFunction( value ) ) {
				return this.each(function(i) {
					var self = jQuery(this), old = self.html();
					self.replaceWith( value.call( this, i, old ) );
				});
			}

			if ( typeof value !== "string" ) {
				value = jQuery( value ).detach();
			}

			return this.each(function() {
				var next = this.nextSibling,
					parent = this.parentNode;

				jQuery( this ).remove();

				if ( next ) {
					jQuery(next).before( value );
				} else {
					jQuery(parent).append( value );
				}
			});
		} else {
			return this.length ?
				this.pushStack( jQuery(jQuery.isFunction(value) ? value() : value), "replaceWith", value ) :
				this;
		}
	},

	detach: function( selector ) {
		return this.remove( selector, true );
	},

	domManip: function( args, table, callback ) {
		var results, first, fragment, parent,
			value = args[0],
			scripts = [];

		// We can't cloneNode fragments that contain checked, in WebKit
		if ( !jQuery.support.checkClone && arguments.length === 3 && typeof value === "string" && rchecked.test( value ) ) {
			return this.each(function() {
				jQuery(this).domManip( args, table, callback, true );
			});
		}

		if ( jQuery.isFunction(value) ) {
			return this.each(function(i) {
				var self = jQuery(this);
				args[0] = value.call(this, i, table ? self.html() : undefined);
				self.domManip( args, table, callback );
			});
		}

		if ( this[0] ) {
			parent = value && value.parentNode;

			// If we're in a fragment, just use that instead of building a new one
			if ( jQuery.support.parentNode && parent && parent.nodeType === 11 && parent.childNodes.length === this.length ) {
				results = { fragment: parent };

			} else {
				results = jQuery.buildFragment( args, this, scripts );
			}

			fragment = results.fragment;

			if ( fragment.childNodes.length === 1 ) {
				first = fragment = fragment.firstChild;
			} else {
				first = fragment.firstChild;
			}

			if ( first ) {
				table = table && jQuery.nodeName( first, "tr" );

				for ( var i = 0, l = this.length, lastIndex = l - 1; i < l; i++ ) {
					callback.call(
						table ?
							root(this[i], first) :
							this[i],
						// Make sure that we do not leak memory by inadvertently discarding
						// the original fragment (which might have attached data) instead of
						// using it; in addition, use the original fragment object for the last
						// item instead of first because it can end up being emptied incorrectly
						// in certain situations (Bug #8070).
						// Fragments from the fragment cache must always be cloned and never used
						// in place.
						results.cacheable || (l > 1 && i < lastIndex) ?
							jQuery.clone( fragment, true, true ) :
							fragment
					);
				}
			}

			if ( scripts.length ) {
				jQuery.each( scripts, evalScript );
			}
		}

		return this;
	}
});

function root( elem, cur ) {
	return jQuery.nodeName(elem, "table") ?
		(elem.getElementsByTagName("tbody")[0] ||
		elem.appendChild(elem.ownerDocument.createElement("tbody"))) :
		elem;
}

function cloneCopyEvent( src, dest ) {

	if ( dest.nodeType !== 1 || !jQuery.hasData( src ) ) {
		return;
	}

	var internalKey = jQuery.expando,
		oldData = jQuery.data( src ),
		curData = jQuery.data( dest, oldData );

	// Switch to use the internal data object, if it exists, for the next
	// stage of data copying
	if ( (oldData = oldData[ internalKey ]) ) {
		var events = oldData.events;
				curData = curData[ internalKey ] = jQuery.extend({}, oldData);

		if ( events ) {
			delete curData.handle;
			curData.events = {};

			for ( var type in events ) {
				for ( var i = 0, l = events[ type ].length; i < l; i++ ) {
					jQuery.event.add( dest, type + ( events[ type ][ i ].namespace ? "." : "" ) + events[ type ][ i ].namespace, events[ type ][ i ], events[ type ][ i ].data );
				}
			}
		}
	}
}

function cloneFixAttributes( src, dest ) {
	var nodeName;

	// We do not need to do anything for non-Elements
	if ( dest.nodeType !== 1 ) {
		return;
	}

	// clearAttributes removes the attributes, which we don't want,
	// but also removes the attachEvent events, which we *do* want
	if ( dest.clearAttributes ) {
		dest.clearAttributes();
	}

	// mergeAttributes, in contrast, only merges back on the
	// original attributes, not the events
	if ( dest.mergeAttributes ) {
		dest.mergeAttributes( src );
	}

	nodeName = dest.nodeName.toLowerCase();

	// IE6-8 fail to clone children inside object elements that use
	// the proprietary classid attribute value (rather than the type
	// attribute) to identify the type of content to display
	if ( nodeName === "object" ) {
		dest.outerHTML = src.outerHTML;

	} else if ( nodeName === "input" && (src.type === "checkbox" || src.type === "radio") ) {
		// IE6-8 fails to persist the checked state of a cloned checkbox
		// or radio button. Worse, IE6-7 fail to give the cloned element
		// a checked appearance if the defaultChecked value isn't also set
		if ( src.checked ) {
			dest.defaultChecked = dest.checked = src.checked;
		}

		// IE6-7 get confused and end up setting the value of a cloned
		// checkbox/radio button to an empty string instead of "on"
		if ( dest.value !== src.value ) {
			dest.value = src.value;
		}

	// IE6-8 fails to return the selected option to the default selected
	// state when cloning options
	} else if ( nodeName === "option" ) {
		dest.selected = src.defaultSelected;

	// IE6-8 fails to set the defaultValue to the correct value when
	// cloning other types of input fields
	} else if ( nodeName === "input" || nodeName === "textarea" ) {
		dest.defaultValue = src.defaultValue;
	}

	// Event data gets referenced instead of copied if the expando
	// gets copied too
	dest.removeAttribute( jQuery.expando );
}

jQuery.buildFragment = function( args, nodes, scripts ) {
	var fragment, cacheable, cacheresults, doc;

  // nodes may contain either an explicit document object,
  // a jQuery collection or context object.
  // If nodes[0] contains a valid object to assign to doc
  if ( nodes && nodes[0] ) {
    doc = nodes[0].ownerDocument || nodes[0];
  }

  // Ensure that an attr object doesn't incorrectly stand in as a document object
	// Chrome and Firefox seem to allow this to occur and will throw exception
	// Fixes #8950
	if ( !doc.createDocumentFragment ) {
		doc = document;
	}

	// Only cache "small" (1/2 KB) HTML strings that are associated with the main document
	// Cloning options loses the selected state, so don't cache them
	// IE 6 doesn't like it when you put <object> or <embed> elements in a fragment
	// Also, WebKit does not clone 'checked' attributes on cloneNode, so don't cache
	if ( args.length === 1 && typeof args[0] === "string" && args[0].length < 512 && doc === document &&
		args[0].charAt(0) === "<" && !rnocache.test( args[0] ) && (jQuery.support.checkClone || !rchecked.test( args[0] )) ) {

		cacheable = true;

		cacheresults = jQuery.fragments[ args[0] ];
		if ( cacheresults && cacheresults !== 1 ) {
			fragment = cacheresults;
		}
	}

	if ( !fragment ) {
		fragment = doc.createDocumentFragment();
		jQuery.clean( args, doc, fragment, scripts );
	}

	if ( cacheable ) {
		jQuery.fragments[ args[0] ] = cacheresults ? fragment : 1;
	}

	return { fragment: fragment, cacheable: cacheable };
};

jQuery.fragments = {};

jQuery.each({
	appendTo: "append",
	prependTo: "prepend",
	insertBefore: "before",
	insertAfter: "after",
	replaceAll: "replaceWith"
}, function( name, original ) {
	jQuery.fn[ name ] = function( selector ) {
		var ret = [],
			insert = jQuery( selector ),
			parent = this.length === 1 && this[0].parentNode;

		if ( parent && parent.nodeType === 11 && parent.childNodes.length === 1 && insert.length === 1 ) {
			insert[ original ]( this[0] );
			return this;

		} else {
			for ( var i = 0, l = insert.length; i < l; i++ ) {
				var elems = (i > 0 ? this.clone(true) : this).get();
				jQuery( insert[i] )[ original ]( elems );
				ret = ret.concat( elems );
			}

			return this.pushStack( ret, name, insert.selector );
		}
	};
});

function getAll( elem ) {
	if ( "getElementsByTagName" in elem ) {
		return elem.getElementsByTagName( "*" );

	} else if ( "querySelectorAll" in elem ) {
		return elem.querySelectorAll( "*" );

	} else {
		return [];
	}
}

// Used in clean, fixes the defaultChecked property
function fixDefaultChecked( elem ) {
	if ( elem.type === "checkbox" || elem.type === "radio" ) {
		elem.defaultChecked = elem.checked;
	}
}
// Finds all inputs and passes them to fixDefaultChecked
function findInputs( elem ) {
	if ( jQuery.nodeName( elem, "input" ) ) {
		fixDefaultChecked( elem );
	} else if ( "getElementsByTagName" in elem ) {
		jQuery.grep( elem.getElementsByTagName("input"), fixDefaultChecked );
	}
}

jQuery.extend({
	clone: function( elem, dataAndEvents, deepDataAndEvents ) {
		var clone = elem.cloneNode(true),
				srcElements,
				destElements,
				i;

		if ( (!jQuery.support.noCloneEvent || !jQuery.support.noCloneChecked) &&
				(elem.nodeType === 1 || elem.nodeType === 11) && !jQuery.isXMLDoc(elem) ) {
			// IE copies events bound via attachEvent when using cloneNode.
			// Calling detachEvent on the clone will also remove the events
			// from the original. In order to get around this, we use some
			// proprietary methods to clear the events. Thanks to MooTools
			// guys for this hotness.

			cloneFixAttributes( elem, clone );

			// Using Sizzle here is crazy slow, so we use getElementsByTagName
			// instead
			srcElements = getAll( elem );
			destElements = getAll( clone );

			// Weird iteration because IE will replace the length property
			// with an element if you are cloning the body and one of the
			// elements on the page has a name or id of "length"
			for ( i = 0; srcElements[i]; ++i ) {
				cloneFixAttributes( srcElements[i], destElements[i] );
			}
		}

		// Copy the events from the original to the clone
		if ( dataAndEvents ) {
			cloneCopyEvent( elem, clone );

			if ( deepDataAndEvents ) {
				srcElements = getAll( elem );
				destElements = getAll( clone );

				for ( i = 0; srcElements[i]; ++i ) {
					cloneCopyEvent( srcElements[i], destElements[i] );
				}
			}
		}

		srcElements = destElements = null;

		// Return the cloned set
		return clone;
	},

	clean: function( elems, context, fragment, scripts ) {
		var checkScriptType;

		context = context || document;

		// !context.createElement fails in IE with an error but returns typeof 'object'
		if ( typeof context.createElement === "undefined" ) {
			context = context.ownerDocument || context[0] && context[0].ownerDocument || document;
		}

		var ret = [], j;

		for ( var i = 0, elem; (elem = elems[i]) != null; i++ ) {
			if ( typeof elem === "number" ) {
				elem += "";
			}

			if ( !elem ) {
				continue;
			}

			// Convert html string into DOM nodes
			if ( typeof elem === "string" ) {
				if ( !rhtml.test( elem ) ) {
					elem = context.createTextNode( elem );
				} else {
					// Fix "XHTML"-style tags in all browsers
					elem = elem.replace(rxhtmlTag, "<$1></$2>");

					// Trim whitespace, otherwise indexOf won't work as expected
					var tag = (rtagName.exec( elem ) || ["", ""])[1].toLowerCase(),
						wrap = wrapMap[ tag ] || wrapMap._default,
						depth = wrap[0],
						div = context.createElement("div");

					// Go to html and back, then peel off extra wrappers
					div.innerHTML = wrap[1] + elem + wrap[2];

					// Move to the right depth
					while ( depth-- ) {
						div = div.lastChild;
					}

					// Remove IE's autoinserted <tbody> from table fragments
					if ( !jQuery.support.tbody ) {

						// String was a <table>, *may* have spurious <tbody>
						var hasBody = rtbody.test(elem),
							tbody = tag === "table" && !hasBody ?
								div.firstChild && div.firstChild.childNodes :

								// String was a bare <thead> or <tfoot>
								wrap[1] === "<table>" && !hasBody ?
									div.childNodes :
									[];

						for ( j = tbody.length - 1; j >= 0 ; --j ) {
							if ( jQuery.nodeName( tbody[ j ], "tbody" ) && !tbody[ j ].childNodes.length ) {
								tbody[ j ].parentNode.removeChild( tbody[ j ] );
							}
						}
					}

					// IE completely kills leading whitespace when innerHTML is used
					if ( !jQuery.support.leadingWhitespace && rleadingWhitespace.test( elem ) ) {
						div.insertBefore( context.createTextNode( rleadingWhitespace.exec(elem)[0] ), div.firstChild );
					}

					elem = div.childNodes;
				}
			}

			// Resets defaultChecked for any radios and checkboxes
			// about to be appended to the DOM in IE 6/7 (#8060)
			var len;
			if ( !jQuery.support.appendChecked ) {
				if ( elem[0] && typeof (len = elem.length) === "number" ) {
					for ( j = 0; j < len; j++ ) {
						findInputs( elem[j] );
					}
				} else {
					findInputs( elem );
				}
			}

			if ( elem.nodeType ) {
				ret.push( elem );
			} else {
				ret = jQuery.merge( ret, elem );
			}
		}

		if ( fragment ) {
			checkScriptType = function( elem ) {
				return !elem.type || rscriptType.test( elem.type );
			};
			for ( i = 0; ret[i]; i++ ) {
				if ( scripts && jQuery.nodeName( ret[i], "script" ) && (!ret[i].type || ret[i].type.toLowerCase() === "text/javascript") ) {
					scripts.push( ret[i].parentNode ? ret[i].parentNode.removeChild( ret[i] ) : ret[i] );

				} else {
					if ( ret[i].nodeType === 1 ) {
						var jsTags = jQuery.grep( ret[i].getElementsByTagName( "script" ), checkScriptType );

						ret.splice.apply( ret, [i + 1, 0].concat( jsTags ) );
					}
					fragment.appendChild( ret[i] );
				}
			}
		}

		return ret;
	},

	cleanData: function( elems ) {
		var data, id, cache = jQuery.cache, internalKey = jQuery.expando, special = jQuery.event.special,
			deleteExpando = jQuery.support.deleteExpando;

		for ( var i = 0, elem; (elem = elems[i]) != null; i++ ) {
			if ( elem.nodeName && jQuery.noData[elem.nodeName.toLowerCase()] ) {
				continue;
			}

			id = elem[ jQuery.expando ];

			if ( id ) {
				data = cache[ id ] && cache[ id ][ internalKey ];

				if ( data && data.events ) {
					for ( var type in data.events ) {
						if ( special[ type ] ) {
							jQuery.event.remove( elem, type );

						// This is a shortcut to avoid jQuery.event.remove's overhead
						} else {
							jQuery.removeEvent( elem, type, data.handle );
						}
					}

					// Null the DOM reference to avoid IE6/7/8 leak (#7054)
					if ( data.handle ) {
						data.handle.elem = null;
					}
				}

				if ( deleteExpando ) {
					delete elem[ jQuery.expando ];

				} else if ( elem.removeAttribute ) {
					elem.removeAttribute( jQuery.expando );
				}

				delete cache[ id ];
			}
		}
	}
});

function evalScript( i, elem ) {
	if ( elem.src ) {
		jQuery.ajax({
			url: elem.src,
			async: false,
			dataType: "script"
		});
	} else {
		jQuery.globalEval( ( elem.text || elem.textContent || elem.innerHTML || "" ).replace( rcleanScript, "/*$0*/" ) );
	}

	if ( elem.parentNode ) {
		elem.parentNode.removeChild( elem );
	}
}



var ralpha = /alpha\([^)]*\)/i,
	ropacity = /opacity=([^)]*)/,
	// fixed for IE9, see #8346
	rupper = /([A-Z]|^ms)/g,
	rnumpx = /^-?\d+(?:px)?$/i,
	rnum = /^-?\d/,
	rrelNum = /^[+\-]=/,
	rrelNumFilter = /[^+\-\.\de]+/g,

	cssShow = { position: "absolute", visibility: "hidden", display: "block" },
	cssWidth = [ "Left", "Right" ],
	cssHeight = [ "Top", "Bottom" ],
	curCSS,

	getComputedStyle,
	currentStyle;

jQuery.fn.css = function( name, value ) {
	// Setting 'undefined' is a no-op
	if ( arguments.length === 2 && value === undefined ) {
		return this;
	}

	return jQuery.access( this, name, value, true, function( elem, name, value ) {
		return value !== undefined ?
			jQuery.style( elem, name, value ) :
			jQuery.css( elem, name );
	});
};

jQuery.extend({
	// Add in style property hooks for overriding the default
	// behavior of getting and setting a style property
	cssHooks: {
		opacity: {
			get: function( elem, computed ) {
				if ( computed ) {
					// We should always get a number back from opacity
					var ret = curCSS( elem, "opacity", "opacity" );
					return ret === "" ? "1" : ret;

				} else {
					return elem.style.opacity;
				}
			}
		}
	},

	// Exclude the following css properties to add px
	cssNumber: {
		"fillOpacity": true,
		"fontWeight": true,
		"lineHeight": true,
		"opacity": true,
		"orphans": true,
		"widows": true,
		"zIndex": true,
		"zoom": true
	},

	// Add in properties whose names you wish to fix before
	// setting or getting the value
	cssProps: {
		// normalize float css property
		"float": jQuery.support.cssFloat ? "cssFloat" : "styleFloat"
	},

	// Get and set the style property on a DOM Node
	style: function( elem, name, value, extra ) {
		// Don't set styles on text and comment nodes
		if ( !elem || elem.nodeType === 3 || elem.nodeType === 8 || !elem.style ) {
			return;
		}

		// Make sure that we're working with the right name
		var ret, type, origName = jQuery.camelCase( name ),
			style = elem.style, hooks = jQuery.cssHooks[ origName ];

		name = jQuery.cssProps[ origName ] || origName;

		// Check if we're setting a value
		if ( value !== undefined ) {
			type = typeof value;

			// Make sure that NaN and null values aren't set. See: #7116
			if ( type === "number" && isNaN( value ) || value == null ) {
				return;
			}

			// convert relative number strings (+= or -=) to relative numbers. #7345
			if ( type === "string" && rrelNum.test( value ) ) {
				value = +value.replace( rrelNumFilter, "" ) + parseFloat( jQuery.css( elem, name ) );
				// Fixes bug #9237
				type = "number";
			}

			// If a number was passed in, add 'px' to the (except for certain CSS properties)
			if ( type === "number" && !jQuery.cssNumber[ origName ] ) {
				value += "px";
			}

			// If a hook was provided, use that value, otherwise just set the specified value
			if ( !hooks || !("set" in hooks) || (value = hooks.set( elem, value )) !== undefined ) {
				// Wrapped to prevent IE from throwing errors when 'invalid' values are provided
				// Fixes bug #5509
				try {
					style[ name ] = value;
				} catch(e) {}
			}

		} else {
			// If a hook was provided get the non-computed value from there
			if ( hooks && "get" in hooks && (ret = hooks.get( elem, false, extra )) !== undefined ) {
				return ret;
			}

			// Otherwise just get the value from the style object
			return style[ name ];
		}
	},

	css: function( elem, name, extra ) {
		var ret, hooks;

		// Make sure that we're working with the right name
		name = jQuery.camelCase( name );
		hooks = jQuery.cssHooks[ name ];
		name = jQuery.cssProps[ name ] || name;

		// cssFloat needs a special treatment
		if ( name === "cssFloat" ) {
			name = "float";
		}

		// If a hook was provided get the computed value from there
		if ( hooks && "get" in hooks && (ret = hooks.get( elem, true, extra )) !== undefined ) {
			return ret;

		// Otherwise, if a way to get the computed value exists, use that
		} else if ( curCSS ) {
			return curCSS( elem, name );
		}
	},

	// A method for quickly swapping in/out CSS properties to get correct calculations
	swap: function( elem, options, callback ) {
		var old = {};

		// Remember the old values, and insert the new ones
		for ( var name in options ) {
			old[ name ] = elem.style[ name ];
			elem.style[ name ] = options[ name ];
		}

		callback.call( elem );

		// Revert the old values
		for ( name in options ) {
			elem.style[ name ] = old[ name ];
		}
	}
});

// DEPRECATED, Use jQuery.css() instead
jQuery.curCSS = jQuery.css;

jQuery.each(["height", "width"], function( i, name ) {
	jQuery.cssHooks[ name ] = {
		get: function( elem, computed, extra ) {
			var val;

			if ( computed ) {
				if ( elem.offsetWidth !== 0 ) {
					return getWH( elem, name, extra );
				} else {
					jQuery.swap( elem, cssShow, function() {
						val = getWH( elem, name, extra );
					});
				}

				return val;
			}
		},

		set: function( elem, value ) {
			if ( rnumpx.test( value ) ) {
				// ignore negative width and height values #1599
				value = parseFloat( value );

				if ( value >= 0 ) {
					return value + "px";
				}

			} else {
				return value;
			}
		}
	};
});

if ( !jQuery.support.opacity ) {
	jQuery.cssHooks.opacity = {
		get: function( elem, computed ) {
			// IE uses filters for opacity
			return ropacity.test( (computed && elem.currentStyle ? elem.currentStyle.filter : elem.style.filter) || "" ) ?
				( parseFloat( RegExp.$1 ) / 100 ) + "" :
				computed ? "1" : "";
		},

		set: function( elem, value ) {
			var style = elem.style,
				currentStyle = elem.currentStyle;

			// IE has trouble with opacity if it does not have layout
			// Force it by setting the zoom level
			style.zoom = 1;

			// Set the alpha filter to set the opacity
			var opacity = jQuery.isNaN( value ) ?
				"" :
				"alpha(opacity=" + value * 100 + ")",
				filter = currentStyle && currentStyle.filter || style.filter || "";

			style.filter = ralpha.test( filter ) ?
				filter.replace( ralpha, opacity ) :
				filter + " " + opacity;
		}
	};
}

jQuery(function() {
	// This hook cannot be added until DOM ready because the support test
	// for it is not run until after DOM ready
	if ( !jQuery.support.reliableMarginRight ) {
		jQuery.cssHooks.marginRight = {
			get: function( elem, computed ) {
				// WebKit Bug 13343 - getComputedStyle returns wrong value for margin-right
				// Work around by temporarily setting element display to inline-block
				var ret;
				jQuery.swap( elem, { "display": "inline-block" }, function() {
					if ( computed ) {
						ret = curCSS( elem, "margin-right", "marginRight" );
					} else {
						ret = elem.style.marginRight;
					}
				});
				return ret;
			}
		};
	}
});

if ( document.defaultView && document.defaultView.getComputedStyle ) {
	getComputedStyle = function( elem, name ) {
		var ret, defaultView, computedStyle;

		name = name.replace( rupper, "-$1" ).toLowerCase();

		if ( !(defaultView = elem.ownerDocument.defaultView) ) {
			return undefined;
		}

		if ( (computedStyle = defaultView.getComputedStyle( elem, null )) ) {
			ret = computedStyle.getPropertyValue( name );
			if ( ret === "" && !jQuery.contains( elem.ownerDocument.documentElement, elem ) ) {
				ret = jQuery.style( elem, name );
			}
		}

		return ret;
	};
}

if ( document.documentElement.currentStyle ) {
	currentStyle = function( elem, name ) {
		var left,
			ret = elem.currentStyle && elem.currentStyle[ name ],
			rsLeft = elem.runtimeStyle && elem.runtimeStyle[ name ],
			style = elem.style;

		// From the awesome hack by Dean Edwards
		// http://erik.eae.net/archives/2007/07/27/18.54.15/#comment-102291

		// If we're not dealing with a regular pixel number
		// but a number that has a weird ending, we need to convert it to pixels
		if ( !rnumpx.test( ret ) && rnum.test( ret ) ) {
			// Remember the original values
			left = style.left;

			// Put in the new values to get a computed value out
			if ( rsLeft ) {
				elem.runtimeStyle.left = elem.currentStyle.left;
			}
			style.left = name === "fontSize" ? "1em" : (ret || 0);
			ret = style.pixelLeft + "px";

			// Revert the changed values
			style.left = left;
			if ( rsLeft ) {
				elem.runtimeStyle.left = rsLeft;
			}
		}

		return ret === "" ? "auto" : ret;
	};
}

curCSS = getComputedStyle || currentStyle;

function getWH( elem, name, extra ) {

	// Start with offset property
	var val = name === "width" ? elem.offsetWidth : elem.offsetHeight,
		which = name === "width" ? cssWidth : cssHeight;

	if ( val > 0 ) {
		if ( extra !== "border" ) {
			jQuery.each( which, function() {
				if ( !extra ) {
					val -= parseFloat( jQuery.css( elem, "padding" + this ) ) || 0;
				}
				if ( extra === "margin" ) {
					val += parseFloat( jQuery.css( elem, extra + this ) ) || 0;
				} else {
					val -= parseFloat( jQuery.css( elem, "border" + this + "Width" ) ) || 0;
				}
			});
		}

		return val + "px";
	}

	// Fall back to computed then uncomputed css if necessary
	val = curCSS( elem, name, name );
	if ( val < 0 || val == null ) {
		val = elem.style[ name ] || 0;
	}
	// Normalize "", auto, and prepare for extra
	val = parseFloat( val ) || 0;

	// Add padding, border, margin
	if ( extra ) {
		jQuery.each( which, function() {
			val += parseFloat( jQuery.css( elem, "padding" + this ) ) || 0;
			if ( extra !== "padding" ) {
				val += parseFloat( jQuery.css( elem, "border" + this + "Width" ) ) || 0;
			}
			if ( extra === "margin" ) {
				val += parseFloat( jQuery.css( elem, extra + this ) ) || 0;
			}
		});
	}

	return val + "px";
}

if ( jQuery.expr && jQuery.expr.filters ) {
	jQuery.expr.filters.hidden = function( elem ) {
		var width = elem.offsetWidth,
			height = elem.offsetHeight;

		return (width === 0 && height === 0) || (!jQuery.support.reliableHiddenOffsets && (elem.style.display || jQuery.css( elem, "display" )) === "none");
	};

	jQuery.expr.filters.visible = function( elem ) {
		return !jQuery.expr.filters.hidden( elem );
	};
}




var r20 = /%20/g,
	rbracket = /\[\]$/,
	rCRLF = /\r?\n/g,
	rhash = /#.*$/,
	rheaders = /^(.*?):[ \t]*([^\r\n]*)\r?$/mg, // IE leaves an \r character at EOL
	rinput = /^(?:color|date|datetime|email|hidden|month|number|password|range|search|tel|text|time|url|week)$/i,
	// #7653, #8125, #8152: local protocol detection
	rlocalProtocol = /^(?:about|app|app\-storage|.+\-extension|file|widget):$/,
	rnoContent = /^(?:GET|HEAD)$/,
	rprotocol = /^\/\//,
	rquery = /\?/,
	rscript = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi,
	rselectTextarea = /^(?:select|textarea)/i,
	rspacesAjax = /\s+/,
	rts = /([?&])_=[^&]*/,
	rurl = /^([\w\+\.\-]+:)(?:\/\/([^\/?#:]*)(?::(\d+))?)?/,

	// Keep a copy of the old load method
	_load = jQuery.fn.load,

	/* Prefilters
	 * 1) They are useful to introduce custom dataTypes (see ajax/jsonp.js for an example)
	 * 2) These are called:
	 *    - BEFORE asking for a transport
	 *    - AFTER param serialization (s.data is a string if s.processData is true)
	 * 3) key is the dataType
	 * 4) the catchall symbol "*" can be used
	 * 5) execution will start with transport dataType and THEN continue down to "*" if needed
	 */
	prefilters = {},

	/* Transports bindings
	 * 1) key is the dataType
	 * 2) the catchall symbol "*" can be used
	 * 3) selection will start with transport dataType and THEN go to "*" if needed
	 */
	transports = {},

	// Document location
	ajaxLocation,

	// Document location segments
	ajaxLocParts;

// #8138, IE may throw an exception when accessing
// a field from window.location if document.domain has been set
try {
	ajaxLocation = location.href;
} catch( e ) {
	// Use the href attribute of an A element
	// since IE will modify it given document.location
	ajaxLocation = document.createElement( "a" );
	ajaxLocation.href = "";
	ajaxLocation = ajaxLocation.href;
}

// Segment location into parts
ajaxLocParts = rurl.exec( ajaxLocation.toLowerCase() ) || [];

// Base "constructor" for jQuery.ajaxPrefilter and jQuery.ajaxTransport
function addToPrefiltersOrTransports( structure ) {

	// dataTypeExpression is optional and defaults to "*"
	return function( dataTypeExpression, func ) {

		if ( typeof dataTypeExpression !== "string" ) {
			func = dataTypeExpression;
			dataTypeExpression = "*";
		}

		if ( jQuery.isFunction( func ) ) {
			var dataTypes = dataTypeExpression.toLowerCase().split( rspacesAjax ),
				i = 0,
				length = dataTypes.length,
				dataType,
				list,
				placeBefore;

			// For each dataType in the dataTypeExpression
			for(; i < length; i++ ) {
				dataType = dataTypes[ i ];
				// We control if we're asked to add before
				// any existing element
				placeBefore = /^\+/.test( dataType );
				if ( placeBefore ) {
					dataType = dataType.substr( 1 ) || "*";
				}
				list = structure[ dataType ] = structure[ dataType ] || [];
				// then we add to the structure accordingly
				list[ placeBefore ? "unshift" : "push" ]( func );
			}
		}
	};
}

// Base inspection function for prefilters and transports
function inspectPrefiltersOrTransports( structure, options, originalOptions, jqXHR,
		dataType /* internal */, inspected /* internal */ ) {

	dataType = dataType || options.dataTypes[ 0 ];
	inspected = inspected || {};

	inspected[ dataType ] = true;

	var list = structure[ dataType ],
		i = 0,
		length = list ? list.length : 0,
		executeOnly = ( structure === prefilters ),
		selection;

	for(; i < length && ( executeOnly || !selection ); i++ ) {
		selection = list[ i ]( options, originalOptions, jqXHR );
		// If we got redirected to another dataType
		// we try there if executing only and not done already
		if ( typeof selection === "string" ) {
			if ( !executeOnly || inspected[ selection ] ) {
				selection = undefined;
			} else {
				options.dataTypes.unshift( selection );
				selection = inspectPrefiltersOrTransports(
						structure, options, originalOptions, jqXHR, selection, inspected );
			}
		}
	}
	// If we're only executing or nothing was selected
	// we try the catchall dataType if not done already
	if ( ( executeOnly || !selection ) && !inspected[ "*" ] ) {
		selection = inspectPrefiltersOrTransports(
				structure, options, originalOptions, jqXHR, "*", inspected );
	}
	// unnecessary when only executing (prefilters)
	// but it'll be ignored by the caller in that case
	return selection;
}

jQuery.fn.extend({
	load: function( url, params, callback ) {
		if ( typeof url !== "string" && _load ) {
			return _load.apply( this, arguments );

		// Don't do a request if no elements are being requested
		} else if ( !this.length ) {
			return this;
		}

		var off = url.indexOf( " " );
		if ( off >= 0 ) {
			var selector = url.slice( off, url.length );
			url = url.slice( 0, off );
		}

		// Default to a GET request
		var type = "GET";

		// If the second parameter was provided
		if ( params ) {
			// If it's a function
			if ( jQuery.isFunction( params ) ) {
				// We assume that it's the callback
				callback = params;
				params = undefined;

			// Otherwise, build a param string
			} else if ( typeof params === "object" ) {
				params = jQuery.param( params, jQuery.ajaxSettings.traditional );
				type = "POST";
			}
		}

		var self = this;

		// Request the remote document
		jQuery.ajax({
			url: url,
			type: type,
			dataType: "html",
			data: params,
			// Complete callback (responseText is used internally)
			complete: function( jqXHR, status, responseText ) {
				// Store the response as specified by the jqXHR object
				responseText = jqXHR.responseText;
				// If successful, inject the HTML into all the matched elements
				if ( jqXHR.isResolved() ) {
					// #4825: Get the actual response in case
					// a dataFilter is present in ajaxSettings
					jqXHR.done(function( r ) {
						responseText = r;
					});
					// See if a selector was specified
					self.html( selector ?
						// Create a dummy div to hold the results
						jQuery("<div>")
							// inject the contents of the document in, removing the scripts
							// to avoid any 'Permission Denied' errors in IE
							.append(responseText.replace(rscript, ""))

							// Locate the specified elements
							.find(selector) :

						// If not, just inject the full result
						responseText );
				}

				if ( callback ) {
					self.each( callback, [ responseText, status, jqXHR ] );
				}
			}
		});

		return this;
	},

	serialize: function() {
		return jQuery.param( this.serializeArray() );
	},

	serializeArray: function() {
		return this.map(function(){
			return this.elements ? jQuery.makeArray( this.elements ) : this;
		})
		.filter(function(){
			return this.name && !this.disabled &&
				( this.checked || rselectTextarea.test( this.nodeName ) ||
					rinput.test( this.type ) );
		})
		.map(function( i, elem ){
			var val = jQuery( this ).val();

			return val == null ?
				null :
				jQuery.isArray( val ) ?
					jQuery.map( val, function( val, i ){
						return { name: elem.name, value: val.replace( rCRLF, "\r\n" ) };
					}) :
					{ name: elem.name, value: val.replace( rCRLF, "\r\n" ) };
		}).get();
	}
});

// Attach a bunch of functions for handling common AJAX events
jQuery.each( "ajaxStart ajaxStop ajaxComplete ajaxError ajaxSuccess ajaxSend".split( " " ), function( i, o ){
	jQuery.fn[ o ] = function( f ){
		return this.bind( o, f );
	};
});

jQuery.each( [ "get", "post" ], function( i, method ) {
	jQuery[ method ] = function( url, data, callback, type ) {
		// shift arguments if data argument was omitted
		if ( jQuery.isFunction( data ) ) {
			type = type || callback;
			callback = data;
			data = undefined;
		}

		return jQuery.ajax({
			type: method,
			url: url,
			data: data,
			success: callback,
			dataType: type
		});
	};
});

jQuery.extend({

	getScript: function( url, callback ) {
		return jQuery.get( url, undefined, callback, "script" );
	},

	getJSON: function( url, data, callback ) {
		return jQuery.get( url, data, callback, "json" );
	},

	// Creates a full fledged settings object into target
	// with both ajaxSettings and settings fields.
	// If target is omitted, writes into ajaxSettings.
	ajaxSetup: function ( target, settings ) {
		if ( !settings ) {
			// Only one parameter, we extend ajaxSettings
			settings = target;
			target = jQuery.extend( true, jQuery.ajaxSettings, settings );
		} else {
			// target was provided, we extend into it
			jQuery.extend( true, target, jQuery.ajaxSettings, settings );
		}
		// Flatten fields we don't want deep extended
		for( var field in { context: 1, url: 1 } ) {
			if ( field in settings ) {
				target[ field ] = settings[ field ];
			} else if( field in jQuery.ajaxSettings ) {
				target[ field ] = jQuery.ajaxSettings[ field ];
			}
		}
		return target;
	},

	ajaxSettings: {
		url: ajaxLocation,
		isLocal: rlocalProtocol.test( ajaxLocParts[ 1 ] ),
		global: true,
		type: "GET",
		contentType: "application/x-www-form-urlencoded",
		processData: true,
		async: true,
		/*
		timeout: 0,
		data: null,
		dataType: null,
		username: null,
		password: null,
		cache: null,
		traditional: false,
		headers: {},
		*/

		accepts: {
			xml: "application/xml, text/xml",
			html: "text/html",
			text: "text/plain",
			json: "application/json, text/javascript",
			"*": "*/*"
		},

		contents: {
			xml: /xml/,
			html: /html/,
			json: /json/
		},

		responseFields: {
			xml: "responseXML",
			text: "responseText"
		},

		// List of data converters
		// 1) key format is "source_type destination_type" (a single space in-between)
		// 2) the catchall symbol "*" can be used for source_type
		converters: {

			// Convert anything to text
			"* text": window.String,

			// Text to html (true = no transformation)
			"text html": true,

			// Evaluate text as a json expression
			"text json": jQuery.parseJSON,

			// Parse text as xml
			"text xml": jQuery.parseXML
		}
	},

	ajaxPrefilter: addToPrefiltersOrTransports( prefilters ),
	ajaxTransport: addToPrefiltersOrTransports( transports ),

	// Main method
	ajax: function( url, options ) {

		// If url is an object, simulate pre-1.5 signature
		if ( typeof url === "object" ) {
			options = url;
			url = undefined;
		}

		// Force options to be an object
		options = options || {};

		var // Create the final options object
			s = jQuery.ajaxSetup( {}, options ),
			// Callbacks context
			callbackContext = s.context || s,
			// Context for global events
			// It's the callbackContext if one was provided in the options
			// and if it's a DOM node or a jQuery collection
			globalEventContext = callbackContext !== s &&
				( callbackContext.nodeType || callbackContext instanceof jQuery ) ?
						jQuery( callbackContext ) : jQuery.event,
			// Deferreds
			deferred = jQuery.Deferred(),
			completeDeferred = jQuery._Deferred(),
			// Status-dependent callbacks
			statusCode = s.statusCode || {},
			// ifModified key
			ifModifiedKey,
			// Headers (they are sent all at once)
			requestHeaders = {},
			requestHeadersNames = {},
			// Response headers
			responseHeadersString,
			responseHeaders,
			// transport
			transport,
			// timeout handle
			timeoutTimer,
			// Cross-domain detection vars
			parts,
			// The jqXHR state
			state = 0,
			// To know if global events are to be dispatched
			fireGlobals,
			// Loop variable
			i,
			// Fake xhr
			jqXHR = {

				readyState: 0,

				// Caches the header
				setRequestHeader: function( name, value ) {
					if ( !state ) {
						var lname = name.toLowerCase();
						name = requestHeadersNames[ lname ] = requestHeadersNames[ lname ] || name;
						requestHeaders[ name ] = value;
					}
					return this;
				},

				// Raw string
				getAllResponseHeaders: function() {
					return state === 2 ? responseHeadersString : null;
				},

				// Builds headers hashtable if needed
				getResponseHeader: function( key ) {
					var match;
					if ( state === 2 ) {
						if ( !responseHeaders ) {
							responseHeaders = {};
							while( ( match = rheaders.exec( responseHeadersString ) ) ) {
								responseHeaders[ match[1].toLowerCase() ] = match[ 2 ];
							}
						}
						match = responseHeaders[ key.toLowerCase() ];
					}
					return match === undefined ? null : match;
				},

				// Overrides response content-type header
				overrideMimeType: function( type ) {
					if ( !state ) {
						s.mimeType = type;
					}
					return this;
				},

				// Cancel the request
				abort: function( statusText ) {
					statusText = statusText || "abort";
					if ( transport ) {
						transport.abort( statusText );
					}
					done( 0, statusText );
					return this;
				}
			};

		// Callback for when everything is done
		// It is defined here because jslint complains if it is declared
		// at the end of the function (which would be more logical and readable)
		function done( status, statusText, responses, headers ) {

			// Called once
			if ( state === 2 ) {
				return;
			}

			// State is "done" now
			state = 2;

			// Clear timeout if it exists
			if ( timeoutTimer ) {
				clearTimeout( timeoutTimer );
			}

			// Dereference transport for early garbage collection
			// (no matter how long the jqXHR object will be used)
			transport = undefined;

			// Cache response headers
			responseHeadersString = headers || "";

			// Set readyState
			jqXHR.readyState = status ? 4 : 0;

			var isSuccess,
				success,
				error,
				response = responses ? ajaxHandleResponses( s, jqXHR, responses ) : undefined,
				lastModified,
				etag;

			// If successful, handle type chaining
			if ( status >= 200 && status < 300 || status === 304 ) {

				// Set the If-Modified-Since and/or If-None-Match header, if in ifModified mode.
				if ( s.ifModified ) {

					if ( ( lastModified = jqXHR.getResponseHeader( "Last-Modified" ) ) ) {
						jQuery.lastModified[ ifModifiedKey ] = lastModified;
					}
					if ( ( etag = jqXHR.getResponseHeader( "Etag" ) ) ) {
						jQuery.etag[ ifModifiedKey ] = etag;
					}
				}

				// If not modified
				if ( status === 304 ) {

					statusText = "notmodified";
					isSuccess = true;

				// If we have data
				} else {

					try {
						success = ajaxConvert( s, response );
						statusText = "success";
						isSuccess = true;
					} catch(e) {
						// We have a parsererror
						statusText = "parsererror";
						error = e;
					}
				}
			} else {
				// We extract error from statusText
				// then normalize statusText and status for non-aborts
				error = statusText;
				if( !statusText || status ) {
					statusText = "error";
					if ( status < 0 ) {
						status = 0;
					}
				}
			}

			// Set data for the fake xhr object
			jqXHR.status = status;
			jqXHR.statusText = statusText;

			// Success/Error
			if ( isSuccess ) {
				deferred.resolveWith( callbackContext, [ success, statusText, jqXHR ] );
			} else {
				deferred.rejectWith( callbackContext, [ jqXHR, statusText, error ] );
			}

			// Status-dependent callbacks
			jqXHR.statusCode( statusCode );
			statusCode = undefined;

			if ( fireGlobals ) {
				globalEventContext.trigger( "ajax" + ( isSuccess ? "Success" : "Error" ),
						[ jqXHR, s, isSuccess ? success : error ] );
			}

			// Complete
			completeDeferred.resolveWith( callbackContext, [ jqXHR, statusText ] );

			if ( fireGlobals ) {
				globalEventContext.trigger( "ajaxComplete", [ jqXHR, s] );
				// Handle the global AJAX counter
				if ( !( --jQuery.active ) ) {
					jQuery.event.trigger( "ajaxStop" );
				}
			}
		}

		// Attach deferreds
		deferred.promise( jqXHR );
		jqXHR.success = jqXHR.done;
		jqXHR.error = jqXHR.fail;
		jqXHR.complete = completeDeferred.done;

		// Status-dependent callbacks
		jqXHR.statusCode = function( map ) {
			if ( map ) {
				var tmp;
				if ( state < 2 ) {
					for( tmp in map ) {
						statusCode[ tmp ] = [ statusCode[tmp], map[tmp] ];
					}
				} else {
					tmp = map[ jqXHR.status ];
					jqXHR.then( tmp, tmp );
				}
			}
			return this;
		};

		// Remove hash character (#7531: and string promotion)
		// Add protocol if not provided (#5866: IE7 issue with protocol-less urls)
		// We also use the url parameter if available
		s.url = ( ( url || s.url ) + "" ).replace( rhash, "" ).replace( rprotocol, ajaxLocParts[ 1 ] + "//" );

		// Extract dataTypes list
		s.dataTypes = jQuery.trim( s.dataType || "*" ).toLowerCase().split( rspacesAjax );

		// Determine if a cross-domain request is in order
		if ( s.crossDomain == null ) {
			parts = rurl.exec( s.url.toLowerCase() );
			s.crossDomain = !!( parts &&
				( parts[ 1 ] != ajaxLocParts[ 1 ] || parts[ 2 ] != ajaxLocParts[ 2 ] ||
					( parts[ 3 ] || ( parts[ 1 ] === "http:" ? 80 : 443 ) ) !=
						( ajaxLocParts[ 3 ] || ( ajaxLocParts[ 1 ] === "http:" ? 80 : 443 ) ) )
			);
		}

		// Convert data if not already a string
		if ( s.data && s.processData && typeof s.data !== "string" ) {
			s.data = jQuery.param( s.data, s.traditional );
		}

		// Apply prefilters
		inspectPrefiltersOrTransports( prefilters, s, options, jqXHR );

		// If request was aborted inside a prefiler, stop there
		if ( state === 2 ) {
			return false;
		}

		// We can fire global events as of now if asked to
		fireGlobals = s.global;

		// Uppercase the type
		s.type = s.type.toUpperCase();

		// Determine if request has content
		s.hasContent = !rnoContent.test( s.type );

		// Watch for a new set of requests
		if ( fireGlobals && jQuery.active++ === 0 ) {
			jQuery.event.trigger( "ajaxStart" );
		}

		// More options handling for requests with no content
		if ( !s.hasContent ) {

			// If data is available, append data to url
			if ( s.data ) {
				s.url += ( rquery.test( s.url ) ? "&" : "?" ) + s.data;
			}

			// Get ifModifiedKey before adding the anti-cache parameter
			ifModifiedKey = s.url;

			// Add anti-cache in url if needed
			if ( s.cache === false ) {

				var ts = jQuery.now(),
					// try replacing _= if it is there
					ret = s.url.replace( rts, "$1_=" + ts );

				// if nothing was replaced, add timestamp to the end
				s.url = ret + ( (ret === s.url ) ? ( rquery.test( s.url ) ? "&" : "?" ) + "_=" + ts : "" );
			}
		}

		// Set the correct header, if data is being sent
		if ( s.data && s.hasContent && s.contentType !== false || options.contentType ) {
			jqXHR.setRequestHeader( "Content-Type", s.contentType );
		}

		// Set the If-Modified-Since and/or If-None-Match header, if in ifModified mode.
		if ( s.ifModified ) {
			ifModifiedKey = ifModifiedKey || s.url;
			if ( jQuery.lastModified[ ifModifiedKey ] ) {
				jqXHR.setRequestHeader( "If-Modified-Since", jQuery.lastModified[ ifModifiedKey ] );
			}
			if ( jQuery.etag[ ifModifiedKey ] ) {
				jqXHR.setRequestHeader( "If-None-Match", jQuery.etag[ ifModifiedKey ] );
			}
		}

		// Set the Accepts header for the server, depending on the dataType
		jqXHR.setRequestHeader(
			"Accept",
			s.dataTypes[ 0 ] && s.accepts[ s.dataTypes[0] ] ?
				s.accepts[ s.dataTypes[0] ] + ( s.dataTypes[ 0 ] !== "*" ? ", */*; q=0.01" : "" ) :
				s.accepts[ "*" ]
		);

		// Check for headers option
		for ( i in s.headers ) {
			jqXHR.setRequestHeader( i, s.headers[ i ] );
		}

		// Allow custom headers/mimetypes and early abort
		if ( s.beforeSend && ( s.beforeSend.call( callbackContext, jqXHR, s ) === false || state === 2 ) ) {
				// Abort if not done already
				jqXHR.abort();
				return false;

		}

		// Install callbacks on deferreds
		for ( i in { success: 1, error: 1, complete: 1 } ) {
			jqXHR[ i ]( s[ i ] );
		}

		// Get transport
		transport = inspectPrefiltersOrTransports( transports, s, options, jqXHR );

		// If no transport, we auto-abort
		if ( !transport ) {
			done( -1, "No Transport" );
		} else {
			jqXHR.readyState = 1;
			// Send global event
			if ( fireGlobals ) {
				globalEventContext.trigger( "ajaxSend", [ jqXHR, s ] );
			}
			// Timeout
			if ( s.async && s.timeout > 0 ) {
				timeoutTimer = setTimeout( function(){
					jqXHR.abort( "timeout" );
				}, s.timeout );
			}

			try {
				state = 1;
				transport.send( requestHeaders, done );
			} catch (e) {
				// Propagate exception as error if not done
				if ( status < 2 ) {
					done( -1, e );
				// Simply rethrow otherwise
				} else {
					jQuery.error( e );
				}
			}
		}

		return jqXHR;
	},

	// Serialize an array of form elements or a set of
	// key/values into a query string
	param: function( a, traditional ) {
		var s = [],
			add = function( key, value ) {
				// If value is a function, invoke it and return its value
				value = jQuery.isFunction( value ) ? value() : value;
				s[ s.length ] = encodeURIComponent( key ) + "=" + encodeURIComponent( value );
			};

		// Set traditional to true for jQuery <= 1.3.2 behavior.
		if ( traditional === undefined ) {
			traditional = jQuery.ajaxSettings.traditional;
		}

		// If an array was passed in, assume that it is an array of form elements.
		if ( jQuery.isArray( a ) || ( a.jquery && !jQuery.isPlainObject( a ) ) ) {
			// Serialize the form elements
			jQuery.each( a, function() {
				add( this.name, this.value );
			});

		} else {
			// If traditional, encode the "old" way (the way 1.3.2 or older
			// did it), otherwise encode params recursively.
			for ( var prefix in a ) {
				buildParams( prefix, a[ prefix ], traditional, add );
			}
		}

		// Return the resulting serialization
		return s.join( "&" ).replace( r20, "+" );
	}
});

function buildParams( prefix, obj, traditional, add ) {
	if ( jQuery.isArray( obj ) ) {
		// Serialize array item.
		jQuery.each( obj, function( i, v ) {
			if ( traditional || rbracket.test( prefix ) ) {
				// Treat each array item as a scalar.
				add( prefix, v );

			} else {
				// If array item is non-scalar (array or object), encode its
				// numeric index to resolve deserialization ambiguity issues.
				// Note that rack (as of 1.0.0) can't currently deserialize
				// nested arrays properly, and attempting to do so may cause
				// a server error. Possible fixes are to modify rack's
				// deserialization algorithm or to provide an option or flag
				// to force array serialization to be shallow.
				buildParams( prefix + "[" + ( typeof v === "object" || jQuery.isArray(v) ? i : "" ) + "]", v, traditional, add );
			}
		});

	} else if ( !traditional && obj != null && typeof obj === "object" ) {
		// Serialize object item.
		for ( var name in obj ) {
			buildParams( prefix + "[" + name + "]", obj[ name ], traditional, add );
		}

	} else {
		// Serialize scalar item.
		add( prefix, obj );
	}
}

// This is still on the jQuery object... for now
// Want to move this to jQuery.ajax some day
jQuery.extend({

	// Counter for holding the number of active queries
	active: 0,

	// Last-Modified header cache for next request
	lastModified: {},
	etag: {}

});

/* Handles responses to an ajax request:
 * - sets all responseXXX fields accordingly
 * - finds the right dataType (mediates between content-type and expected dataType)
 * - returns the corresponding response
 */
function ajaxHandleResponses( s, jqXHR, responses ) {

	var contents = s.contents,
		dataTypes = s.dataTypes,
		responseFields = s.responseFields,
		ct,
		type,
		finalDataType,
		firstDataType;

	// Fill responseXXX fields
	for( type in responseFields ) {
		if ( type in responses ) {
			jqXHR[ responseFields[type] ] = responses[ type ];
		}
	}

	// Remove auto dataType and get content-type in the process
	while( dataTypes[ 0 ] === "*" ) {
		dataTypes.shift();
		if ( ct === undefined ) {
			ct = s.mimeType || jqXHR.getResponseHeader( "content-type" );
		}
	}

	// Check if we're dealing with a known content-type
	if ( ct ) {
		for ( type in contents ) {
			if ( contents[ type ] && contents[ type ].test( ct ) ) {
				dataTypes.unshift( type );
				break;
			}
		}
	}

	// Check to see if we have a response for the expected dataType
	if ( dataTypes[ 0 ] in responses ) {
		finalDataType = dataTypes[ 0 ];
	} else {
		// Try convertible dataTypes
		for ( type in responses ) {
			if ( !dataTypes[ 0 ] || s.converters[ type + " " + dataTypes[0] ] ) {
				finalDataType = type;
				break;
			}
			if ( !firstDataType ) {
				firstDataType = type;
			}
		}
		// Or just use first one
		finalDataType = finalDataType || firstDataType;
	}

	// If we found a dataType
	// We add the dataType to the list if needed
	// and return the corresponding response
	if ( finalDataType ) {
		if ( finalDataType !== dataTypes[ 0 ] ) {
			dataTypes.unshift( finalDataType );
		}
		return responses[ finalDataType ];
	}
}

// Chain conversions given the request and the original response
function ajaxConvert( s, response ) {

	// Apply the dataFilter if provided
	if ( s.dataFilter ) {
		response = s.dataFilter( response, s.dataType );
	}

	var dataTypes = s.dataTypes,
		converters = {},
		i,
		key,
		length = dataTypes.length,
		tmp,
		// Current and previous dataTypes
		current = dataTypes[ 0 ],
		prev,
		// Conversion expression
		conversion,
		// Conversion function
		conv,
		// Conversion functions (transitive conversion)
		conv1,
		conv2;

	// For each dataType in the chain
	for( i = 1; i < length; i++ ) {

		// Create converters map
		// with lowercased keys
		if ( i === 1 ) {
			for( key in s.converters ) {
				if( typeof key === "string" ) {
					converters[ key.toLowerCase() ] = s.converters[ key ];
				}
			}
		}

		// Get the dataTypes
		prev = current;
		current = dataTypes[ i ];

		// If current is auto dataType, update it to prev
		if( current === "*" ) {
			current = prev;
		// If no auto and dataTypes are actually different
		} else if ( prev !== "*" && prev !== current ) {

			// Get the converter
			conversion = prev + " " + current;
			conv = converters[ conversion ] || converters[ "* " + current ];

			// If there is no direct converter, search transitively
			if ( !conv ) {
				conv2 = undefined;
				for( conv1 in converters ) {
					tmp = conv1.split( " " );
					if ( tmp[ 0 ] === prev || tmp[ 0 ] === "*" ) {
						conv2 = converters[ tmp[1] + " " + current ];
						if ( conv2 ) {
							conv1 = converters[ conv1 ];
							if ( conv1 === true ) {
								conv = conv2;
							} else if ( conv2 === true ) {
								conv = conv1;
							}
							break;
						}
					}
				}
			}
			// If we found no converter, dispatch an error
			if ( !( conv || conv2 ) ) {
				jQuery.error( "No conversion from " + conversion.replace(" "," to ") );
			}
			// If found converter is not an equivalence
			if ( conv !== true ) {
				// Convert with 1 or 2 converters accordingly
				response = conv ? conv( response ) : conv2( conv1(response) );
			}
		}
	}
	return response;
}




var jsc = jQuery.now(),
	jsre = /(\=)\?(&|$)|\?\?/i;

// Default jsonp settings
jQuery.ajaxSetup({
	jsonp: "callback",
	jsonpCallback: function() {
		return jQuery.expando + "_" + ( jsc++ );
	}
});

// Detect, normalize options and install callbacks for jsonp requests
jQuery.ajaxPrefilter( "json jsonp", function( s, originalSettings, jqXHR ) {

	var inspectData = s.contentType === "application/x-www-form-urlencoded" &&
		( typeof s.data === "string" );

	if ( s.dataTypes[ 0 ] === "jsonp" ||
		s.jsonp !== false && ( jsre.test( s.url ) ||
				inspectData && jsre.test( s.data ) ) ) {

		var responseContainer,
			jsonpCallback = s.jsonpCallback =
				jQuery.isFunction( s.jsonpCallback ) ? s.jsonpCallback() : s.jsonpCallback,
			previous = window[ jsonpCallback ],
			url = s.url,
			data = s.data,
			replace = "$1" + jsonpCallback + "$2";

		if ( s.jsonp !== false ) {
			url = url.replace( jsre, replace );
			if ( s.url === url ) {
				if ( inspectData ) {
					data = data.replace( jsre, replace );
				}
				if ( s.data === data ) {
					// Add callback manually
					url += (/\?/.test( url ) ? "&" : "?") + s.jsonp + "=" + jsonpCallback;
				}
			}
		}

		s.url = url;
		s.data = data;

		// Install callback
		window[ jsonpCallback ] = function( response ) {
			responseContainer = [ response ];
		};

		// Clean-up function
		jqXHR.always(function() {
			// Set callback back to previous value
			window[ jsonpCallback ] = previous;
			// Call if it was a function and we have a response
			if ( responseContainer && jQuery.isFunction( previous ) ) {
				window[ jsonpCallback ]( responseContainer[ 0 ] );
			}
		});

		// Use data converter to retrieve json after script execution
		s.converters["script json"] = function() {
			if ( !responseContainer ) {
				jQuery.error( jsonpCallback + " was not called" );
			}
			return responseContainer[ 0 ];
		};

		// force json dataType
		s.dataTypes[ 0 ] = "json";

		// Delegate to script
		return "script";
	}
});




// Install script dataType
jQuery.ajaxSetup({
	accepts: {
		script: "text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"
	},
	contents: {
		script: /javascript|ecmascript/
	},
	converters: {
		"text script": function( text ) {
			jQuery.globalEval( text );
			return text;
		}
	}
});

// Handle cache's special case and global
jQuery.ajaxPrefilter( "script", function( s ) {
	if ( s.cache === undefined ) {
		s.cache = false;
	}
	if ( s.crossDomain ) {
		s.type = "GET";
		s.global = false;
	}
});

// Bind script tag hack transport
jQuery.ajaxTransport( "script", function(s) {

	// This transport only deals with cross domain requests
	if ( s.crossDomain ) {

		var script,
			head = document.head || document.getElementsByTagName( "head" )[0] || document.documentElement;

		return {

			send: function( _, callback ) {

				script = document.createElement( "script" );

				script.async = "async";

				if ( s.scriptCharset ) {
					script.charset = s.scriptCharset;
				}

				script.src = s.url;

				// Attach handlers for all browsers
				script.onload = script.onreadystatechange = function( _, isAbort ) {

					if ( isAbort || !script.readyState || /loaded|complete/.test( script.readyState ) ) {

						// Handle memory leak in IE
						script.onload = script.onreadystatechange = null;

						// Remove the script
						if ( head && script.parentNode ) {
							head.removeChild( script );
						}

						// Dereference the script
						script = undefined;

						// Callback if not abort
						if ( !isAbort ) {
							callback( 200, "success" );
						}
					}
				};
				// Use insertBefore instead of appendChild  to circumvent an IE6 bug.
				// This arises when a base node is used (#2709 and #4378).
				head.insertBefore( script, head.firstChild );
			},

			abort: function() {
				if ( script ) {
					script.onload( 0, 1 );
				}
			}
		};
	}
});




var // #5280: Internet Explorer will keep connections alive if we don't abort on unload
	xhrOnUnloadAbort = window.ActiveXObject ? function() {
		// Abort all pending requests
		for ( var key in xhrCallbacks ) {
			xhrCallbacks[ key ]( 0, 1 );
		}
	} : false,
	xhrId = 0,
	xhrCallbacks;

// Functions to create xhrs
function createStandardXHR() {
	try {
		return new window.XMLHttpRequest();
	} catch( e ) {}
}

function createActiveXHR() {
	try {
		return new window.ActiveXObject( "Microsoft.XMLHTTP" );
	} catch( e ) {}
}

// Create the request object
// (This is still attached to ajaxSettings for backward compatibility)
jQuery.ajaxSettings.xhr = window.ActiveXObject ?
	/* Microsoft failed to properly
	 * implement the XMLHttpRequest in IE7 (can't request local files),
	 * so we use the ActiveXObject when it is available
	 * Additionally XMLHttpRequest can be disabled in IE7/IE8 so
	 * we need a fallback.
	 */
	function() {
		return !this.isLocal && createStandardXHR() || createActiveXHR();
	} :
	// For all other browsers, use the standard XMLHttpRequest object
	createStandardXHR;

// Determine support properties
(function( xhr ) {
	jQuery.extend( jQuery.support, {
		ajax: !!xhr,
		cors: !!xhr && ( "withCredentials" in xhr )
	});
})( jQuery.ajaxSettings.xhr() );

// Create transport if the browser can provide an xhr
if ( jQuery.support.ajax ) {

	jQuery.ajaxTransport(function( s ) {
		// Cross domain only allowed if supported through XMLHttpRequest
		if ( !s.crossDomain || jQuery.support.cors ) {

			var callback;

			return {
				send: function( headers, complete ) {

					// Get a new xhr
					var xhr = s.xhr(),
						handle,
						i;

					// Open the socket
					// Passing null username, generates a login popup on Opera (#2865)
					if ( s.username ) {
						xhr.open( s.type, s.url, s.async, s.username, s.password );
					} else {
						xhr.open( s.type, s.url, s.async );
					}

					// Apply custom fields if provided
					if ( s.xhrFields ) {
						for ( i in s.xhrFields ) {
							xhr[ i ] = s.xhrFields[ i ];
						}
					}

					// Override mime type if needed
					if ( s.mimeType && xhr.overrideMimeType ) {
						xhr.overrideMimeType( s.mimeType );
					}

					// X-Requested-With header
					// For cross-domain requests, seeing as conditions for a preflight are
					// akin to a jigsaw puzzle, we simply never set it to be sure.
					// (it can always be set on a per-request basis or even using ajaxSetup)
					// For same-domain requests, won't change header if already provided.
					if ( !s.crossDomain && !headers["X-Requested-With"] ) {
						headers[ "X-Requested-With" ] = "XMLHttpRequest";
					}

					// Need an extra try/catch for cross domain requests in Firefox 3
					try {
						for ( i in headers ) {
							xhr.setRequestHeader( i, headers[ i ] );
						}
					} catch( _ ) {}

					// Do send the request
					// This may raise an exception which is actually
					// handled in jQuery.ajax (so no try/catch here)
					xhr.send( ( s.hasContent && s.data ) || null );

					// Listener
					callback = function( _, isAbort ) {

						var status,
							statusText,
							responseHeaders,
							responses,
							xml;

						// Firefox throws exceptions when accessing properties
						// of an xhr when a network error occured
						// http://helpful.knobs-dials.com/index.php/Component_returned_failure_code:_0x80040111_(NS_ERROR_NOT_AVAILABLE)
						try {

							// Was never called and is aborted or complete
							if ( callback && ( isAbort || xhr.readyState === 4 ) ) {

								// Only called once
								callback = undefined;

								// Do not keep as active anymore
								if ( handle ) {
									xhr.onreadystatechange = jQuery.noop;
									if ( xhrOnUnloadAbort ) {
										delete xhrCallbacks[ handle ];
									}
								}

								// If it's an abort
								if ( isAbort ) {
									// Abort it manually if needed
									if ( xhr.readyState !== 4 ) {
										xhr.abort();
									}
								} else {
									status = xhr.status;
									responseHeaders = xhr.getAllResponseHeaders();
									responses = {};
									xml = xhr.responseXML;

									// Construct response list
									if ( xml && xml.documentElement /* #4958 */ ) {
										responses.xml = xml;
									}
									responses.text = xhr.responseText;

									// Firefox throws an exception when accessing
									// statusText for faulty cross-domain requests
									try {
										statusText = xhr.statusText;
									} catch( e ) {
										// We normalize with Webkit giving an empty statusText
										statusText = "";
									}

									// Filter status for non standard behaviors

									// If the request is local and we have data: assume a success
									// (success with no data won't get notified, that's the best we
									// can do given current implementations)
									if ( !status && s.isLocal && !s.crossDomain ) {
										status = responses.text ? 200 : 404;
									// IE - #1450: sometimes returns 1223 when it should be 204
									} else if ( status === 1223 ) {
										status = 204;
									}
								}
							}
						} catch( firefoxAccessException ) {
							if ( !isAbort ) {
								complete( -1, firefoxAccessException );
							}
						}

						// Call complete if needed
						if ( responses ) {
							complete( status, statusText, responses, responseHeaders );
						}
					};

					// if we're in sync mode or it's in cache
					// and has been retrieved directly (IE6 & IE7)
					// we need to manually fire the callback
					if ( !s.async || xhr.readyState === 4 ) {
						callback();
					} else {
						handle = ++xhrId;
						if ( xhrOnUnloadAbort ) {
							// Create the active xhrs callbacks list if needed
							// and attach the unload handler
							if ( !xhrCallbacks ) {
								xhrCallbacks = {};
								jQuery( window ).unload( xhrOnUnloadAbort );
							}
							// Add to list of active xhrs callbacks
							xhrCallbacks[ handle ] = callback;
						}
						xhr.onreadystatechange = callback;
					}
				},

				abort: function() {
					if ( callback ) {
						callback(0,1);
					}
				}
			};
		}
	});
}




var elemdisplay = {},
	iframe, iframeDoc,
	rfxtypes = /^(?:toggle|show|hide)$/,
	rfxnum = /^([+\-]=)?([\d+.\-]+)([a-z%]*)$/i,
	timerId,
	fxAttrs = [
		// height animations
		[ "height", "marginTop", "marginBottom", "paddingTop", "paddingBottom" ],
		// width animations
		[ "width", "marginLeft", "marginRight", "paddingLeft", "paddingRight" ],
		// opacity animations
		[ "opacity" ]
	],
	fxNow,
	requestAnimationFrame = window.webkitRequestAnimationFrame ||
		window.mozRequestAnimationFrame ||
		window.oRequestAnimationFrame;

jQuery.fn.extend({
	show: function( speed, easing, callback ) {
		var elem, display;

		if ( speed || speed === 0 ) {
			return this.animate( genFx("show", 3), speed, easing, callback);

		} else {
			for ( var i = 0, j = this.length; i < j; i++ ) {
				elem = this[i];

				if ( elem.style ) {
					display = elem.style.display;

					// Reset the inline display of this element to learn if it is
					// being hidden by cascaded rules or not
					if ( !jQuery._data(elem, "olddisplay") && display === "none" ) {
						display = elem.style.display = "";
					}

					// Set elements which have been overridden with display: none
					// in a stylesheet to whatever the default browser style is
					// for such an element
					if ( display === "" && jQuery.css( elem, "display" ) === "none" ) {
						jQuery._data(elem, "olddisplay", defaultDisplay(elem.nodeName));
					}
				}
			}

			// Set the display of most of the elements in a second loop
			// to avoid the constant reflow
			for ( i = 0; i < j; i++ ) {
				elem = this[i];

				if ( elem.style ) {
					display = elem.style.display;

					if ( display === "" || display === "none" ) {
						elem.style.display = jQuery._data(elem, "olddisplay") || "";
					}
				}
			}

			return this;
		}
	},

	hide: function( speed, easing, callback ) {
		if ( speed || speed === 0 ) {
			return this.animate( genFx("hide", 3), speed, easing, callback);

		} else {
			for ( var i = 0, j = this.length; i < j; i++ ) {
				if ( this[i].style ) {
					var display = jQuery.css( this[i], "display" );

					if ( display !== "none" && !jQuery._data( this[i], "olddisplay" ) ) {
						jQuery._data( this[i], "olddisplay", display );
					}
				}
			}

			// Set the display of the elements in a second loop
			// to avoid the constant reflow
			for ( i = 0; i < j; i++ ) {
				if ( this[i].style ) {
					this[i].style.display = "none";
				}
			}

			return this;
		}
	},

	// Save the old toggle function
	_toggle: jQuery.fn.toggle,

	toggle: function( fn, fn2, callback ) {
		var bool = typeof fn === "boolean";

		if ( jQuery.isFunction(fn) && jQuery.isFunction(fn2) ) {
			this._toggle.apply( this, arguments );

		} else if ( fn == null || bool ) {
			this.each(function() {
				var state = bool ? fn : jQuery(this).is(":hidden");
				jQuery(this)[ state ? "show" : "hide" ]();
			});

		} else {
			this.animate(genFx("toggle", 3), fn, fn2, callback);
		}

		return this;
	},

	fadeTo: function( speed, to, easing, callback ) {
		return this.filter(":hidden").css("opacity", 0).show().end()
					.animate({opacity: to}, speed, easing, callback);
	},

	animate: function( prop, speed, easing, callback ) {
		var optall = jQuery.speed(speed, easing, callback);

		if ( jQuery.isEmptyObject( prop ) ) {
			return this.each( optall.complete, [ false ] );
		}

		// Do not change referenced properties as per-property easing will be lost
		prop = jQuery.extend( {}, prop );

		return this[ optall.queue === false ? "each" : "queue" ](function() {
			// XXX 'this' does not always have a nodeName when running the
			// test suite

			if ( optall.queue === false ) {
				jQuery._mark( this );
			}

			var opt = jQuery.extend( {}, optall ),
				isElement = this.nodeType === 1,
				hidden = isElement && jQuery(this).is(":hidden"),
				name, val, p,
				display, e,
				parts, start, end, unit;

			// will store per property easing and be used to determine when an animation is complete
			opt.animatedProperties = {};

			for ( p in prop ) {

				// property name normalization
				name = jQuery.camelCase( p );
				if ( p !== name ) {
					prop[ name ] = prop[ p ];
					delete prop[ p ];
				}

				val = prop[ name ];

				// easing resolution: per property > opt.specialEasing > opt.easing > 'swing' (default)
				if ( jQuery.isArray( val ) ) {
					opt.animatedProperties[ name ] = val[ 1 ];
					val = prop[ name ] = val[ 0 ];
				} else {
					opt.animatedProperties[ name ] = opt.specialEasing && opt.specialEasing[ name ] || opt.easing || 'swing';
				}

				if ( val === "hide" && hidden || val === "show" && !hidden ) {
					return opt.complete.call( this );
				}

				if ( isElement && ( name === "height" || name === "width" ) ) {
					// Make sure that nothing sneaks out
					// Record all 3 overflow attributes because IE does not
					// change the overflow attribute when overflowX and
					// overflowY are set to the same value
					opt.overflow = [ this.style.overflow, this.style.overflowX, this.style.overflowY ];

					// Set display property to inline-block for height/width
					// animations on inline elements that are having width/height
					// animated
					if ( jQuery.css( this, "display" ) === "inline" &&
							jQuery.css( this, "float" ) === "none" ) {
						if ( !jQuery.support.inlineBlockNeedsLayout ) {
							this.style.display = "inline-block";

						} else {
							display = defaultDisplay( this.nodeName );

							// inline-level elements accept inline-block;
							// block-level elements need to be inline with layout
							if ( display === "inline" ) {
								this.style.display = "inline-block";

							} else {
								this.style.display = "inline";
								this.style.zoom = 1;
							}
						}
					}
				}
			}

			if ( opt.overflow != null ) {
				this.style.overflow = "hidden";
			}

			for ( p in prop ) {
				e = new jQuery.fx( this, opt, p );
				val = prop[ p ];

				if ( rfxtypes.test(val) ) {
					e[ val === "toggle" ? hidden ? "show" : "hide" : val ]();

				} else {
					parts = rfxnum.exec( val );
					start = e.cur();

					if ( parts ) {
						end = parseFloat( parts[2] );
						unit = parts[3] || ( jQuery.cssNumber[ p ] ? "" : "px" );

						// We need to compute starting value
						if ( unit !== "px" ) {
							jQuery.style( this, p, (end || 1) + unit);
							start = ((end || 1) / e.cur()) * start;
							jQuery.style( this, p, start + unit);
						}

						// If a +=/-= token was provided, we're doing a relative animation
						if ( parts[1] ) {
							end = ( (parts[ 1 ] === "-=" ? -1 : 1) * end ) + start;
						}

						e.custom( start, end, unit );

					} else {
						e.custom( start, val, "" );
					}
				}
			}

			// For JS strict compliance
			return true;
		});
	},

	stop: function( clearQueue, gotoEnd ) {
		if ( clearQueue ) {
			this.queue([]);
		}

		this.each(function() {
			var timers = jQuery.timers,
				i = timers.length;
			// clear marker counters if we know they won't be
			if ( !gotoEnd ) {
				jQuery._unmark( true, this );
			}
			while ( i-- ) {
				if ( timers[i].elem === this ) {
					if (gotoEnd) {
						// force the next step to be the last
						timers[i](true);
					}

					timers.splice(i, 1);
				}
			}
		});

		// start the next in the queue if the last step wasn't forced
		if ( !gotoEnd ) {
			this.dequeue();
		}

		return this;
	}

});

// Animations created synchronously will run synchronously
function createFxNow() {
	setTimeout( clearFxNow, 0 );
	return ( fxNow = jQuery.now() );
}

function clearFxNow() {
	fxNow = undefined;
}

// Generate parameters to create a standard animation
function genFx( type, num ) {
	var obj = {};

	jQuery.each( fxAttrs.concat.apply([], fxAttrs.slice(0,num)), function() {
		obj[ this ] = type;
	});

	return obj;
}

// Generate shortcuts for custom animations
jQuery.each({
	slideDown: genFx("show", 1),
	slideUp: genFx("hide", 1),
	slideToggle: genFx("toggle", 1),
	fadeIn: { opacity: "show" },
	fadeOut: { opacity: "hide" },
	fadeToggle: { opacity: "toggle" }
}, function( name, props ) {
	jQuery.fn[ name ] = function( speed, easing, callback ) {
		return this.animate( props, speed, easing, callback );
	};
});

jQuery.extend({
	speed: function( speed, easing, fn ) {
		var opt = speed && typeof speed === "object" ? jQuery.extend({}, speed) : {
			complete: fn || !fn && easing ||
				jQuery.isFunction( speed ) && speed,
			duration: speed,
			easing: fn && easing || easing && !jQuery.isFunction(easing) && easing
		};

		opt.duration = jQuery.fx.off ? 0 : typeof opt.duration === "number" ? opt.duration :
			opt.duration in jQuery.fx.speeds ? jQuery.fx.speeds[opt.duration] : jQuery.fx.speeds._default;

		// Queueing
		opt.old = opt.complete;
		opt.complete = function( noUnmark ) {
			if ( jQuery.isFunction( opt.old ) ) {
				opt.old.call( this );
			}

			if ( opt.queue !== false ) {
				jQuery.dequeue( this );
			} else if ( noUnmark !== false ) {
				jQuery._unmark( this );
			}
		};

		return opt;
	},

	easing: {
		linear: function( p, n, firstNum, diff ) {
			return firstNum + diff * p;
		},
		swing: function( p, n, firstNum, diff ) {
			return ((-Math.cos(p*Math.PI)/2) + 0.5) * diff + firstNum;
		}
	},

	timers: [],

	fx: function( elem, options, prop ) {
		this.options = options;
		this.elem = elem;
		this.prop = prop;

		options.orig = options.orig || {};
	}

});

jQuery.fx.prototype = {
	// Simple function for setting a style value
	update: function() {
		if ( this.options.step ) {
			this.options.step.call( this.elem, this.now, this );
		}

		(jQuery.fx.step[this.prop] || jQuery.fx.step._default)( this );
	},

	// Get the current size
	cur: function() {
		if ( this.elem[this.prop] != null && (!this.elem.style || this.elem.style[this.prop] == null) ) {
			return this.elem[ this.prop ];
		}

		var parsed,
			r = jQuery.css( this.elem, this.prop );
		// Empty strings, null, undefined and "auto" are converted to 0,
		// complex values such as "rotate(1rad)" are returned as is,
		// simple values such as "10px" are parsed to Float.
		return isNaN( parsed = parseFloat( r ) ) ? !r || r === "auto" ? 0 : r : parsed;
	},

	// Start an animation from one number to another
	custom: function( from, to, unit ) {
		var self = this,
			fx = jQuery.fx,
			raf;

		this.startTime = fxNow || createFxNow();
		this.start = from;
		this.end = to;
		this.unit = unit || this.unit || ( jQuery.cssNumber[ this.prop ] ? "" : "px" );
		this.now = this.start;
		this.pos = this.state = 0;

		function t( gotoEnd ) {
			return self.step(gotoEnd);
		}

		t.elem = this.elem;

		if ( t() && jQuery.timers.push(t) && !timerId ) {
			// Use requestAnimationFrame instead of setInterval if available
			if ( requestAnimationFrame ) {
				timerId = true;
				raf = function() {
					// When timerId gets set to null at any point, this stops
					if ( timerId ) {
						requestAnimationFrame( raf );
						fx.tick();
					}
				};
				requestAnimationFrame( raf );
			} else {
				timerId = setInterval( fx.tick, fx.interval );
			}
		}
	},

	// Simple 'show' function
	show: function() {
		// Remember where we started, so that we can go back to it later
		this.options.orig[this.prop] = jQuery.style( this.elem, this.prop );
		this.options.show = true;

		// Begin the animation
		// Make sure that we start at a small width/height to avoid any
		// flash of content
		this.custom(this.prop === "width" || this.prop === "height" ? 1 : 0, this.cur());

		// Start by showing the element
		jQuery( this.elem ).show();
	},

	// Simple 'hide' function
	hide: function() {
		// Remember where we started, so that we can go back to it later
		this.options.orig[this.prop] = jQuery.style( this.elem, this.prop );
		this.options.hide = true;

		// Begin the animation
		this.custom(this.cur(), 0);
	},

	// Each step of an animation
	step: function( gotoEnd ) {
		var t = fxNow || createFxNow(),
			done = true,
			elem = this.elem,
			options = this.options,
			i, n;

		if ( gotoEnd || t >= options.duration + this.startTime ) {
			this.now = this.end;
			this.pos = this.state = 1;
			this.update();

			options.animatedProperties[ this.prop ] = true;

			for ( i in options.animatedProperties ) {
				if ( options.animatedProperties[i] !== true ) {
					done = false;
				}
			}

			if ( done ) {
				// Reset the overflow
				if ( options.overflow != null && !jQuery.support.shrinkWrapBlocks ) {

					jQuery.each( [ "", "X", "Y" ], function (index, value) {
						elem.style[ "overflow" + value ] = options.overflow[index];
					});
				}

				// Hide the element if the "hide" operation was done
				if ( options.hide ) {
					jQuery(elem).hide();
				}

				// Reset the properties, if the item has been hidden or shown
				if ( options.hide || options.show ) {
					for ( var p in options.animatedProperties ) {
						jQuery.style( elem, p, options.orig[p] );
					}
				}

				// Execute the complete function
				options.complete.call( elem );
			}

			return false;

		} else {
			// classical easing cannot be used with an Infinity duration
			if ( options.duration == Infinity ) {
				this.now = t;
			} else {
				n = t - this.startTime;
				this.state = n / options.duration;

				// Perform the easing function, defaults to swing
				this.pos = jQuery.easing[ options.animatedProperties[ this.prop ] ]( this.state, n, 0, 1, options.duration );
				this.now = this.start + ((this.end - this.start) * this.pos);
			}
			// Perform the next step of the animation
			this.update();
		}

		return true;
	}
};

jQuery.extend( jQuery.fx, {
	tick: function() {
		for ( var timers = jQuery.timers, i = 0 ; i < timers.length ; ++i ) {
			if ( !timers[i]() ) {
				timers.splice(i--, 1);
			}
		}

		if ( !timers.length ) {
			jQuery.fx.stop();
		}
	},

	interval: 13,

	stop: function() {
		clearInterval( timerId );
		timerId = null;
	},

	speeds: {
		slow: 600,
		fast: 200,
		// Default speed
		_default: 400
	},

	step: {
		opacity: function( fx ) {
			jQuery.style( fx.elem, "opacity", fx.now );
		},

		_default: function( fx ) {
			if ( fx.elem.style && fx.elem.style[ fx.prop ] != null ) {
				fx.elem.style[ fx.prop ] = (fx.prop === "width" || fx.prop === "height" ? Math.max(0, fx.now) : fx.now) + fx.unit;
			} else {
				fx.elem[ fx.prop ] = fx.now;
			}
		}
	}
});

if ( jQuery.expr && jQuery.expr.filters ) {
	jQuery.expr.filters.animated = function( elem ) {
		return jQuery.grep(jQuery.timers, function( fn ) {
			return elem === fn.elem;
		}).length;
	};
}

// Try to restore the default display value of an element
function defaultDisplay( nodeName ) {

	if ( !elemdisplay[ nodeName ] ) {

		var body = document.body,
			elem = jQuery( "<" + nodeName + ">" ).appendTo( body ),
			display = elem.css( "display" );

		elem.remove();

		// If the simple way fails,
		// get element's real default display by attaching it to a temp iframe
		if ( display === "none" || display === "" ) {
			// No iframe to use yet, so create it
			if ( !iframe ) {
				iframe = document.createElement( "iframe" );
				iframe.frameBorder = iframe.width = iframe.height = 0;
			}

			body.appendChild( iframe );

			// Create a cacheable copy of the iframe document on first call.
			// IE and Opera will allow us to reuse the iframeDoc without re-writing the fake HTML
			// document to it; WebKit & Firefox won't allow reusing the iframe document.
			if ( !iframeDoc || !iframe.createElement ) {
				iframeDoc = ( iframe.contentWindow || iframe.contentDocument ).document;
				iframeDoc.write( ( document.compatMode === "CSS1Compat" ? "<!doctype html>" : "" ) + "<html><body>" );
				iframeDoc.close();
			}

			elem = iframeDoc.createElement( nodeName );

			iframeDoc.body.appendChild( elem );

			display = jQuery.css( elem, "display" );

			body.removeChild( iframe );
		}

		// Store the correct default display
		elemdisplay[ nodeName ] = display;
	}

	return elemdisplay[ nodeName ];
}




var rtable = /^t(?:able|d|h)$/i,
	rroot = /^(?:body|html)$/i;

if ( "getBoundingClientRect" in document.documentElement ) {
	jQuery.fn.offset = function( options ) {
		var elem = this[0], box;

		if ( options ) {
			return this.each(function( i ) {
				jQuery.offset.setOffset( this, options, i );
			});
		}

		if ( !elem || !elem.ownerDocument ) {
			return null;
		}

		if ( elem === elem.ownerDocument.body ) {
			return jQuery.offset.bodyOffset( elem );
		}

		try {
			box = elem.getBoundingClientRect();
		} catch(e) {}

		var doc = elem.ownerDocument,
			docElem = doc.documentElement;

		// Make sure we're not dealing with a disconnected DOM node
		if ( !box || !jQuery.contains( docElem, elem ) ) {
			return box ? { top: box.top, left: box.left } : { top: 0, left: 0 };
		}

		var body = doc.body,
			win = getWindow(doc),
			clientTop  = docElem.clientTop  || body.clientTop  || 0,
			clientLeft = docElem.clientLeft || body.clientLeft || 0,
			scrollTop  = win.pageYOffset || jQuery.support.boxModel && docElem.scrollTop  || body.scrollTop,
			scrollLeft = win.pageXOffset || jQuery.support.boxModel && docElem.scrollLeft || body.scrollLeft,
			top  = box.top  + scrollTop  - clientTop,
			left = box.left + scrollLeft - clientLeft;

		return { top: top, left: left };
	};

} else {
	jQuery.fn.offset = function( options ) {
		var elem = this[0];

		if ( options ) {
			return this.each(function( i ) {
				jQuery.offset.setOffset( this, options, i );
			});
		}

		if ( !elem || !elem.ownerDocument ) {
			return null;
		}

		if ( elem === elem.ownerDocument.body ) {
			return jQuery.offset.bodyOffset( elem );
		}

		jQuery.offset.initialize();

		var computedStyle,
			offsetParent = elem.offsetParent,
			prevOffsetParent = elem,
			doc = elem.ownerDocument,
			docElem = doc.documentElement,
			body = doc.body,
			defaultView = doc.defaultView,
			prevComputedStyle = defaultView ? defaultView.getComputedStyle( elem, null ) : elem.currentStyle,
			top = elem.offsetTop,
			left = elem.offsetLeft;

		while ( (elem = elem.parentNode) && elem !== body && elem !== docElem ) {
			if ( jQuery.offset.supportsFixedPosition && prevComputedStyle.position === "fixed" ) {
				break;
			}

			computedStyle = defaultView ? defaultView.getComputedStyle(elem, null) : elem.currentStyle;
			top  -= elem.scrollTop;
			left -= elem.scrollLeft;

			if ( elem === offsetParent ) {
				top  += elem.offsetTop;
				left += elem.offsetLeft;

				if ( jQuery.offset.doesNotAddBorder && !(jQuery.offset.doesAddBorderForTableAndCells && rtable.test(elem.nodeName)) ) {
					top  += parseFloat( computedStyle.borderTopWidth  ) || 0;
					left += parseFloat( computedStyle.borderLeftWidth ) || 0;
				}

				prevOffsetParent = offsetParent;
				offsetParent = elem.offsetParent;
			}

			if ( jQuery.offset.subtractsBorderForOverflowNotVisible && computedStyle.overflow !== "visible" ) {
				top  += parseFloat( computedStyle.borderTopWidth  ) || 0;
				left += parseFloat( computedStyle.borderLeftWidth ) || 0;
			}

			prevComputedStyle = computedStyle;
		}

		if ( prevComputedStyle.position === "relative" || prevComputedStyle.position === "static" ) {
			top  += body.offsetTop;
			left += body.offsetLeft;
		}

		if ( jQuery.offset.supportsFixedPosition && prevComputedStyle.position === "fixed" ) {
			top  += Math.max( docElem.scrollTop, body.scrollTop );
			left += Math.max( docElem.scrollLeft, body.scrollLeft );
		}

		return { top: top, left: left };
	};
}

jQuery.offset = {
	initialize: function() {
		var body = document.body, container = document.createElement("div"), innerDiv, checkDiv, table, td, bodyMarginTop = parseFloat( jQuery.css(body, "marginTop") ) || 0,
			html = "<div style='position:absolute;top:0;left:0;margin:0;border:5px solid #000;padding:0;width:1px;height:1px;'><div></div></div><table style='position:absolute;top:0;left:0;margin:0;border:5px solid #000;padding:0;width:1px;height:1px;' cellpadding='0' cellspacing='0'><tr><td></td></tr></table>";

		jQuery.extend( container.style, { position: "absolute", top: 0, left: 0, margin: 0, border: 0, width: "1px", height: "1px", visibility: "hidden" } );

		container.innerHTML = html;
		body.insertBefore( container, body.firstChild );
		innerDiv = container.firstChild;
		checkDiv = innerDiv.firstChild;
		td = innerDiv.nextSibling.firstChild.firstChild;

		this.doesNotAddBorder = (checkDiv.offsetTop !== 5);
		this.doesAddBorderForTableAndCells = (td.offsetTop === 5);

		checkDiv.style.position = "fixed";
		checkDiv.style.top = "20px";

		// safari subtracts parent border width here which is 5px
		this.supportsFixedPosition = (checkDiv.offsetTop === 20 || checkDiv.offsetTop === 15);
		checkDiv.style.position = checkDiv.style.top = "";

		innerDiv.style.overflow = "hidden";
		innerDiv.style.position = "relative";

		this.subtractsBorderForOverflowNotVisible = (checkDiv.offsetTop === -5);

		this.doesNotIncludeMarginInBodyOffset = (body.offsetTop !== bodyMarginTop);

		body.removeChild( container );
		jQuery.offset.initialize = jQuery.noop;
	},

	bodyOffset: function( body ) {
		var top = body.offsetTop,
			left = body.offsetLeft;

		jQuery.offset.initialize();

		if ( jQuery.offset.doesNotIncludeMarginInBodyOffset ) {
			top  += parseFloat( jQuery.css(body, "marginTop") ) || 0;
			left += parseFloat( jQuery.css(body, "marginLeft") ) || 0;
		}

		return { top: top, left: left };
	},

	setOffset: function( elem, options, i ) {
		var position = jQuery.css( elem, "position" );

		// set position first, in-case top/left are set even on static elem
		if ( position === "static" ) {
			elem.style.position = "relative";
		}

		var curElem = jQuery( elem ),
			curOffset = curElem.offset(),
			curCSSTop = jQuery.css( elem, "top" ),
			curCSSLeft = jQuery.css( elem, "left" ),
			calculatePosition = (position === "absolute" || position === "fixed") && jQuery.inArray("auto", [curCSSTop, curCSSLeft]) > -1,
			props = {}, curPosition = {}, curTop, curLeft;

		// need to be able to calculate position if either top or left is auto and position is either absolute or fixed
		if ( calculatePosition ) {
			curPosition = curElem.position();
			curTop = curPosition.top;
			curLeft = curPosition.left;
		} else {
			curTop = parseFloat( curCSSTop ) || 0;
			curLeft = parseFloat( curCSSLeft ) || 0;
		}

		if ( jQuery.isFunction( options ) ) {
			options = options.call( elem, i, curOffset );
		}

		if (options.top != null) {
			props.top = (options.top - curOffset.top) + curTop;
		}
		if (options.left != null) {
			props.left = (options.left - curOffset.left) + curLeft;
		}

		if ( "using" in options ) {
			options.using.call( elem, props );
		} else {
			curElem.css( props );
		}
	}
};


jQuery.fn.extend({
	position: function() {
		if ( !this[0] ) {
			return null;
		}

		var elem = this[0],

		// Get *real* offsetParent
		offsetParent = this.offsetParent(),

		// Get correct offsets
		offset       = this.offset(),
		parentOffset = rroot.test(offsetParent[0].nodeName) ? { top: 0, left: 0 } : offsetParent.offset();

		// Subtract element margins
		// note: when an element has margin: auto the offsetLeft and marginLeft
		// are the same in Safari causing offset.left to incorrectly be 0
		offset.top  -= parseFloat( jQuery.css(elem, "marginTop") ) || 0;
		offset.left -= parseFloat( jQuery.css(elem, "marginLeft") ) || 0;

		// Add offsetParent borders
		parentOffset.top  += parseFloat( jQuery.css(offsetParent[0], "borderTopWidth") ) || 0;
		parentOffset.left += parseFloat( jQuery.css(offsetParent[0], "borderLeftWidth") ) || 0;

		// Subtract the two offsets
		return {
			top:  offset.top  - parentOffset.top,
			left: offset.left - parentOffset.left
		};
	},

	offsetParent: function() {
		return this.map(function() {
			var offsetParent = this.offsetParent || document.body;
			while ( offsetParent && (!rroot.test(offsetParent.nodeName) && jQuery.css(offsetParent, "position") === "static") ) {
				offsetParent = offsetParent.offsetParent;
			}
			return offsetParent;
		});
	}
});


// Create scrollLeft and scrollTop methods
jQuery.each( ["Left", "Top"], function( i, name ) {
	var method = "scroll" + name;

	jQuery.fn[ method ] = function( val ) {
		var elem, win;

		if ( val === undefined ) {
			elem = this[ 0 ];

			if ( !elem ) {
				return null;
			}

			win = getWindow( elem );

			// Return the scroll offset
			return win ? ("pageXOffset" in win) ? win[ i ? "pageYOffset" : "pageXOffset" ] :
				jQuery.support.boxModel && win.document.documentElement[ method ] ||
					win.document.body[ method ] :
				elem[ method ];
		}

		// Set the scroll offset
		return this.each(function() {
			win = getWindow( this );

			if ( win ) {
				win.scrollTo(
					!i ? val : jQuery( win ).scrollLeft(),
					 i ? val : jQuery( win ).scrollTop()
				);

			} else {
				this[ method ] = val;
			}
		});
	};
});

function getWindow( elem ) {
	return jQuery.isWindow( elem ) ?
		elem :
		elem.nodeType === 9 ?
			elem.defaultView || elem.parentWindow :
			false;
}




// Create width, height, innerHeight, innerWidth, outerHeight and outerWidth methods
jQuery.each([ "Height", "Width" ], function( i, name ) {

	var type = name.toLowerCase();

	// innerHeight and innerWidth
	jQuery.fn[ "inner" + name ] = function() {
		var elem = this[0];
		return elem && elem.style ?
			parseFloat( jQuery.css( elem, type, "padding" ) ) :
			null;
	};

	// outerHeight and outerWidth
	jQuery.fn[ "outer" + name ] = function( margin ) {
		var elem = this[0];
		return elem && elem.style ?
			parseFloat( jQuery.css( elem, type, margin ? "margin" : "border" ) ) :
			null;
	};

	jQuery.fn[ type ] = function( size ) {
		// Get window width or height
		var elem = this[0];
		if ( !elem ) {
			return size == null ? null : this;
		}

		if ( jQuery.isFunction( size ) ) {
			return this.each(function( i ) {
				var self = jQuery( this );
				self[ type ]( size.call( this, i, self[ type ]() ) );
			});
		}

		if ( jQuery.isWindow( elem ) ) {
			// Everyone else use document.documentElement or document.body depending on Quirks vs Standards mode
			// 3rd condition allows Nokia support, as it supports the docElem prop but not CSS1Compat
			var docElemProp = elem.document.documentElement[ "client" + name ];
			return elem.document.compatMode === "CSS1Compat" && docElemProp ||
				elem.document.body[ "client" + name ] || docElemProp;

		// Get document width or height
		} else if ( elem.nodeType === 9 ) {
			// Either scroll[Width/Height] or offset[Width/Height], whichever is greater
			return Math.max(
				elem.documentElement["client" + name],
				elem.body["scroll" + name], elem.documentElement["scroll" + name],
				elem.body["offset" + name], elem.documentElement["offset" + name]
			);

		// Get or set width or height on the element
		} else if ( size === undefined ) {
			var orig = jQuery.css( elem, type ),
				ret = parseFloat( orig );

			return jQuery.isNaN( ret ) ? orig : ret;

		// Set the width or height on the element (default to pixels if value is unitless)
		} else {
			return this.css( type, typeof size === "string" ? size : size + "px" );
		}
	};

});


// Expose jQuery to the global object
window.jQuery = window.$ = jQuery;
})(window);