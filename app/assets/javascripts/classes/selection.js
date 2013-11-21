// temp solution for editor block buttons

/**
 * dom utils
 */
window.dom = function() {
    var makePredByNodeName = function(sNodeName) {
        // nodeName of element is always uppercase.
        return function(node) { return node && node.nodeName === sNodeName; };
    };

    var isPara = function(node) {
        return node && /^P|^LI|^H[1-7]/.test(node.nodeName);
    };

    var isList = function(node) {
        return node && /^UL|^OL/.test(node.nodeName);
    };

    var isEditable = function(node) {
        return node && $(node).hasClass('note-editable');
    };

    var isControlSizing = function(node) {
        return node && $(node).hasClass('note-control-sizing');
    };

    // ancestor: find nearest ancestor predicate hit
    var ancestor = function(node, pred) {
        while (node) {
            if (pred(node)) { return node; }
            node = node.parentNode;
        }
        return null;
    };

    // listAncestor: listing ancestor nodes (until predicate hit: optional)
    var listAncestor = function(node, pred) {
        pred = pred || func.fail;

        var aAncestor = [];
        ancestor(node, function(el) {
            aAncestor.push(el);
            return pred(el);
        });
        return aAncestor;
    };

    // commonAncestor: find commonAncestor
    var commonAncestor = function(nodeA, nodeB) {
        var aAncestor = listAncestor(nodeA);
        for (var n = nodeB; n; n = n.parentNode) {
            if ($.inArray(n, aAncestor) > -1) { return n; }
        }
        return null; // difference document area
    };

    // listBetween: listing all Nodes between nodeA and nodeB
    // FIXME: nodeA and nodeB must be sorted, use comparePoints later.
    var listBetween = function(nodeA, nodeB) {
        var aNode = [];

        var bStart = false, bEnd = false;
        var fnWalk = function(node) {
            if (!node) { return; } // traverse fisnish
            if (node === nodeA) { bStart = true; } // start point
            if (bStart && !bEnd) { aNode.push(node) } // between
            if (node === nodeB) { bEnd = true; return; } // end point

            for (var idx = 0, sz = node.childNodes.length; idx < sz; idx++) {
                fnWalk(node.childNodes[idx]);
            }
        }

        fnWalk(commonAncestor(nodeA, nodeB)); // DFS with commonAcestor.
        return aNode;
    };

    // listPrev: listing prevSiblings (until predicate hit: optional)
    var listPrev = function(node, pred) {
        pred = pred || func.fail;

        var aNext = [];
        while (node) {
            aNext.push(node);
            if (pred(node)) { break; }
            node = node.previousSibling;
        };
        return aNext;
    };

    // listNext: listing nextSiblings (until predicate hit: optional)
    var listNext = function(node, pred) {
        pred = pred || func.fail;

        var aNext = [];
        while (node) {
            aNext.push(node);
            if (pred(node)) { break; }
            node = node.nextSibling;
        };
        return aNext;
    };

    // insertAfter: insert node after preceding
    var insertAfter = function(node, preceding) {
        var next = preceding.nextSibling, parent = preceding.parentNode;
        if (next) {
            parent.insertBefore(node, next);
        } else {
            parent.appendChild(node);
        }
        return node;
    };

    // appends: append children
    var appends = function(node, aChild) {
        $.each(aChild, function(idx, child) {
            node.appendChild(child);
        });
        return node;
    };

    var isText = makePredByNodeName('#text');

    // length: size of element.
    var length = function(node) {
        if (isText(node)) { return node.nodeValue.length; }
        return node.childNodes.length;
    };

    // position: offset from parent.
    var position = function(node) {
        var offset = 0;
        while (node = node.previousSibling) { offset += 1; }
        return offset;
    };

    // makeOffsetPath: return offsetPath(offset list) from ancestor
    var makeOffsetPath = function(ancestor, node) {
        var aAncestor = list.initial(listAncestor(node, func.eq(ancestor)));
        return $.map(aAncestor, position).reverse();
    };

    // fromtOffsetPath: return element from offsetPath(offset list)
    var fromOffsetPath = function(ancestor, aOffset) {
        var current = ancestor;
        for (var i = 0, sz = aOffset.length; i < sz; i++) {
            current = current.childNodes[aOffset[i]];
        }
        return current;
    };

    // splitData: split element or #text
    var splitData = function(node, offset) {
        if (offset === 0) { return node; }
        if (offset >= length(node)) { return node.nextSibling; }

        // splitText
        if (isText(node)) { return node.splitText(offset); }

        // splitElement
        var child = node.childNodes[offset];
        node = insertAfter(node.cloneNode(false), node);
        return appends(node, listNext(child));
    };

    // split: split dom tree by boundaryPoint(pivot and offset)
    var split = function(root, pivot, offset) {
        var aAncestor = listAncestor(pivot, func.eq(root));
        if (aAncestor.length === 1) { return splitData(pivot, offset); }
        return aAncestor.reduce(function(node, parent) {
            var clone = parent.cloneNode(false);
            insertAfter(clone, parent);
            if (node === pivot) {
                node = splitData(node, offset);
            }
            appends(clone, listNext(node));
            return clone;
        });
    };

    // remove: remove node, (bRemoveChild: remove child or not)
    var remove = function(node, bRemoveChild) {
        if (!node || !node.parentNode) { return; }
        if (node.removeNode) { return node.removeNode(bRemoveChild); }

        var elParent = node.parentNode;
        if (!bRemoveChild) {
            var aNode = [];
            for (var i = 0, sz = node.childNodes.length; i < sz; i++) {
                aNode.push(node.childNodes[i]);
            }

            for (var i = 0, sz = aNode.length; i < sz; i++) {
                elParent.insertBefore(aNode[i], node);
            }
        }

        elParent.removeChild(node);
    };

    var unescape = function(str) {
        return $("<div/>").html(str).text();
    };
    var html = function($node) {
        return dom.isTextarea($node[0]) ? unescape($node.val()) : $node.html();
    };

    return {
        isText: isText,
        isPara: isPara, isList: isList,
        isEditable: isEditable, isControlSizing: isControlSizing,
        isAnchor: makePredByNodeName('A'),
        isDiv: makePredByNodeName('DIV'), isSpan: makePredByNodeName('SPAN'),
        isB: makePredByNodeName('B'), isU: makePredByNodeName('U'),
        isS: makePredByNodeName('S'), isI: makePredByNodeName('I'),
        isImg: makePredByNodeName('IMG'), isTextarea: makePredByNodeName('TEXTAREA'),
        ancestor: ancestor, listAncestor: listAncestor,
        listNext: listNext, listPrev: listPrev,
        commonAncestor: commonAncestor, listBetween: listBetween,
        insertAfter: insertAfter, position: position,
        makeOffsetPath: makeOffsetPath, fromOffsetPath: fromOffsetPath,
        split: split, remove: remove, html: html
    };
}();

