(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

require('jQuery');

require('transit');

$(function() {
  this.MAX_REGISTER_NUM = 30;
  $('li>span').hide();
  this.counter = Math.floor(Math.random() * 4);
  this.winW = $(window).width();
  this.winH = $(window).height();
  this.lastCalledNumbers = [1, 2, 3, 4, 5];
  window.speechSynthesis.getVoices();
  this.callCustomer = (function(_this) {
    return function() {
      var elm, elmH, femaleVoice, maleVoice, msg, num, voice, voices, _i, _len;
      _this.counter = (_this.counter + 1) % 4;
      while (true) {
        num = Math.floor(Math.random() * _this.MAX_REGISTER_NUM) + 1;
        if (!(__indexOf.call(_this.lastCalledNumbers, num) >= 0)) {
          break;
        }
      }
      elm = $('li>span').eq(_this.counter);
      elm.html(num);
      elmH = elm.height();
      elm.show();
      elm.transition({
        y: -elmH
      }, 0).transition({
        y: _this.winH / 2 - elmH / 2
      }, 500);
      elm.transition({
        y: _this.winH + elmH,
        delay: 1500
      }, 500, function() {
        return elm.hide();
      });
      if (window.speechSynthesis) {
        msg = new SpeechSynthesisUtterance("Register " + num);
        voices = window.speechSynthesis.getVoices();
        for (_i = 0, _len = voices.length; _i < _len; _i++) {
          voice = voices[_i];
          switch (voice.name) {
            case "Alex":
              maleVoice = voice;
              break;
            case "Vicki":
              femaleVoice = voice;
          }
        }
        msg.rate = 0.90;
        msg.pitch = 1.05;
        if (Math.random() < 0.2) {
          msg.voice = femaleVoice;
        } else {
          msg.voice = maleVoice;
        }
        window.speechSynthesis.speak(msg);
      }
      _this.lastCalledNumbers.shift();
      _this.lastCalledNumbers.push(num);
      return setTimeout(_this.callCustomer, 2000 + Math.random() * 15000);
    };
  })(this);
  $(window).on('resize', (function(_this) {
    return function(evt) {
      _this.winW = $(window).width();
      return _this.winH = $(window).height();
    };
  })(this));
  return setTimeout(this.callCustomer, 2000);
});



},{"jQuery":false,"transit":false}]},{},[1]);