// JSON parser
this.JSON || (this.JSON = {}),
function () {
    function f(e) {
        return e < 10 ? "0" + e : e
    }

    function quote(e) {
        return escapable.lastIndex = 0, escapable.test(e) ? '"' + e.replace(escapable, function (e) {
            var t = meta[e];
            return typeof t == "string" ? t : "\\u" + ("0000" + e.charCodeAt(0).toString(16)).slice(-4)
        }) + '"' : '"' + e + '"'
    }

    function str(e, t) {
        var n, r, i, s, o = gap,
            u, a = t[e];
        a && typeof a == "object" && typeof a.toJSON == "function" && (a = a.toJSON(e)), typeof rep == "function" && (a = rep.call(t, e, a));
        switch (typeof a) {
        case "string":
            return quote(a);
        case "number":
            return isFinite(a) ? String(a) : "null";
        case "boolean":
        case "null":
            return String(a);
        case "object":
            if (!a) return "null";
            gap += indent, u = [];
            if (Object.prototype.toString.apply(a) === "[object Array]") {
                s = a.length;
                for (n = 0; n < s; n += 1) u[n] = str(n, a) || "null";
                return i = u.length === 0 ? "[]" : gap ? "[\n" + gap + u.join(",\n" + gap) + "\n" + o + "]" : "[" + u.join(",") + "]", gap = o, i
            }
            if (rep && typeof rep == "object") {
                s = rep.length;
                for (n = 0; n < s; n += 1) r = rep[n], typeof r == "string" && (i = str(r, a), i && u.push(quote(r) + (gap ? ": " : ":") + i))
            } else
                for (r in a) Object.hasOwnProperty.call(a, r) && (i = str(r, a), i && u.push(quote(r) + (gap ? ": " : ":") + i));
            return i = u.length === 0 ? "{}" : gap ? "{\n" + gap + u.join(",\n" + gap) + "\n" + o + "}" : "{" + u.join(",") + "}", gap = o, i
        }
    }
    typeof Date.prototype.toJSON != "function" && (Date.prototype.toJSON = function (e) {
        return isFinite(this.valueOf()) ? this.getUTCFullYear() + "-" + f(this.getUTCMonth() + 1) + "-" + f(this.getUTCDate()) + "T" + f(this.getUTCHours()) + ":" + f(this.getUTCMinutes()) + ":" + f(this.getUTCSeconds()) + "Z" : null
    }, String.prototype.toJSON = Number.prototype.toJSON = Boolean.prototype.toJSON = function (e) {
        return this.valueOf()
    });
    var cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
        escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
        gap, indent, meta = {
            "\b": "\\b",
            " ": "\\t",
            "\n": "\\n",
            "\f": "\\f",
            "\r": "\\r",
            '"': '\\"',
            "\\": "\\\\"
        }, rep;
    typeof JSON.stringify != "function" && (JSON.stringify = function (e, t, n) {
        var r;
        gap = "", indent = "";
        if (typeof n == "number")
            for (r = 0; r < n; r += 1) indent += " ";
        else typeof n == "string" && (indent = n);
        rep = t;
        if (!t || typeof t == "function" || typeof t == "object" && typeof t.length == "number") return str("", {
            "": e
        });
        throw new Error("JSON.stringify")
    }),
    typeof JSON.parse != "function" && (JSON.parse = function (text, reviver) {
        function walk(e, t) {
            var n, r, i = e[t];
            if (i && typeof i == "object")
                for (n in i) Object.hasOwnProperty.call(i, n) && (r = walk(i, n), r !== undefined ? i[n] = r : delete i[n]);
            return reviver.call(e, t, i)
        }
        var j;
        text = String(text), cx.lastIndex = 0, cx.test(text) && (text = text.replace(cx, function (e) {
            return "\\u" + ("0000" + e.charCodeAt(0).toString(16)).slice(-4)
        }));
        if (/^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, "@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, "]").replace(/(?:^|:|,)(?:\s*\[)+/g, ""))) return j = eval("(" + text + ")"), typeof reviver == "function" ? walk({
            "": j
        }, "") : j;
        throw new SyntaxError("JSON.parse")
    })
}(), typeof window.Intercom != "function" && (window.Intercom = function () {
    window.Intercom.c(arguments)
}, window.Intercom.q = [], window.Intercom.c = function (e) {
    window.Intercom.q.push(e)
}), window.Intercom._classes = {}, window.Intercom.Util = {}, window.Intercom.Module = {}, window.Intercom.default_options = {
    fake_message_response: null
}, Intercom.Util.is_defined = function (e) {
    return typeof e != "undefined"
}, Intercom.Util.is_non_null = function (e) {
    return Intercom.Util.is_defined(e) && e !== null
}, Intercom.Util.index_of_in_array = function (e, t) {
    if (Array.prototype.indexOf) return e.indexOf(t);
    for (var n = 0, r = e.length; n < r; n++)
        if (e[n] === t) return n;
    return -1
}, Intercom.Util.duplicate_object = function (e) {
    var t = e instanceof Array ? [] : {};
    for (var n in e) {
        if (n == "clone") continue;
        e[n] && typeof e[n] == "object" ? t[n] = Intercom.Util.duplicate_object(e[n]) : t[n] = e[n]
    }
    return t
}, Intercom.Util.default_ajax_options = {
    type: "POST",
    data: "",
    jsonp_suffix: "",
    success: function () {},
    error: function () {}
}, Intercom.Util.is_empty = function (e) {
    for (var t in e) return !1;
    return !0
}, Intercom.Util.extend = function (e, t) {
    for (var n in t) t.hasOwnProperty(n) && typeof e[n] == "undefined" ? e[n] = t[n] : typeof t[n] == "object" && typeof e[n] == "object" && Intercom.Util.extend(e[n], t[n]);
    return e
}, Intercom.Util.ISO8601_to_date = function (e) {
    return new Date((e || "").replace(/-/g, "/").replace(/[TZ]/g, " "))
}, Intercom.Util.format_data_for_request = function (e) {
    var t = [];
    for (var n in e) {
        if (typeof e[n] == "undefined" || e[n] === null) continue;
        var r = null;
        switch (n) {
        case "require_utf8_enforcement":
            n = "utf8", r = "âœ“";
            break;
        case "request_type":
            break;
        default:
            r = e[n];
            if (typeof r == "object" || typeof r == "array") r = JSON.stringify(r);
            r = encodeURIComponent(r)
        }
        if (r === null) continue;
        var i = n + "=" + r;
        t.push(i)
    }
    return stringified = t.join("&"), stringified
}, Intercom.Util.ajax_call = function (e) {
    e = Intercom.Util.extend(Intercom.Util.duplicate_object(e), Intercom.Util.default_ajax_options);
    if (typeof e.url == "undefined") return;
    var t = "XHR";
    typeof e.request_method != "undefined" ? t = e.request_method : typeof XMLHttpRequest != "undefined" && ("withCredentials" in new XMLHttpRequest || typeof XDomainRequest != "undefined") ? typeof XDomainRequest != "undefined" && (t = "XDR") : t = "JSONP";
    if (t == "JSONP") {
        var n = "IntercomJSONP" + (new Date).getTime();
        window[n] = function (t) {
            typeof t == "string" && (t = JSON.parse(t)), e.success(t)
        };
        var r = document.createElement("SCRIPT");
        r.id = n, r.setAttribute("charset", "utf-8"), r.setAttribute("type", "text/javascript"), r.setAttribute("src", e.url + e.jsonp_suffix + "?" + e.data + "&callback=" + n + "&_=" + (new Date).getTime()), document.body.appendChild(r)
    } else {
        var i;
        if (t == "XDR") {
            i = new XDomainRequest;
            try {
                i.open(e.type, e.url)
            } catch (s) {
                Intercom.Util.ajax_call(Intercom.Util.extend({
                    request_method: "JSONP"
                }, e));
                return
            }
            i.ontimeout = function () {}, i.onprogress = function () {}, i.timeout = 1e4
        } else i = new XMLHttpRequest, i.open(e.type, e.url, !0), i.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        var o = function () {
            var t = i.response || i.responseText;
            typeof t == "string" && (t = JSON.parse(t)), e.success(t)
        }, u = function () {
                var t = i.response || i.responseText;
                if (typeof t == "string") try {
                    t = JSON.parse(t)
                } catch (n) {
                    Intercom.Util.log_unless_production('error parsing:"' + t + '"')
                }
                if (i.status == 403)
                    if (typeof t == "object" && typeof t.error_message == "string" && t.error_message == "app suspended") Intercom.Util.log("This app's Intercom account is suspended");
                    else {
                        var r = "You have enabled secure mode in your app and ";
                        typeof window.intercomSettings != "undefined" ? typeof window.intercomSettings.user_hash == "undefined" ? r += "your intercomSettings are missing the user_hash property." : r += "your user_hash property is not what we expect for this user." : r += " Intercom cannot authenticate this user.", Intercom.Util.log(r)
                    } else Intercom.Util.ajax_call(Intercom.Util.extend({
                        request_method: "JSONP"
                    }, e))
            };
        t == "XDR" ? (i.onload = o, i.onerror = u) : i.onreadystatechange = function () {
            i.readyState == 4 && (i.status >= 200 && i.status <= 206 ? o(i) : u(i))
        }, i.send(e.data.length > 0 ? e.data : null)
    }
}, Intercom.Util.get_ie_version_func = function () {
    var e, t = 3,
        n = document.createElement("div"),
        r = n.getElementsByTagName("i");
    while (n.innerHTML = "<!--[if gt IE " + ++t + "]><i></i><![endif]-->", r[0]);
    return t > 4 ? t : e
},
function (e) {
    typeof e == "undefined" && (e = {}), e.add_CSS = function (e, t) {
        if (e.length == 0) return;
        var n = document.createElement("style");
        n.type = "text/css", n.media = "all", n.className = t, n.styleSheet ? n.styleSheet.cssText = e : n.appendChild(document.createTextNode(e)), document.getElementsByTagName("head")[0].appendChild(n)
    }, e.HEX_to_HSL = function (e) {
        e = e.toUpperCase();
        var t = parseInt(e.substr(1, 2), 16) / 255,
            n = parseInt(e.substr(3, 2), 16) / 255,
            r = parseInt(e.substr(5, 2), 16) / 255,
            i = Math.max(t, n, r),
            s = Math.min(t, n, r),
            o, u, a = (i + s) / 2;
        if (i == s) o = u = 0;
        else {
            var f = i - s;
            u = a > .5 ? f / (2 - i - s) : f / (i + s);
            switch (i) {
            case t:
                o = (n - r) / f + (n < r ? 6 : 0);
                break;
            case n:
                o = (r - t) / f + 2;
                break;
            case r:
                o = (t - n) / f + 4
            }
            o /= 6
        }
        return [o, u, a]
    }, e.HSL_to_HEX = function (t, n, r) {
        var i, s, o;
        t = Math.min(t, 360), n = Math.min(n, 1), r = Math.min(r, 1), t == 360 && (t = 0), t = Math.max(t, 0), n = Math.max(n, 0), r = Math.max(r, 0);
        if (n == 0) i = s = o = r;
        else {
            function u(e, t, n) {
                return n < 0 && (n += 1), n > 1 && (n -= 1), n < 1 / 6 ? e + (t - e) * 6 * n : n < .5 ? t : n < 2 / 3 ? e + (t - e) * (2 / 3 - n) * 6 : e
            }
            var a = r < .5 ? r * (1 + n) : r + n - r * n,
                f = 2 * r - a;
            i = u(f, a, t + 1 / 3), s = u(f, a, t), o = u(f, a, t - 1 / 3)
        }
        var l = e.zero_pad_string(Math.round(i * 255).toString(16), 2),
            c = e.zero_pad_string(Math.round(s * 255).toString(16), 2),
            h = e.zero_pad_string(Math.round(o * 255).toString(16), 2);
        return "#" + l + c + h
    }, e.zero_pad_string = function (e, t) {
        while (e.length < t) e = "0" + e;
        return e
    }, e.generate_message_box_colors = function (t, n) {
        var n = typeof n == "undefined" ? t : n,
            r, i, s, o, u = e.HEX_to_HSL(t),
            a = u[0],
            f = u[1],
            l = u[2],
            c = 1 - Math.abs((l - .5) / .5);
        return r = e.HSL_to_HEX(a, f - .08511 * c, l + .1383 * c), i = e.HSL_to_HEX(a, f + .31915 * c, l - .24468 * c), s = e.HSL_to_HEX(a, f + .03191 * c, l + .08511 * c), o = e.HSL_to_HEX(a, f + .04255 * c, l + .24468 * c), {
            base: t,
            link: n,
            highlight: r,
            darker: i,
            hover: s,
            hover_highlight: o
        }
    }
}(Intercom.Util), typeof window.log == "undefined" ? Intercom.Util.log = function () {
    Intercom.Util.log.history = Intercom.Util.log.history || [], Intercom.Util.log.history.push(arguments), arguments.callee = arguments.callee.caller, window.console && console.log(Array.prototype.slice.call(arguments))
} : Intercom.Util.log = window.log, Intercom.Util.log_unless_production = function (e) {
    document.getElementById("NonProductionIntercomEnvironment") && Intercom.Util.log(e)
}, Intercom.Util.CSS = {}, Intercom.Util.CSS.replace_dynamic_colors = function (e, t) {
    return e = e.replace(/BASE_COLOR/g, t.base), e = e.replace(/LINK_COLOR/g, t.link), e = e.replace(/BASE_HIGHLIGHT_COLOR/g, t.highlight), e = e.replace(/DARKER_COLOR/g, t.darker), e = e.replace(/HOVER_COLOR/g, t.hover), e = e.replace(/HOVER_HIGHLIGHT_COLOR/g, t.hover_highlight), e
}, Intercom.Util.SelDotEct = {}, Intercom.Util.SelDotEct.Functions = {
    el_has_class: function (e, t) {
        var n = new RegExp("(^|\\s)+" + t + "(\\s+|$)");
        return n.test(e.className)
    },
    el_add_class: function (e, t) {
        if (Intercom.Util.SelDotEct.Functions.el_has_class(e, t)) return;
        e.className = e.className + " " + t
    },
    el_remove_class: function (e, t) {
        var n = new RegExp("(^|\\s)+" + t + "(\\s+|$)", "g");
        e.className = e.className.replace(n, "")
    },
    el_add_event_listener: function (e, t, n) {
        e.addEventListener(t, n, !1)
    },
    el_remove_event_listener: function (e, t, n) {
        e.removeEventListener(t, n, !1)
    },
    get_nodes: function (e, t) {
        return t === undefined && (t = document), t.querySelectorAll(e)
    }
};
if (document.createElement("DIV").classList) {
    var fns = Intercom.Util.SelDotEct.Functions;
    fns.el_has_class = function (e, t) {
        return e.classList.contains(t)
    }, fns.el_add_class = function (e, t) {
        return e.classList.add(t)
    }, fns.el_remove_class = function (e, t) {
        return e.classList.remove(t)
    }
}
document.addEventListener || (Intercom.Util.SelDotEct.Functions.el_add_event_listener = function (e, t, n) {
    e.attachEvent("on" + t, n)
}), document.removeEventListener || (Intercom.Util.SelDotEct.Functions.el_remove_event_listener = function (e, t, n) {
    e.detachEvent("on" + t, n)
}), typeof document.querySelectorAll == "undefined" && document.all && (Intercom.Util.SelDotEct.Functions.get_nodes = function (e, t) {
    t === undefined && (t = document);
    var n = document.styleSheets[0] || document.createStyleSheet(),
        r = [];
    n.addRule(e, "foo:bar");
    var i = t.all;
    for (var s = 0, o = i.length; s < o; s++) i[s].currentStyle.foo === "bar" && (r[r.length] = i[s]);
    return n.removeRule(0), r
}),
function () {
    "use strict";
    Intercom.Events = function () {
        var e = this;
        e.queue = [], e.handlers = [], e.throw_event = function (t, n) {
            if (typeof intercom_obj == "undefined") return;
            var r = {
                timestamp: (new Date).getTime(),
                type: t,
                data: n
            };
            e.queue.push(r);
            for (var i = 0, s = e.handlers.length; i < s; i++) e.handlers[i](t, n)
        }, e.register_handler = function (t, n, r) {
            if (typeof r != "undefined")
                for (var i = 0, s = e.queue.length; i < s; i++) r <= e.queue[i].timestamp && n(e.queue[i].type, e.queue[i].data);
            e.handlers.push(function (e, r) {
                (t === "all" || t === e) && n(e, r)
            })
        }, e.shutdown = function () {
            e.queue = null, e.handlers = null
        }
    }
}(),
function () {
    "use strict";
    Intercom.Inbox = function (e, t) {
        function i() {
            return typeof n.ie_version == "number" && n.ie_version in [6, 7, 8]
        }

        function s() {
            return n.options.inert && typeof n.options.fake_message_response != "undefined"
        }

        function o(e, t) {
            var n = Intercom.Util.index_of_in_array(t, e);
            n !== -1 && t.splice(n, 1)
        }
        var n = this;
        n.owner = t, n.pinging_server = !1, n.ping_queued = !1;
        var r = t.events;
        return n.options = Intercom.Util.extend(typeof e == "object" ? e : {}, Intercom.Inbox.default_options), n._data = {}, n.last_ping_response = "", n.still_to_call_backreference = !0, n.ie_version = Intercom.Util.get_ie_version_func(), n.init = function () {
            if (typeof n.ie_version != "number" && n.options.log_options_validation) {
                if (!n.options.user_data.app_id) return Intercom.Util.log("intercomSettings must have an app_id attribute"), !1;
                n.options.user_data.created_at == 1234567890 && Intercom.Util.log("Don't forget to set intercomSettings.created_at attribute to be your user's sign up date "), n.options.user_data.email == "john.doe@example.com" && Intercom.Util.log("Don't forget to set intercomSettings.email attribute to be your user's email ")
            }
            return n.ping_server(), n
        }, n.create_ic = function () {
            var e = new Image;
            e.src = "https://hello.intercom.io/ic.gif?user_id=" + n._data.user.id + "&app_id=" + n._data.app.id
        }, n.shutdown = function () {}, n.get_diagnostics = function () {
            var e = {
                last_ping_response: n.last_ping_response,
                _data: n._data
            };
            return e
        }, n.call_backreference = function () {
            n.options.onProcessData(n), n.still_to_call_backreference = !1
        }, n.queue_ping = function () {
            n.ping_queued = !0
        }, n.do_queued_ping = function () {
            n.ping_queued = !1, n.ping_server()
        }, n.ping_server = function () {
            if (typeof n.options.inert == "boolean" && n.options.inert) return;
            if (n.pinging_server) {
                n.queue_ping();
                return
            }
            n.pinging_server = !0;
            var e = n.options.ping_url,
                t = {
                    referer: location.href,
                    inbox_installed: n.options.inbox_installed,
                    require_utf8_enforcement: i(),
                    app_id: n.options.user_data.app_id,
                    user_data: n.options.user_data
                };
            t = Intercom.Util.format_data_for_request(t), Intercom.Util.ajax_call({
                type: "POST",
                url: e,
                data: t,
                success: n.process_ping_results
            })
        }, n.process_ping_results = function (e) {
            if (typeof intercom_obj == "undefined") return;
            n.last_ping_response = e;
            var t;
            n._data.unread_interrupt_conversation_ids === undefined ? t = [] : t = n._data.unread_interrupt_conversation_ids;
            var i;
            n._data = e, typeof n._data.app == "undefined" && (n._data.app = {}), n._data.app.id = n.options.user_data.app_id, n._data.unread_conversation_ids = Intercom.Util.duplicate_object(n._data.unread_inbox_conversation_ids);
            for (var s = 0, o = n._data.unread_interrupt_conversation_ids; s < o; s++) Intercom.Util.index_of_in_array(n._data.unread_conversation_ids, n._data.unread_interrupt_conversation_ids[s]) === -1 && n._data.unread_conversation_ids.push(n._data.unread_interrupt_conversation_ids[s]), i === undefined && Intercom.Util.index_of_in_array(t, n._data.unread_interrupt_conversation_ids[s]) === -1 && (i = n._data.unread_interrupt_conversation_ids[s]);
            i !== undefined && n.get_conversation(i, function (e) {
                r.throw_event("INTERRUPT", {
                    conversation: e
                })
            }), r.throw_event("PROCESSED_PING"), n.still_to_call_backreference && n.call_backreference(), n.pinging_server = !1, n.ping_queued && n.do_queued_ping(), n.create_ic()
        }, n.update_user_data = function (e) {
            if (e === undefined) return;
            n.options.user_data = Intercom.Util.extend(Intercom.Util.duplicate_object(e), Intercom.Util.duplicate_object(n.options.user_data)), typeof n.options.user_data.custom_data == "object" && (n.options.user_data.custom_data = Intercom.Util.extend(Intercom.Util.duplicate_object(e), Intercom.Util.duplicate_object(n.options.user_data.custom_data))), n.ping_server()
        }, n.get_app_settings = function () {
            return typeof n._data.app != "object" ? undefined : n._data.app
        }, n.get_module_settings = function () {
            return typeof n._data.modules != "object" ? undefined : n._data.modules
        }, n.get_user_settings = function () {
            return typeof n._data.user != "object" ? undefined : n._data.user
        }, n.is_conversation_read = function (e) {
            return Intercom.Util.index_of_in_array(n._data.unread_conversation_ids, e) === -1
        }, n.get_unread_count = function (e) {
            return e = Intercom.Util.extend(typeof e == "object" ? e : {}, {
                look_in: "all"
            }), e.look_in == "inbox" ? n._data.unread_inbox_conversation_ids.length : n._data.unread_conversation_ids.length
        }, n.are_all_conversations_read = function (e) {
            return n.get_unread_count(e) === 0
        }, n.created_by_user = function (e) {
            return !n.created_by_admin(e)
        }, n.created_by_admin = function (e) {
            return e !== undefined && e.from !== undefined && typeof e.from.is_admin == "boolean" && e.from.is_admin
        }, n.make_request = function (e, t, r) {
            var i = {
                app_id: n.options.user_data.app_id,
                user_data: {
                    email: n.options.user_data.email,
                    user_id: n.options.user_data.user_id,
                    user_hash: n.options.user_data.user_hash
                }
            };
            typeof r == "object" && (i = Intercom.Util.extend(r, i));
            var s;
            i.jsonp_suffix !== undefined && (s = i.jsonp_suffix, delete i.jsonp_suffix), i = Intercom.Util.format_data_for_request(i), Intercom.Util.ajax_call({
                type: "POST",
                url: e,
                data: i,
                jsonp_suffix: s,
                success: t
            })
        }, n.get_inbox = function (e) {
            n.make_request(n.options.inbox_url, function (t) {
                n.preprocess_inbox(t), e(t)
            })
        }, n.preprocess_inbox = function (e) {
            for (var t = 0, r = e.conversations.length; t < r; t++) e.conversations[t] = n.process_conversation(e.conversations[t])
        }, n.process_conversation = function (e) {
            var t = e.messages[e.messages.length - 1],
                n = e.messages[0];
            if (typeof e.text == "undefined" && typeof t.html == "string") {
                var r = document.createElement("SPAN"),
                    i = t.html;
                r.innerHTML = i.replace(/\<img[^\>]*\>/gi, "").replace(/\<iframe[^\>]*\>/gi, "").replace(/src\=\"[^\"]*\"/gi, "").replace(/src\=\'[^\"]*\'/gi, ""), e.text = r.innerText || r.textContent, r = null
            }
            typeof e.thread_id == "undefined" && typeof e.message_id == "number" && (e.thread_id = e.message_id);
            if (typeof e.title == "undefined" && typeof e.text == "string") {
                var s;
                typeof t.subject == "string" && t.subject.length > 0 ? s = t.subject : s = e.text;
                var o = s.substring(0, 36);
                o != s && (o += "..."), e.title = o
            }
            return e.last_message = t, e.first_message_has_avatar = Intercom.Util.is_defined(n.from) && Intercom.Util.is_defined(n.from.avatar) && Intercom.Util.is_non_null(n.from.avatar.square_25) && Intercom.Util.is_non_null(n.from.avatar.square_50), e.last_message_has_avatar = Intercom.Util.is_defined(t.from) && Intercom.Util.is_defined(t.from.avatar) && Intercom.Util.is_non_null(t.from.avatar.square_25) && Intercom.Util.is_non_null(t.from.avatar.square_50), e.updated_at_sorting = parseInt(e.updated_at.substr(0, 4) + e.updated_at.substr(5, 2) + e.updated_at.substr(8, 2) + e.updated_at.substr(11, 2) + e.updated_at.substr(14, 2) + e.updated_at.substr(17, 2), 10), e
        }, n.get_conversation = function (e, t) {
            n.make_request(n.options.conversation_url, function (e) {
                e.conversations[0] = n.process_conversation(e.conversations[0]), t(e.conversations[0])
            }, {
                id: e
            })
        }, n.mark_conversation_as_read = function (e) {
            if (typeof n.options.inert == "boolean" && n.options.inert) return;
            e !== undefined && !e.read && (n.remove_conversation_from_unread_arrays(e.thread_id), r.throw_event("CONVERSATION_MARKED_AS_READ", {
                conversation: {
                    thread_id: e.thread_id
                }
            }), n.make_request(n.options.read_marks_url, function () {}, {
                message_id: e.thread_id,
                jsonp_suffix: "/create"
            }))
        }, n.remove_conversation_from_unread_arrays = function (e) {
            o(e, n._data.unread_inbox_conversation_ids), o(e, n._data.unread_conversation_ids), o(e, n._data.unread_interrupt_conversation_ids)
        }, n.is_inbox_conversation = function (e) {
            if (e === undefined) return !1;
            var t = e.message_type === undefined ? e.interrupt ? "conversation" : "inbox" : e.message_type;
            return t == "inbox" || t == "email" || t == "conversation" || t == "announcement" || t == "notification" && e.read || n.conversation_has_comments(e)
        }, n.conversation_has_comments = function (e) {
            return typeof e == "object" && typeof e.messages == "object" && e.messages.length > 1
        }, n.get_next_interrupt = function (e) {
            n._data.unread_interrupt_conversation_ids === undefined || n._data.unread_interrupt_conversation_ids.length === 0 ? e() : n.get_conversation(n._data.unread_interrupt_conversation_ids[0], e)
        }, n.get_last_unread = function (e, t) {
            e = Intercom.Util.extend(typeof e == "object" ? e : {}, {
                look_in: "all"
            });
            var r = e.look_in == "inbox" ? n._data.unread_inbox_conversation_ids[0] : n._data.unread_conversation_ids[0];
            r === undefined ? t() : n.get_conversation(r, t)
        }, n.send_new_conversation = function (e) {
            if (typeof n.options.inert == "boolean" && n.options.inert) return;
            if (typeof e != "string" || e.length == 0) {
                r.throw_event("NEW_CONVERSATION_VALIDATION_FAILURE");
                return
            }
            r.throw_event("START_SENDING_NEW_CONVERSATION"), n.make_request(n.options.new_message_url, function (e) {
                r.throw_event("GET_NEW_CONVERSATION_SUCCESS", {
                    conversation: e.message
                })
            }, {
                referer: location.href,
                request_type: "message",
                body: e,
                require_utf8_enforcement: i(),
                jsonp_suffix: "/create"
            })
        }, n.send_user_response = function (e, t) {
            if (typeof n.options.inert == "boolean" && n.options.inert) return;
            if (typeof e != "number" || typeof t != "string" || t.length == 0) {
                r.throw_event("USER_RESPONSE_VALIDATION_FAILURE");
                return
            }
            r.throw_event("START_SENDING_USER_RESPONSE"), n.make_request(n.options.comments_url, function (e) {
                r.throw_event("GOT_USER_RESPONSE_SUCCESS", {
                    comment: e.comment
                })
            }, {
                referer: location.href,
                request_type: "comment",
                message_id: e,
                body: t,
                require_utf8_enforcement: i(),
                jsonp_suffix: "/create"
            })
        }, n.add_unread_conversation = function (e, t) {
            Intercom.Util.index_of_in_array(n._data.unread_conversation_ids, e) === -1 && (n._data.unread_conversation_ids.push(e), t && (n._data.unread_inbox_conversation_ids.push(e), r.throw_event("INBOX_READ_COUNT_CHANGED"), r.throw_event("INBOX_STALE")))
        }, n.add_interrupt = function (e) {
            Intercom.Util.index_of_in_array(n._data.unread_interrupt_conversation_ids, e) === -1 && (n._data.unread_interrupt_conversation_ids.push(e), n.get_conversation(e, function (e) {
                r.throw_event("INTERRUPT", {
                    conversation: e
                })
            }))
        }, n
    }
}(),
function () {
    var e = "https://api.intercom.io";
    document.getElementById("IntercomApiEndpointOverride") && (e = document.getElementById("IntercomApiEndpointOverride").getAttribute("content")), Intercom.api_endpoint = function () {
        return e
    }, Intercom.Inbox.default_options = {
        comments_url: Intercom.api_endpoint() + "/api/comments",
        new_message_url: Intercom.api_endpoint() + "/api/messages",
        read_marks_url: Intercom.api_endpoint() + "/api/read_marks",
        ping_url: Intercom.api_endpoint() + "/vjs/users/ping",
        conversation_url: Intercom.api_endpoint() + "/vjs/conversations/show",
        inbox_url: Intercom.api_endpoint() + "/vjs/conversations/inbox",
        diagnostics_url: Intercom.api_endpoint() + "/api/js_diagnostics",
        api_endpoint: Intercom.api_endpoint()
    }
}(), Intercom.Boot = function (e) {
    function n(e) {
        t.user_data = Intercom.Util.duplicate_object(e), delete t.user_data.modules, delete t.user_data.widget, delete t.user_data.inert, delete t.user_data.fake_message_response
    }

    function r(e) {
        return typeof e.widget == "string" ? e.widget = {
            activator: e.widget,
            use_activator: !0
        } : Intercom.Util.is_non_null(e.widget) ? e.widget = Intercom.Util.extend({
            activator: Intercom.Util.is_defined(e.widget.activator) ? e.widget.activator : "body>html>body",
            use_activator: !0
        }, e.widget) : e.widget = {
            activator: "body",
            use_activator: !1
        }, e
    }

    function i(e) {
        if (typeof e.modules != "undefined" || typeof e.widget != "object") return;
        e.modules = {}, e.modules.messages = Intercom.Util.duplicate_object(e.widget)
    }

    function s(e) {
        if (document.querySelectorAll && typeof e.modules == "object" && typeof e.modules.messages == "object" && typeof e.modules.messages.activator == "string" && typeof e.modules.messages.use_activator == "boolean" && e.modules.messages.use_activator) {
            var n = document.querySelectorAll(e.modules.messages.activator);
            for (var r = 0, i = n.length; r < i; r++) document.body.addEventListener ? n[r].addEventListener("click", t.store_click, !0) : n[r].attachEvent("onclick", t.store_click)
        }
    }

    function o() {
        return typeof t.ie_version == "number" && t.ie_version == 6
    }
    var t = this;
    return t.modules = [], t.ready = !1, t.on_ready = function () {}, t.modules_to_install = {}, t.ie_version = Intercom.Util.get_ie_version_func(), t.init = function () {
        return s(e), n(e), r(e), i(e), t.options = Intercom.Util.extend(e, Intercom.default_options), t.events = new Intercom.Events, t.events.throw_event("BOOTED"), t
    }, t.shutdown = function () {
        t.activator.shutdown(), t.shutdown_modules(), t.ready = !1, t.events = null, t.inbox = null
    }, t.shutdown_modules = function () {
        while (t.modules.length > 0) {
            var e = t.modules.shift();
            typeof e.shutdown == "function" && e.shutdown(), e = null
        }
    }, t.store_click = function (e) {
        return e = e || window.event, document.body.addEventListener ? this.setAttribute("intercom_click", "clicked") : e.srcElement.setAttribute("intercom_click", "clicked"), e.preventDefault ? e.preventDefault() : e.returnValue = !1, !1
    }, t.configure_which_modules_to_install = function (e) {
        t.module_is_disabled("messages") || (t.modules_to_install.messages = "https://static.intercomcdn.com/assets/messages-3257ef289c25d6715b90dcf24f3484b6.js");
        if (!t.module_is_disabled("pusher")) {
            var n = e.get_app_settings();
            typeof n == "object" && typeof n.paid == "boolean" && n.paid && (t.modules_to_install.pusher = "https://static.intercomcdn.com/assets/pusher-6ed4b969a10f94fcae068ea2088278d9.js")
        }
        if (!t.module_is_disabled("video_calls")) {
            var n = e.get_app_settings();
            typeof n == "object" && typeof n.paid == "boolean" && n.paid && typeof n.video_calls_enabled == "boolean" && n.video_calls_enabled && (t.modules_to_install.video_calls = "https://static.intercomcdn.com/assets/video_calls-829fb1f5e32cea6d0c252d982605ca9b.js")
        }
    }, t.module_is_disabled = function (e) {
        if (o()) return !0;
        if (e === "pusher") {
            var n = ["7guo5kws", "lyhlq848", "sj6g9cio"];
            if (Intercom.Util.index_of_in_array(n, t.user_data.app_id) !== -1) return !0
        }
        if (typeof t.options.disable_modules == "object")
            for (var r = 0, i = t.options.disable_modules.length; r < i; r++)
                if (t.options.disable_modules[r] == e) return !0;
        return e === "video_calls" && typeof t.ie_version == "number" ? !0 : !1
    }, t.install_modules = function () {
        var e = [],
            n = [],
            r = {};
        for (var i in window.Intercom.Module) n.push(i.toLowerCase()), r[i.toLowerCase()] = i;
        for (var s in t.modules_to_install) Intercom.Util.index_of_in_array(t.modules, s) == -1 ? e.push(t.modules_to_install[s]) : t.register_module(new r[s](t.options.modules[s], t));
        for (var o = 0, u = e.length; o < u; o++) {
            var a = document.createElement("SCRIPT");
            a.setAttribute("type", "text/javascript"), a.setAttribute("charset", "utf-8"), a.setAttribute("src", e[o]), document.body.appendChild(a)
        }
    }, t.register_module = function (e) {
        if (typeof t.modules_to_install[e["name"]] == "undefined") return;
        delete t.modules_to_install[e.name], e.owner = t, t.modules.push(e);
        for (var n in t.modules_to_install) return;
        t.boot_modules()
    }, t.boot_modules = function () {
        for (var e = 0, n = t.modules.length; e < n; e++) t.modules[e].boot();
        t.mark_as_ready()
    }, t.get_module = function (e) {
        for (var n = 0, r = t.modules.length; n < r; n++)
            if (t.modules[n].name == e) return t.modules[n]
    }, t.ping_ready = function (e) {
        t.merge_server_supplied_module_options(e), t.module_is_disabled("messages") || (t.activator = new Intercom.Activator(t.options.modules.messages, t), t.activator.init()), t.configure_which_modules_to_install(e);
        for (var n in t.modules_to_install) {
            t.install_modules();
            return
        }
        t.mark_as_ready()
    }, t.merge_server_supplied_module_options = function (e) {
        var n = e.get_module_settings();
        if (typeof n == "undefined") return;
        typeof t.options.modules == "undefined" ? t.options.modules = n : (Intercom.Util.extend(t.options.modules, n), typeof n.messages == "object" && typeof n.messages.template_partials == "object" && (t.options.modules.messages.template_partials = Intercom.Util.extend(Intercom.Util.duplicate_object(n.messages.template_partials), Intercom.Util.duplicate_object(t.options.modules.messages.template_partials))))
    }, t.mark_as_ready = function () {
        t.ready = !0, t.on_ready()
    }, t.send_diagnostics = function () {
        var e = {
            modules: {}
        };
        e.inbox = t.inbox.get_diagnostics();
        for (var n in t.modules) e.modules[t.modules[n].name] = typeof n.get_diagnostics == "function" ? n.get_diagnostics() : "No diagnostics";
        var r = Intercom.Util.format_data_for_request({
            dump: JSON.stringify(e),
            app_id: t.inbox.options.user_data.app_id,
            require_utf8_enforcement: typeof t.ie_version == "number" && t.ie_version in [6, 7, 8]
        });
        Intercom.Util.ajax_call({
            type: "POST",
            url: t.inbox.options.diagnostics_url,
            data: r,
            jsonp_suffix: "/create",
            success: function () {
                if (typeof intercom_obj == "undefined" || !intercom_obj.ready) return;
                t.events.throw_event("SENT_DIAGNOSTICS")
            }
        })
    }, t
},
function () {
    "use strict";
    Intercom.Activator = function (e, t) {
        function r(e, t) {
            if (e === null) return;
            if (e.length !== undefined)
                for (var n = 0, r = e.length; n < r; n++) t(e[n]);
            else fns(e)
        }

        function i() {
            var e = new Image;
            typeof window.devicePixelRatio != "undefined" && window.devicePixelRatio > 1 ? e.src = "https://static.intercomcdn.com/assets/message-box-sprites-2x-e208aaf4f0033df3bb22295d210991f2.png" : e.src = "https://static.intercomcdn.com/assets/message-box-sprites-52b6df2806c84dcdfb1b742925a248ab.png";
            var t = new Image;
            t.src = "https://static.intercomcdn.com/assets/message-box-loader-70ce371edcda81c7ba12a208581f3d43.gif"
        }

        function s(e, t) {
            r(e, function (e) {
                Intercom.Util.SelDotEct.Functions.el_add_class(e, t)
            })
        }

        function o(e, t) {
            r(e, function (e) {
                Intercom.Util.SelDotEct.Functions.el_remove_class(e, t)
            })
        }

        function u(e, t, n) {
            r(e, function (e) {
                Intercom.Util.SelDotEct.Functions.el_add_event_listener(e, t, n)
            })
        }

        function a(e, t, n) {
            r(e, function (e) {
                Intercom.Util.SelDotEct.Functions.el_remove_event_listener(e, t, n)
            })
        }

        function f(e) {
            for (var t = 0, n = e.childNodes.length; t < n; t++)
                if (e.childNodes[t].nodeType === 1) return !0;
            return !1
        }
        var n = this;
        n.owner = t, n.original_html = "", n.received_first_ping = !1, n.init = function () {
            n.options = Intercom.Util.extend(Intercom.Util.extend({}, Intercom.Util.duplicate_object(e)), Intercom.Activator.default_options), i(), Intercom.Util.add_CSS(n.css_string(), "ic_intercom_activator"), n.selector = n.options.activator, n.setup_references_to_elements(), n.attach(), n.update(), n.owner.events.register_handler("all", n.receive_event, 0), n.owner.events.throw_event("ACTIVATOR_READY"), n.options.use_activator && r(n.els, function (e) {
                e.style.visibility = "visible", e.getAttribute("intercom_click") !== null && (e.removeAttribute("intercom_click"), n.owner.events.throw_event("ACTIVATOR_CLICKED"), Intercom("show"))
            })
        }, n.receive_event = function (e, t) {
            switch (e) {
            case "CONVERSATION_MARKED_AS_READ":
            case "INBOX_READ_COUNT_CHANGED":
                n.update();
                break;
            case "PROCESSED_PING":
                n.update_on_subsequent_pings();
            default:
            }
        }, n.setup_references_to_elements = function () {
            n.els = Intercom.Util.SelDotEct.Functions.get_nodes(n.selector), n.el = n.els.length == 0 ? null : n.els[0]
        }, n.attach = function () {
            n.el === null && (n.options.activator === "#IntercomDefaultWidget" && n.options.use_activator ? (n.options.activator = n.add_default_widget_wrapper(typeof e.label == "string" ? e.label : undefined), n.selector = n.options.activator, n.options.activator_html = Intercom.Activator.default_options.activator_html, n.options.use_counter = !0) : (n.options.activator = "body", n.selector = n.options.activator, n.options.use_activator = !1), n.setup_references_to_elements()), n.options.use_activator && n.el !== null ? (r(n.els, function (e) {
                e.setAttribute("data-Intercom_original_html", e.innerHTML)
            }), n.original_html = n.el.innerHTML, a(n.els, "click", n.show_message_box), u(n.els, "click", n.show_message_box)) : n.options.use_activator = !1
        }, n.reattach = function () {
            n.setup_references_to_elements(), n.attach(), n.reset_activator_html(), n.update()
        }, n.activator_html_functions = {
            unwrapped_with_span: function (e) {
                if (!n.options.use_activator) return;
                if (n.element_retains_html(e)) return;
                var t = n.owner.inbox.get_unread_count({
                    look_in: "inbox"
                });
                return typeof t == "undefined" && (t = 0), n.options.use_counter && t > 0 ? n.get_original_html(e) + ' <em class="unread_counter"><span>' + t + "</span></em>" : n.get_original_html(e)
            },
            brackets: function (e) {
                if (!n.options.use_activator) return;
                if (n.element_retains_html(e)) return;
                var t = n.owner.inbox.get_unread_count({
                    look_in: "inbox"
                });
                return typeof t == "undefined" && (t = 0), t > 0 ? n.get_original_html(e) + " (" + t + ")" : n.get_original_html(e)
            }
        }, n.reset_activator_html = function () {
            n.options.use_activator && n.el !== null && (r(n.els, function (e) {
                var t = Intercom.Util.SelDotEct.Functions.get_nodes("em.unread_counter", e);
                t.length > 0 && e.removeChild(t[0]), f(e) || (e.innerHTML = e.innerHTML.replace(/\s\([1-9]\d*\)/, "")), e.setAttribute("data-Intercom_original_html", e.innerHTML)
            }), n.original_html = n.el.innerHTML)
        }, n.get_original_html = function (e) {
            return typeof e == "undefined" ? n.original_html : e.getAttribute("data-Intercom_original_html")
        }, n.element_retains_html = function (e) {
            return typeof e == "undefined" ? !1 : e.getAttribute("data-intercom-retains-html") !== null
        }, n.add_default_widget_wrapper = function (e) {
            var t = typeof e == "undefined" ? "Support" : e,
                n = document.createElement("DIV");
            n.setAttribute("id", "IntercomDefaultWidget");
            var r = document.createElement("SPAN");
            r.innerHTML = t, n.appendChild(r), document.body.appendChild(n);
            var i = document.getElementById("INotificationMessagesWrapper");
            return s(i, "ic_with_default_widget"), "#IntercomDefaultWidget"
        }, n.update = function () {
            n.options.use_activator && (n.owner.inbox.get_unread_count({
                look_in: "inbox"
            }) === 0 ? o(n.els, "unread") : s(n.els, "unread"), r(n.els, function (e) {
                e.innerHTML = n.generate_activator_html(e)
            }))
        }, n.update_on_subsequent_pings = function () {
            n.received_first_ping ? n.update() : n.received_first_ping = !0
        }, n.generate_activator_html = function (e) {
            return typeof n.options.activator_html == "function" ? n.options.activator_html(n, e) : n.options.activator_html
        }, n.css_string = function () {
            var e = '#IntercomDefaultWidget,#IntercomDefaultWidget span,#IntercomDefaultWidget em{alignment-adjust:auto;alignment-baseline:baseline;-webkit-animation:none 0 ease 0 1 normal;-moz-animation:none 0 ease 0 1 normal;-ms-animation:none 0 ease 0 1 normal;animation:none 0 ease 0 1 normal;-webkit-animation-play-state:running;-moz-play-state:running;-ms-animation-play-state:running;animation-play-state:running;appearance:normal;azimuth:center;backface-visibility:visible;background:none 0 0 auto repeat scroll padding-box transparent;background-color:transparent;background-image:none;baseline-shift:baseline;binding:none;bleed:6pt;bookmark-label:content();bookmark-level:none;bookmark-state:open;bookmark-target:none;border:0 none transparent;-webkit-border-radius:0;-moz-border-radius:0;border-radius:0;bottom:auto;box-align:stretch;box-decoration-break:slice;box-direction:normal;box-flex:0.0;box-flex-group:1;box-lines:single;box-ordinal-group:1;box-orient:inline-axis;box-pack:start;-webkit-box-shadow:none;-moz-box-shadow:none;box-shadow:none;-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;break-after:auto;break-before:auto;break-inside:auto;caption-side:top;clear:none;clip:auto;color:inherit;color-profile:auto;-webkit-column-count:auto;-webkit-column-fill:balance;-webkit-column-gap:normal;-webkit-column-rule:medium medium #1f1f1f;-webkit-column-span:1;-webkit-column-width:auto;-webkit-columns:auto auto;-moz-column-count:auto;-moz-column-fill:balance;-moz-column-gap:normal;-moz-column-rule:medium medium #1f1f1f;-moz-column-span:1;-moz-column-width:auto;-moz-columns:auto auto;column-count:auto;column-fill:balance;column-gap:normal;column-rule:medium medium #1f1f1f;column-span:1;column-width:auto;columns:auto auto;content:normal;counter-increment:none;counter-reset:none;crop:auto;cursor:auto;direction:ltr;display:inline;dominant-baseline:auto;drop-initial-after-adjust:text-after-edge;drop-initial-after-align:baseline;drop-initial-before-adjust:text-before-edge;drop-initial-before-align:caps-height;drop-initial-size:auto;drop-initial-value:initial;elevation:level;empty-cells:show;fit:fill;fit-position:0% 0%;float:none;float-offset:0 0;font-family:"Helvetica Neue", Arial, sans-serif;font-size-adjust:none;font-size:100%;font-stretch:normal;font-style:normal;font-variant:normal;font-weight:normal;font:inherit;grid-columns:none;grid-rows:none;hanging-punctuation:none;height:auto;hyphenate-after:auto;hyphenate-before:auto;hyphenate-character:auto;hyphenate-lines:no-limit;hyphenate-resource:none;hyphens:manual;icon:auto;image-orientation:auto;image-rendering:auto;image-resolution:normal;inline-box-align:last;left:auto;letter-spacing:normal;line-height:inherit;line-stacking:inline-line-height exclude-ruby consider-shifts;list-style:disc outside none;margin:0;marks:none;marquee-direction:forward;marquee-loop:1;marquee-play-count:1;marquee-speed:normal;marquee-style:scroll;max-height:none;max-width:none;min-height:0;min-width:0;move-to:normal;nav-down:auto;nav-index:auto;nav-left:auto;nav-right:auto;nav-up:auto;opacity:1;orphans:2;outline:invert none medium;outline-offset:0;overflow:visible;overflow-style:auto;padding:0;page:auto;page-break-after:auto;page-break-before:auto;page-break-inside:auto;page-policy:start;perspective:none;perspective-origin:50% 50%;position:static;presentation-level:0;punctuation-trim:none;quotes:none;rendering-intent:auto;resize:none;right:auto;rotation:0;rotation-point:50% 50%;ruby-align:auto;ruby-overhang:none;ruby-position:before;ruby-span:none;size:auto;string-set:none;table-layout:auto;text-align:left;text-align-last:start;text-decoration:none;text-emphasis:none;text-height:auto;text-indent:0;text-justify:auto;text-outline:none;text-shadow:none;text-transform:none;text-wrap:normal;top:auto;-webkit-transform:none;-moz-transform:none;transform:none;-webkit-transform-origin:50% 50%;-moz-transform-origin:50% 50%;-o-transform-origin:50% 50%;transform-origin:50% 50% 0;transform-style:flat;-webkit-transition:all 0 ease 0;-moz-transition:all 0 ease 0;-o-transition:all 0 ease 0;transition:all 0 ease 0;unicode-bidi:normal;vertical-align:baseline;visibility:visible;white-space:normal;white-space-collapse:collapse;widows:2;width:auto;word-break:normal;word-spacing:normal;word-wrap:normal;z-index:auto;-ms-filter:"progid:DXImageTransform.Microsoft.gradient(enabled=false)";filter:progid:DXImageTransform.Microsoft.gradient(enabled=false)}#IntercomDefaultWidget{font-family:"Helvetica Neue", Arial, sans-serif;width:40px;height:40px;border:1px solid DARKER_COLOR;background-color:BASE_COLOR;-webkit-border-radius:3px;border-radius:3px;-moz-background-clip:padding;-webkit-background-clip:padding-box;background-clip:padding-box;position:fixed;right:20px;bottom:20px;z-index:2147483647;color:#fff;cursor:pointer}#IntercomDefaultWidget.ic_disabled,body.disable_intercom_widget #IntercomDefaultWidget{display:none}#IntercomDefaultWidget span{width:40px;height:39px;border-top:1px solid BASE_HIGHLIGHT_COLOR;background:transparent url(https://static.intercomcdn.com/assets/message-box-sprites-52b6df2806c84dcdfb1b742925a248ab.png) no-repeat -152px 0;background-size:274px 48px;display:block;text-indent:100%;white-space:nowrap;overflow:hidden;-webkit-border-radius:3px;border-radius:3px;cursor:pointer}#IntercomDefaultWidget em{position:absolute;right:-4px;top:-4px;border:1px solid #570404;background-color:#cb1f0d;height:13px;width:13px;-webkit-border-radius:2px;border-radius:2px}#IntercomDefaultWidget em span,#IntercomDefaultWidget:hover em span{width:100%;text-align:center;height:12px;display:block;border-top-color:#e45f52;background-image:none;font-style:normal;line-height:12px;font-size:9px;text-indent:0;-webkit-border-radius:0;border-radius:0}#IntercomDefaultWidget:hover{background-color:HOVER_COLOR}#IntercomDefaultWidget:hover span{border-top-color:HOVER_HIGHLIGHT_COLOR;background-position:-192px 0}\n';
            return e = Intercom.Util.CSS.replace_dynamic_colors(e, Intercom.Util.generate_message_box_colors(n.options.colors.base, n.options.colors.link)), e
        }, n.show_message_box = function (e) {
            return e === undefined && (e = window.event), e.cancelBubble = !0, e.returnValue = !1, typeof e.preventDefault != "undefined" && e.preventDefault(), n.owner.events.throw_event("ACTIVATOR_CLICKED"), Intercom("show"), !1
        }, n.shutdown = function () {
            a(n.els, "click", n.show_message_box), r(n.els, function (e) {
                e.removeAttribute("data-Intercom_original_html")
            });
            var e = document.getElementById("IntercomDefaultWidget");
            e && e.parentNode.removeChild(e)
        }
    }, Intercom.Activator.default_options = {
        activator: "#IntercomWidgetDefault",
        activator_html: function (e, t) {
            return e.activator_html_functions.unwrapped_with_span(t)
        }
    }
}(),
function () {
    var e = {};
    e.reattachActivator = function () {
        if (typeof intercom_obj == "undefined") return;
        typeof intercom_obj.activator == "object" && intercom_obj.activator.reattach()
    }, e.show = function () {
        if (typeof intercom_obj == "undefined") return;
        var e = this.get_module("messages");
        typeof e == "object" && typeof intercomJQuery != "undefined" && typeof intercomJQuery.cmodal == "function" && e.binding_point !== undefined && intercomJQuery.cmodal.show(e.binding_point.get(0))
    }, e.hide = function () {
        typeof intercomJQuery != "undefined" && typeof intercomJQuery.cmodal == "function" && intercomJQuery.cmodal.hide()
    }, e.update = function (e) {
        typeof intercom_obj == "undefined" ? window.Intercom.public_api.boot(e) : intercom_obj.inbox.update_user_data(e)
    }, e.boot = function (e) {
        typeof intercom_obj == "undefined" && (window.intercom_obj = (new Intercom.Boot(e)).init(), window.intercom_obj.on_ready = window.Intercom.process_queued_calls, Intercom.init_inbox())
    }, e.shutdown = function () {
        if (typeof intercom_obj == "undefined") return;
        intercom_obj.shutdown(), intercom_obj = undefined
    }, e.sendDiagnostics = function () {
        typeof intercom_obj != "undefined" && intercom_obj.send_diagnostics()
    }, e.onShow = function (e) {
        typeof intercom_obj != "undefined" && intercom_obj.events !== undefined && intercom_obj.events.register_handler("MODAL_SHOWN", function (t, n) {
            e(n)
        })
    }, e.onHide = function (e) {
        typeof intercom_obj != "undefined" && intercom_obj.events !== undefined && intercom_obj.events.register_handler("MODAL_HIDDEN", function (t, n) {
            e(n)
        })
    }, e.onActivatorClick = function (e) {
        typeof intercom_obj != "undefined" && intercom_obj.events !== undefined && intercom_obj.events.register_handler("ACTIVATOR_CLICKED", function (t, n) {
            e(n)
        })
    }, e.reattach_activator = e.reattachActivator, window.Intercom.public_api = e
}(), Intercom.init_inbox = function () {
    var e = intercom_obj.options,
        t = Intercom.Util.extend({
            user_data: intercom_obj.user_data,
            fake_message_response: e.fake_message_response,
            inert: e.inert,
            booter_backreference: intercom_obj,
            api_endpoint: Intercom.api_endpoint(),
            inbox_installed: typeof e.modules != "undefined" && typeof e.modules.messages != "undefined" && typeof e.modules.messages.activator != "undefined" && e.modules.messages.activator != "body",
            onProcessData: function (e) {
                e.options.booter_backreference.ping_ready(e)
            }
        }, e.inbox_options);
    intercom_obj.inbox = new Intercom.Inbox(t, intercom_obj), intercom_obj.inbox.init(), intercom_obj.store = {
        get_unread_count: function () {
            intercom_obj.inbox.get_unread_count({
                look_in: "inbox"
            })
        }
    }
}, typeof intercomSettings != "undefined" && (window.intercom_obj = (new Intercom.Boot(intercomSettings)).init(), Intercom.init_inbox()), window.Intercom.process_queued_calls = function () {
    window.Intercom.c = function (e) {
        e = Array.prototype.slice.call(e);
        var t = e.shift();
        if (typeof window.Intercom.public_api[t] == "function") {
            var n = typeof window.intercom_obj != "undefined" ? window.intercom_obj : this;
            return window.Intercom.public_api[t].apply(n, e)
        }
    };
    var e;
    while (e = window.Intercom.q.shift()) window.Intercom.c(e)
}, window.Intercom.look_for_boot_in_queued_calls = function () {
    var e = [],
        t, n;
    while (n = window.Intercom.q.shift()) {
        var r = Array.prototype.slice.call(n),
            i = r.shift();
        i === "boot" ? t = function () {
            window.Intercom.public_api.boot.apply(this, r)
        } : e.push(n)
    }
    window.Intercom.q = e, typeof t == "function" && t()
}, typeof window.intercom_obj == "object" && window.intercom_obj.ready ? window.Intercom.process_queued_calls() : typeof window.intercom_obj == "object" ? window.intercom_obj.on_ready = window.Intercom.process_queued_calls : (window.Intercom.look_for_boot_in_queued_calls(), typeof window.intercom_obj != "object" && (window.Intercom.c = function (e) {
    var t = Array.prototype.slice.call(e),
        n = t.shift();
    n === "boot" ? window.Intercom.public_api.boot.apply(this, t) : window.Intercom.q.push(e)
}));