window.selection = function() {
    var bW3CRangeSupport = !!document.createRange;

    // return boundaryPoint from TextRange, inspired by Andy Na's HuskyRange.js
    var textRange2bp = function(textRange, bStart) {
        var elCont = textRange.parentElement(), nOffset;

        var tester = document.body.createTextRange(), elPrevCont;
        var aChild = list.from(elCont.childNodes);
        for (nOffset = 0; nOffset < aChild.length; nOffset++) {
            if (dom.isText(aChild[nOffset])) { continue; }
            tester.moveToElementText(aChild[nOffset]);
            if (tester.compareEndPoints('StartToStart', textRange) >= 0) { break; }
            elPrevCont = aChild[nOffset];
        }

        if (nOffset != 0 && dom.isText(aChild[nOffset - 1])) {
            var textRangeStart = document.body.createTextRange(), elCurText = null;
            textRangeStart.moveToElementText(elPrevCont || elCont);
            textRangeStart.collapse(!elPrevCont);
            elCurText = elPrevCont ? elPrevCont.nextSibling : elCont.firstChild;

            var pointTester = textRange.duplicate();
            pointTester.setEndPoint('StartToStart', textRangeStart);
            var nTextCount = pointTester.text.replace(/[\r\n]/g, '').length;

            while (nTextCount > elCurText.nodeValue.length && elCurText.nextSibling) {
                nTextCount -= elCurText.nodeValue.length;
                elCurText = elCurText.nextSibling;
            }
            var sDummy = elCurText.nodeValue; //enforce IE to re-reference elCurText

            if (bStart && elCurText.nextSibling && dom.isText(elCurText.nextSibling) &&
                nTextCount == elCurText.nodeValue.length) {
                nTextCount -= elCurText.nodeValue.length;
                elCurText = elCurText.nextSibling;
            }

            elCont = elCurText;
            nOffset = nTextCount;
        }

        return {cont: elCont, offset: nOffset};
    };

    // return TextRange from boundary point (inspired by google closure-library)
    var bp2textRange = function(bp) {
        var textRangeInfo = function(elCont, nOffset) {
            var elNode, bCollapseToStart;

            if (dom.isText(elCont)) {
                var aPrevText = dom.listPrev(elCont, func.not(dom.isText));
                var elPrevCont = list.last(aPrevText).previousSibling;
                elNode =  elPrevCont || elCont.parentNode;
                nOffset += list.sum(list.tail(aPrevText), dom.length);
                bCollapseToStart = !elPrevCont;
            } else {
                elNode = elCont.childNodes[nOffset] || elCont;
                if (dom.isText(elNode)) {
                    return textRangeInfo(elNode, nOffset);
                }

                nOffset = 0;
                bCollapseToStart = false;
            }

            return {cont: elNode, collapseToStart: bCollapseToStart, offset: nOffset};
        }

        var textRange = document.body.createTextRange();
        var info = textRangeInfo(bp.cont, bp.offset);

        textRange.moveToElementText(info.cont);
        textRange.collapse(info.collapseToStart);
        textRange.moveStart('character', info.offset);
        return textRange;
    };

    // {startContainer, startOffset, endContainer, endOffset}
    var WrappedRange = function(sc, so, ec, eo) {
        this.sc = sc; this.so = so;
        this.ec = ec; this.eo = eo;

        // nativeRange: get nativeRange from sc, so, ec, eo
        var nativeRange = function() {
            if (bW3CRangeSupport) {
                var w3cRange = document.createRange();
                w3cRange.setStart(sc, so);
                w3cRange.setEnd(ec, eo);
                return w3cRange;
            } else {
                var textRange = bp2textRange({cont:sc, offset:so});
                textRange.setEndPoint('EndToEnd', bp2textRange({cont:ec, offset:eo}));
                return textRange;
            }
        };

        // select: update visible range
        this.select = function() {
            var nativeRng = nativeRange();
            if (bW3CRangeSupport) {
                var selection = document.getSelection();
                if (selection.rangeCount > 0) { selection.removeAllRanges(); }
                selection.addRange(nativeRng);
            } else {
                nativeRng.select();
            }
        };

//        // listPara: listing paragraphs on range
//        this.listPara = function() {
//            var aNode = dom.listBetween(sc, ec);
//            var aPara = list.compact($.map(aNode, function(node) {
//                return dom.ancestor(node, dom.isPara);
//            }));
//            return $.map(list.clusterBy(aPara, func.eq2), list.head);
//        };

        // makeIsOn: return isOn(pred) function
        var makeIsOn = function(pred) {
            return function() {
                var elAncestor = dom.ancestor(sc, pred);
                return elAncestor && (elAncestor === dom.ancestor(ec, pred));
            };
        };

        // isOnEditable: judge whether range is on editable or not
        this.isOnEditable = makeIsOn(dom.isEditable);
        // isOnList: judge whether range is on list node or not
        this.isOnList = makeIsOn(dom.isList);
        // isOnAnchor: judge whether range is on anchor node or not
        this.isOnAnchor = makeIsOn(dom.isAnchor);

        // isCollapsed: judge whether range was collapsed
        this.isCollapsed = function() { return sc === ec && so === eo; };

        // insertNode
        this.insertNode = function(node) {
            var nativeRng = nativeRange();
            if (bW3CRangeSupport) {
                nativeRng.insertNode(node);
            } else {
                nativeRng.pasteHTML(node.outerHTML); // NOTE: missing node reference.
            }
        };

        this.toString = function() {
            var nativeRng = nativeRange();
            if (bW3CRangeSupport) {
                return nativeRng.toString();
            } else {
                return nativeRng.text;
            }
        };

        //bookmark: offsetPath bookmark
        this.bookmark = function(elEditable) {
            return {
                s: { path: dom.makeOffsetPath(elEditable, sc), offset: so },
                e: { path: dom.makeOffsetPath(elEditable, ec), offset: eo }
            };
        };

        this.wrap = function(node) {
            var nativeRng = nativeRange();
            nativeRng.surroundContents(node);
        }

//        this.wrap = function(new_html) {
//            var nativeRng = nativeRange();
//            this.replace(new_html)
//        }

        this.replace = function(html) {
            if (typeof window.getSelection != "undefined") {
                // IE 9 and other non-IE browsers
                var sel = window.getSelection();

                // Test that the Selection object contains at least one Range
                if (sel.getRangeAt && sel.rangeCount) {
                    // Get the first Range (only Firefox supports more than one)
                    range = window.getSelection().getRangeAt(0);
                    range.deleteContents();

                    // Create a DocumentFragment to insert and populate it with HTML
                    // Need to test for the existence of range.createContextualFragment
                    // because it's non-standard and IE 9 does not support it
                    if (range.createContextualFragment) {
                        node = range.createContextualFragment(html);
                    } else {
                        // In IE 9 we need to use innerHTML of a temporary element
                        var div = document.createElement("div"), child;
                        div.innerHTML = html;
                        node = document.createDocumentFragment();
                        while ( (child = div.firstChild) ) {
                            node.appendChild(child);
                        }
                    }
                    range.insertNode(node);
                }
            } else if (document.selection && document.selection.type != "Control") {
                // IE 8 and below
                range = document.selection.createRange();
                range.pasteHTML(html);
            }
        };
    };

    return { // Range Object
        // create Range Object From arguments or Browser Selection
        create : function(sc, so, ec, eo) {
            if (arguments.length === 0) { // from Browser Selection
                if (bW3CRangeSupport) { // webkit, firefox
                    var nativeRng = document.getSelection().getRangeAt(0);
                    sc = nativeRng.startContainer, so = nativeRng.startOffset,
                        ec = nativeRng.endContainer, eo = nativeRng.endOffset;
                } else { // IE8: TextRange
                    var textRange = document.selection.createRange();
                    var textRangeEnd = textRange.duplicate(); textRangeEnd.collapse(false);
                    var textRangeStart = textRange; textRangeStart.collapse(true);

                    var bpStart = textRange2bp(textRangeStart, true),
                        bpEnd = textRange2bp(textRangeEnd, false);

                    sc = bpStart.cont, so = bpStart.offset;
                    ec = bpEnd.cont, eo = bpEnd.offset;
                }
            } else if (arguments.length === 2) { //collapsed
                ec = sc; eo = so;
            }
            return new WrappedRange(sc, so, ec, eo);
        },
        // createFromBookmark
        createFromBookmark : function(elEditable, bookmark) {
            var sc = dom.fromOffsetPath(elEditable, bookmark.s.path);
            var so = bookmark.s.offset;
            var ec = dom.fromOffsetPath(elEditable, bookmark.e.path);
            var eo = bookmark.e.offset;
            return new WrappedRange(sc, so, ec, eo);
        }
    };
}();