/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
(function(){function t(t){var n=t.getElementsByTag("*"),r=n.count(),i;for(var s=0;s<r;s++)i=n.getItem(s),function(t){for(var n=0;n<e.length;n++)(function(e){var n=t.getAttribute("on"+e);t.hasAttribute("on"+e)&&(t.removeAttribute("on"+e),t.on(e,function(e){var r=/(return\s*)?CKEDITOR\.tools\.callFunction\(([^)]+)\)/.exec(n),i=r&&r[1],s=r&&r[2].split(","),o=/return false;/.test(n);if(s){var u=s.length,a;for(var f=0;f<u;f++){s[f]=a=CKEDITOR.tools.trim(s[f]);var l=a.match(/^(["'])([^"']*?)\1$/);if(l){s[f]=l[2];continue}if(a.match(/\d+/)){s[f]=parseInt(a,10);continue}switch(a){case"this":s[f]=t.$;break;case"event":s[f]=e.data.$;break;case"null":s[f]=null}}var c=CKEDITOR.tools.callFunction.apply(window,s);i&&c===!1&&(o=1)}o&&e.data.preventDefault()}))})(e[n])}(i)}var e=["click","keydown","mousedown","keypress","mouseover","mouseout"];CKEDITOR.plugins.add("adobeair",{init:function(e){if(!CKEDITOR.env.air)return;e.addCss("body { padding: 8px }"),e.on("uiReady",function(){t(e.container);if(e.sharedSpaces)for(var n in e.sharedSpaces)t(e.sharedSpaces[n]);e.on("elementsPathUpdate",function(e){t(e.data.space)})}),e.on("contentDom",function(){e.document.on("click",function(e){e.data.preventDefault(!0)})})}}),CKEDITOR.ui.on("ready",function(e){var n=e.data;if(n._.panel){var r=n._.panel._.panel,i;(function(){if(!r.isLoaded){setTimeout(arguments.callee,30);return}i=r._.holder,t(i)})()}else n instanceof CKEDITOR.dialog&&t(n._.element)})})(),CKEDITOR.dom.document.prototype.write=CKEDITOR.tools.override(CKEDITOR.dom.document.prototype.write,function(e){function t(e,t,n,r){var i=e.append(t),s=CKEDITOR.htmlParser.fragment.fromHtml(n).children[0].attributes;s&&i.setAttributes(s),r&&i.append(e.getDocument().createText(r))}return function(n,r){if(this.getBody()){var i=this,s=this.getHead();n=n.replace(/(<style[^>]*>)([\s\S]*?)<\/style>/gi,function(e,n,r){return t(s,"style",n,r),""}),n=n.replace(/<base\b[^>]*\/>/i,function(e){return t(s,"base",e),""}),n=n.replace(/<title>([\s\S]*)<\/title>/i,function(e,t){return i.$.title=t,""}),n=n.replace(/<head>([\s\S]*)<\/head>/i,function(e){var t=new CKEDITOR.dom.element("div",i);return t.setHtml(e),t.moveChildren(s),""}),n.replace(/(<body[^>]*>)([\s\S]*)(?=$|<\/body>)/i,function(e,t,n){i.getBody().setHtml(n);var r=CKEDITOR.htmlParser.fragment.fromHtml(t).children[0].attributes;r&&i.getBody().setAttributes(r)})}else e.apply(this,arguments)}});