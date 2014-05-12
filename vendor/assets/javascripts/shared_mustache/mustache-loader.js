/*

Copyright (c) 2012, Bradley Wright
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/
/*
 * mustache-loader.js - Mustache template loader to go with flask-mustache
 *
 * This depends on jQuery, and Twitter's Hogan.js
 * https://github.com/twitter/hogan.js or
 *
 * Usage:
 *
 *   $('#target').mustache('includes/_user.mustache', {user_name:'Jan'});
 *   var html = $.mustache('includes/_user.mustache', {user_name:'Jan'});
 */

/*jslint
 browser: true,
 white: true,
 vars: true
*/

/*globals jQuery */

// authored as a jQuery plugin
(function($) {
    "use strict";

    // this is a cached lookup table of templates
    var cache = {};

    // only load partials once
    var partialsLoaded = false;

    var load = function(templateName) {
        // this function takes names like: "includes/_user.mustache"
        // and loads them from somewhere else.

        // they can be cached as functions, or as strings.
        // Strings are template content.
        if (typeof cache[templateName] === 'undefined') {
            if (document.getElementById(templateName)) {
                // stupid hack to turn HTML-encoded templates into strings, see:
                // http://stackoverflow.com/a/2419664/61435
                cache[templateName] = $('<div />').html(
                    $(document.getElementById(templateName)).html().trim()).text();
            }
            else if (window.templates && templates[templateName]){
                cache[templateName] = templates[templateName];
            }
        }

        return cache[templateName];
    };

    var loadPartials = function() {
        var templateName;

        if (partialsLoaded === false){
            if(typeof window.templates === "undefined"){
                $('script[type="text/mustache"]').each(function(i, el){
                    templateName = $(el).attr('id');
                    // stupid hack to turn HTML-encoded templates into strings, see:
                    // http://stackoverflow.com/a/2419664/61435
                    cache[templateName] = $('<div />').html($(el).html().trim()).text();
                });
            }
            else if (window.templates) {
                for(templateName in templates){
                    cache[templateName] = templates[templateName];
                }
            }
        }
    };


    var render = function(templateName, context) {
        // first we need to try and load the template and partials
        loadPartials();
        var template = load(templateName);

        if (typeof template === 'undefined') {
            $.error('Unknown template ' + templateName);
        }
        // pre-compiled hogan templates are objects
        else if (typeof template === 'object') {
            // template has been pre-compiled, just render and return it
            return template.render(context, cache);
        }

        // template hasn't been pre-compiled yet
        // so we need to do other things
        if (window.Hogan) {
            return window.Hogan.compile(template).render(context, cache);
        }

        // we don't have Hogan so we need to bail
        $.error('Must have Hogan.js to load string templates');
    };

    $.fn.mustache = function(templateName, context) {
        // replaces the content of the passed in element with the content
        // rendered by Mustache

        return this.html(render(templateName, context));
    };

    $.mustache = function(templateName, context) {
        // returns the compiled HTML

        return render(templateName, context);
    };
}(jQuery));
