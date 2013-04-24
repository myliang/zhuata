
// Generated by CoffeeScript 1.3.3
(function() {
  var $, util;

  util = {
    data: function(_self, key, value_callback) {
      var cache;
      cache = _self.data(key);
      if (cache == null) {
        cache = value_callback.call(_self);
        _self.data(key, cache);
      }
      return cache;
    },
    loading: function(obj) {
      this.target = obj;
      this.old = obj.text().replace(/(\r|\n|\r\n|\s)+/g, '');
      obj.addClass('disabled');
      obj.html(obj.html().replace(this.old, "&bull;&nbsp;&bull;&nbsp;&bull;"));
      return this;
    },
    unempty: function(obj) {
      return (obj != null) && !/^\s+$/.test(obj);
    },
    scroll: function() {
      return {
        w: $(document.body)[0].scrollWidth,
        h: $(document.body)[0].scrollHeight
      };
    },
    offset: function(source, target, arrow) {
      this.source = arguments[0].offset();
      this.source.w = arguments[0].outerWidth();
      this.source.h = arguments[0].outerHeight();
      this.target = {
        w: arguments[1].width(),
        h: arguments[1].height(),
        outer: {
          w: arguments[1].outerWidth(),
          h: arguments[1].outerHeight()
        }
      };
      this.target.padding = {
        w: this.target.outer.w - this.target.w,
        h: this.target.outer.h - this.target.h
      };
      this.arrow_size = arguments[2];
      this.scroll = util.scroll();
      if (arguments.length >= 4) {
        this.content = {
          w: arguments[3].outerWidth(),
          h: arguments[3].outerHeight()
        };
        this.target.outer.w = this.content.w + this.target.padding.w;
        this.target.outer.h = this.content.h + this.target.padding.h;
      }
      return this;
    }
  };

  util.loading.prototype = {
    recover: function() {
      return this.target.html(this.old);
    }
  };

  util.offset.prototype = {
    arrow: function(pos) {
      var border, ret;
      ret = {
        left: 0,
        top: 0,
        position: "absolute"
      };
      border = 1;
      switch (pos) {
        case "left":
          ret.left = this.source.left - this.arrow_size - border;
          ret.top = this.source.top + this.source.h / 2;
          break;
        case "right":
          ret.left = this.source.left + this.source.w + this.arrow_size + border;
          ret.top = this.source.top + this.source.h / 2;
          break;
        case "top":
          ret.left = this.source.left + this.source.w / 2;
          ret.top = this.source.top - this.arrow_size - border;
          break;
        case "bottom":
          ret.top = this.source.top + this.source.h + this.arrow_size + border;
          ret.left = this.source.left + this.source.w / 2;
      }
      return ret;
    },
    auto: function() {
      var h, w, w1;
      h = this.source.top / (this.scroll.h - this.source.top);
      w = this.source.left / (this.scroll.w - this.source.left);
      w1 = this.scroll.w - this.source.left;
      if (this.source.left > 0) {
        w1 = w1 / this.source.left;
      }
      if (h > w) {
        if (h > w1) {
          return "top";
        } else {
          return "right";
        }
      } else {
        if (h > w1) {
          return "left";
        } else {
          return "bottom";
        }
      }
    },
    center: function() {
      var ret;
      ret = {
        top: 0,
        left: 0
      };
      if (this.scroll.h > this.target.outer.h) {
        ret.top = (this.scroll.h - this.target.outer.h) / 2;
      }
      if (this.scroll.w > this.target.outer.w) {
        ret.left = (this.scroll.w - this.target.outer.w) / 2;
      }
      return this._wrap_result(ret);
    },
    top: function() {
      var ret;
      ret = {
        top: this.source.top - this.target.outer.h - this.arrow_size
      };
      return this._top_bottom(ret);
    },
    bottom: function() {
      var ret;
      ret = {
        top: this.source.top + this.source.h + this.arrow_size
      };
      return this._top_bottom(ret);
    },
    left: function() {
      var ret;
      ret = {
        left: this.source.left - this.target.outer.w - this.arrow_size
      };
      return this._left_right(ret);
    },
    right: function() {
      var ret;
      ret = {
        left: this.source.left + this.source.w + this.arrow_size
      };
      return this._left_right(ret);
    },
    _left_right: function(opt) {
      var muti;
      opt.top = this.source.top + this.source.h / 2 - this.target.outer.h / 2;
      muti = opt.top + this.target.outer.h - this.scroll.h;
      if (opt.top < 0) {
        opt.top = 0;
      } else if (muti > 0) {
        opt.top -= muti;
      }
      return this._wrap_result(opt);
    },
    _top_bottom: function(opt) {
      var muti;
      opt.left = this.source.left + this.source.w / 2 - this.target.outer.w / 2;
      muti = opt.left + this.target.outer.w - this.scroll.w;
      if (opt.left < 0) {
        opt.left = 0;
      } else if (muti > 0) {
        opt.left -= muti;
      }
      return this._wrap_result(opt);
    },
    _wrap_result: function(opt) {
      opt.w = this.target.w;
      opt.h = this.target.h;
      if (this.content != null) {
        opt.w = this.content.w;
        opt.h = this.content.h;
      }
      opt.position = "absolute";
      return opt;
    }
  };

  window.util = util;

  $ = jQuery;

  $.fn.wrapData = function(key, callback) {
    return util.data(this, key, callback);
  };

  $.fn.outerHtml = function() {
    return $('<div>').append(this.eq(0).clone().show()).html();
  };

  $.fn.rebind = function(event_name, func) {
    return this.unbind(event_name).bind(event_name, func);
  };

}).call(this);
// Generated by CoffeeScript 1.3.3
(function() {
  var $, cache_objects, _popup;

  $ = jQuery;

  cache_objects = [];

  _popup = function(self, option) {
    $.extend(this, option);
    this.self = $(self);
    return this;
  };

  _popup.prototype = {
    toggle: function() {
      if (this.self.is(this.except)) {
        return;
      }
      if (!this.self.hasClass('active')) {
        this.show();
      } else {
        this.hide();
      }
      return this;
    },
    show: function() {
      var offset, temp_offset,
        _this = this;
      this.body = this.get_content();
      this.arrow_doc = $("<div class=\"" + this.arrow_doc_class + "\"></div>");
      $(document.body).append(this.body).append(this.arrow_doc);
      this.body.off('click').on('click', function() {
        return false;
      });
      $('.close', this.body).off('click').on('click', function() {
        _this.hide();
        return false;
      });
      offset = new util.offset(this.self, this.body, this.offset);
      temp_offset = offset[this.direction]();
      if (this.direction === "auto") {
        this.direction = temp_offset;
        temp_offset = offset[temp_offset]();
      } else {
        temp_offset;

      }
      this.arrow_doc.addClass(this.direction).css(offset.arrow(this.direction));
      this.body.css(temp_offset).show();
      this.self.addClass('active');
      return this;
    },
    hide: function() {
      if (this.is_remove_if_hide) {
        this.body.remove();
      } else {
        this.body.hide();
      }
      this.arrow_doc.remove();
      this.self.removeClass('active');
      return this;
    },
    get_content: function() {
      var href, is_remove_if_hide;
      href = this.self.attr('href');
      if (typeof this.content === "function") {
        return this.default_content(this.content.call(this.self));
      } else if (typeof this.content === "object" && (this.content != null)) {
        return this.content;
      } else if ((href != null) && href.length > 1 && href[0] === "#") {
        is_remove_if_hide = true;
        return $(href);
      } else {
        return this.default_content();
      }
    },
    default_content: function() {
      var content, title;
      title = this.self.attr('data-title');
      if (title == null) {
        title = "提示信息";
      }
      if (arguments.length <= 0) {
        content = this.self.attr('data-content');
      } else {
        content = arguments[0];
      }
      if (title != null) {
        title = "<div class=\"header\">" + title + "<a href=\"#\" class=\"close\">&times</a></div>";
      } else {
        title = "";
      }
      content = $("<div style=\"display: none; max-width: " + this.max_width + "\">\n  <div class=\"popup border\">\n    " + title + "\n    <div class=\"body\">\n      " + content + "\n    </div>\n  </div>\n</div>");
      return content;
    }
  };

  $.fn.popup = function(option) {
    var binder;
    option = $.extend({}, $.fn.popup.defaults, option || {});
    binder = option.live ? "live" : "bind";
    return this[binder](option.trigger_name(), function() {
      var p;
      p = $(this).wrapData(option.cache_key_suffix, function() {
        return new _popup(this, option);
      });
      cache_objects.push(p);
      p.toggle();
      return false;
    });
  };

  $.fn.popup.defaults = {
    cache_key_suffix: "popup",
    direction: "auto",
    live: false,
    trigger: "click",
    offset: 10,
    except: '.disabled,:disabled,:animated',
    content: null,
    is_remove_if_hide: true,
    arrow_doc_class: "arrow-popup",
    max_width: "660px",
    trigger_name: function() {
      return this.trigger + "." + this.cache_key_suffix;
    },
    after: {
      show: function() {},
      hide: function() {}
    }
  };

  $.fn.popup.constructor = _popup;

  $(document).on('click', function() {
    $.each(cache_objects, function(index, ele) {
      return ele.hide();
    });
    return cache_objects = [];
  });

}).call(this);
// Generated by CoffeeScript 1.3.3
(function() {
  var $, get_tip, _tip;

  $ = jQuery;

  get_tip = function(_self, option) {
    return $(_self).wrapData(option.cache_key_suffix, function() {
      return new _tip(_self, option);
    });
  };

  _tip = function(_self, option) {
    $.extend(this, option);
    this.self = $(_self);
    return this;
  };

  _tip.prototype = $.extend({}, $.fn.popup.constructor.prototype, {
    get_content: function() {
      var content, title;
      title = this.self.attr('data-title');
      content = $("<div style=\"display: none; max-width: " + this.max_width + "\">\n  <div class=\"tip\">\n    " + title + "\n  </div>\n</div>");
      return content;
    }
  });

  $.fn.tip = function(option) {
    var binder, eventin, eventout;
    option = $.extend({}, $.fn.tip.defaults, option || {});
    binder = option.live ? "live" : "bind";
    eventin = option.trigger === "hover" ? "mouseenter" : "foucs";
    eventout = option.trigger === "hover" ? "mouseleave" : "blur";
    if (option.trigger.indexOf("click" === !-1)) {
      this[binder](option.trigger_name(), function() {
        get_tip(this, option).toggle();
        return false;
      });
    } else {
      this[binder](eventin, function() {
        get_tip(this, option).toggle();
        return false;
      })[binder](eventout, function() {
        get_tip(this, option).toggle();
        return false;
      });
    }
    return this;
  };

  $.fn.tip.defaults = $.extend({}, $.fn.popup.defaults, {
    cache_key_suffix: "tip",
    offset: 8,
    is_remove_if_hide: true,
    trigger: "hover",
    arrow_doc_class: "arrow-tip",
    max_width: "260px"
  });

}).call(this);
// Generated by CoffeeScript 1.3.3
(function() {
  var $, cache_objects, _menu;

  $ = jQuery;

  cache_objects = [];

  _menu = function(_self, option) {
    $.extend(this, option);
    this.self = $(_self);
    this.active = this.self;
    if (this.self.parent().is('li')) {
      this.active = this.self.parent();
    }
    return this;
  };

  _menu.prototype = {
    toggle: function() {
      if (this.self.is(this.except)) {
        return false;
      }
      if (this.active.hasClass('active')) {
        this.hide();
      } else {
        this.show();
      }
      return false;
    },
    show: function() {
      var source_padding, top;
      this.body = this.get_content();
      source_padding = (this.self.parent().outerHeight() - this.self.outerHeight()) / 2;
      top = this.self.outerHeight() + source_padding;
      if (this.direction === "up") {
        top -= this.body.outerHeight(true) + this.self.outerHeight();
      }
      this.body.css({
        top: top
      }).show();
      return this.active.addClass('active');
    },
    hide: function() {
      this.body.hide();
      return this.active.removeClass('active');
    },
    get_content: function() {
      return this.self.next();
    }
  };

  $.fn.menu = function(option) {
    var binder;
    option = $.extend({}, $.fn.menu.defaults, option || {});
    binder = option.live ? "live" : "bind";
    this[binder](option.trigger_name(), function(event) {
      var p;
      p = $(this).wrapData(option.cache_key_suffix, function() {
        return new _menu(this, option);
      });
      cache_objects.push(p);
      p.toggle();
      return false;
    });
    return this;
  };

  $.fn.menu.defaults = $.extend({}, $.fn.popup.defaults, {
    cache_key_suffix: "menu",
    direction: "down"
  });

  $(document).on('click.menu', function() {
    return $.each(cache_objects, function(index, ele) {
      return ele.hide();
    });
  });

}).call(this);
// Generated by CoffeeScript 1.3.3
(function() {
  var $, _form;

  $ = jQuery;

  _form = function(_self, option) {
    $.extend(this, option);
    this.self = $(_self);
    return this;
  };

  _form.prototype = {
    go: function() {
      var data, url,
        _this = this;
      this.form_tag = this.self.closest('form');
      if (this.self.is(this.except)) {
        return;
      }
      this.before.call(this.self);
      this.loading = new util.loading(this.self);
      url = this.url();
      data = this.form_tag.serialize();
      console.log("ajax.data=", data);
      $.ajaxSetup({
        beforeSend: function(xhr) {
          var token;
          token = $('meta[name=csrf-token]').attr('content');
          if (token != null) {
            return xhr.setRequestHeader('X-CSRF-Token', token);
          }
        }
      });
      $.post(url, data, function(msg) {
        return _this.post_after(msg);
      }).error(function(msg) {
        return _this.post_after(msg);
      });
      return false;
    },
    post_after: function(msg) {
      if (this.reset != null) {
        this.reset_after();
      }
      this.loading.recover();
      return this.after.call(this.self, msg);
    },
    reset_after: function() {
      return $(':input', this.form_tag).each(function() {
        var tag, type;
        type = this.type;
        tag = this.tagName.toLowerCase();
        if (tag === "textarea" || type === "text" || type === "email" || type === "password") {
          this.value = "";
        }
        return console.log('::::', type, ":::", tag);
      });
    },
    url: function() {
      return this.form_tag.attr('action') + this.url_suffix;
    }
  };

  $.fn.form = function(option) {
    var binder;
    option = $.extend({}, $.fn.form.defaults, option || {});
    binder = option.live ? "live" : "bind";
    this[binder](option.trigger_name(), function() {
      $(this).wrapData(option.cache_key_suffix, function() {
        return new _form(this, option);
      }).go();
      return false;
    });
    return this;
  };

  $.fn.form.defaults = {
    cache_key_suffix: "form",
    live: false,
    trigger: 'click',
    except: ".active,.disabled",
    url_suffix: ".json",
    reset: true,
    trigger_name: function() {
      return this.trigger + "." + this.cache_key_suffix;
    },
    after: function() {},
    before: function() {}
  };

}).call(this);
// Generated by CoffeeScript 1.3.3
(function() {
  var $, cache_objects, _paginate;

  $ = jQuery;

  cache_objects = [];

  _paginate = function(_self, option) {
    var at;
    $.extend(this, option);
    this.self = $(_self);
    at = this;
    $('a', this.self).on(this.trigger, function() {
      at.go(this);
      return false;
    });
    if (this.self.attr('data-url') != null) {
      this.url = this.self.attr('data-url');
    }
    if (this.init_load) {
      this.step(0);
    }
    return this;
  };

  _paginate.prototype = {
    go: function(node) {
      var self_p;
      this.node = $(node);
      try {
        self_p = $(node).parent();
        if (self_p.is(this.except)) {
          return;
        }
        if (self_p.hasClass('prev')) {
          this.prev();
        } else if (self_p.hasClass('next')) {
          this.next();
        }
      } catch (error) {

      }
      return this;
    },
    next: function() {
      if (!this.is_next()) {
        return;
      }
      return this.step(1);
    },
    prev: function() {
      if (!this.is_prev()) {
        return;
      }
      return this.step(-1);
    },
    goto: function(page) {
      this.page = page;
      return this.step(0);
    },
    step: function(offset) {
      var params,
        _this = this;
      this.page += offset;
      if (this.node != null) {
        this.loading = new util.loading(this.node);
      }
      params = {};
      params[this.page_name] = this.page;
      $.get(this.url + this.url_suffix, params, function(data) {
        return _this.get_after(data);
      }).error(function(data) {
        return _this.get_after(data);
      });
      return this;
    },
    is_prev: function() {
      return this.page > 1;
    },
    is_next: function() {
      return this.page < this.total_pages;
    },
    get_after: function(data) {
      if (this.page_rows != null) {
        this.page_rows = data.per_page;
        this.total_pages = data.total_pages;
      }
      this.after(this.self, data);
      this.set_other();
      if (this.node != null) {
        return this.loading.recover();
      }
    },
    set_other: function() {
      var n, p;
      if (this.total_pages <= 1) {
        this.self.remove();
        return;
      }
      p = $('.prev a', this.self);
      n = $('.next a', this.self);
      $('.current a', this.self).text(this.page);
      if (this.is_prev()) {
        if (p.hasClass('disabled')) {
          p.removeClass('disabled');
        }
      } else {
        p.addClass('disabled');
      }
      if (this.is_next()) {
        if (n.hasClass('disabled')) {
          return n.removeClass('disabled');
        }
      } else {
        return n.addClass('disabled');
      }
    }
  };

  $.fn.paginate = function(option) {
    var buf;
    option = $.extend({}, $.fn.paginate.defaults, option || {});
    buf = [];
    this.each(function() {
      return buf.push($(this).wrapData(option.cache_key_suffix, function() {
        return new _paginate(this, option);
      }));
    });
    return buf;
  };

  $.fn.paginate.defaults = {
    url: null,
    except: ".disabled",
    url_suffix: ".json",
    page: 1,
    page_rows: 20,
    total_rows: null,
    cache_key_suffix: 'paginate',
    trigger: 'click',
    page_name: 'page',
    trigger_name: function() {
      return this.trigger;
    },
    init_load: true,
    after: function(jel, msg) {}
  };

}).call(this);
// Generated by CoffeeScript 1.3.3
(function() {

  jQuery(function() {
    var input_label, text_area_blur, text_area_key_up;
    input_label = function() {
      var label;
      label = $(this).parent().prev();
      if (/^\s*$/.test(this.value)) {
        return label.show();
      } else {
        return label.hide();
      }
    };
    text_area_key_up = function(event) {
      var button;
      event = event || window.event;
      button = $(this).next();
      if (event.keyCode === 13 && event.ctrlKey) {
        button.click();
      }
      if (/^\s*$/.test(this.value)) {
        if (!button.hasClass('disabled')) {
          return button.addClass('disabled');
        }
      } else {
        return button.removeClass('disabled');
      }
    };
    text_area_blur = function() {
      var mp, tag;
      mp = $(this).parent();
      tag = this.tagName.toLowerCase();
      if (tag === "textarea") {
        if (/^\s*$/.test($(this).val())) {
          mp.parent().hide();
          return mp.parent().prev().show();
        }
      } else {
        mp.hide();
        return mp.next().show();
      }
    };
    $('.js-menu').menu();
    $('.form.small .fd > input').on('keyup', input_label);
    $('.js-paginate').paginate({
      after: function(je, data) {
        return je.parent().prev().html(data.content);
      }
    });
    $('.js-textarea').on('keyup', text_area_key_up).on('blur', text_area_blur);
    $('.js-form-page').form({
      after: function(data) {
        $('#js_paginate_result').prepend(data.content);
        return $('.js-textarea', $(this).parent()).blur();
      }
    });
    $('.js-form-nothing').form({
      after: function(data) {
        return $('.js-textarea', $(this).parent()).blur();
      }
    });
    $('.js-form-simple input').on('focus', function() {
      text_area_blur.call(this);
      return $('.js-textarea', $(this).parent().next()).focus();
    });
    setTimeout(function() {
      return $('.form.small .fd > input').each(input_label);
    }, 500);
    $('a[rel=nofollow]').popup({
      content: function() {
        var buffer, href, method, token;
        method = this.attr('data-method');
        href = this.attr('href');
        token = $('meta[name=csrf-token]').attr('content');
        buffer = ['<form id="js_form_delete" method="post" action="', href, '">'];
        buffer.push('<input name="utf8" type="hidden" value="&#x2713;" />');
        buffer.push('<input name="authenticity_token" type="hidden" value="', token, '" />');
        buffer.push('<input type="hidden" name="_method" value="', method, '"/>');
        buffer.push('你确定要删除吗？');
        buffer.push('<button type="button" class="btn red" onclick="$(\'#js_form_delete\').submit();">确定</button>');
        buffer.push('</form>');
        return buffer.join('');
      }
    });
    return false;
  });

}).call(this);
