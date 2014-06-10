webshims.register('form-validators', function($, webshims, window, document, undefined, options){
"use strict";
var iValClasses = '.'+ options.iVal.errorClass +', .'+options.iVal.successClass;
(function(){
	if(webshims.refreshCustomValidityRules){
		webshims.error("form-validators already included. please remove custom-validity.js");
	}

	var customValidityRules = {};
	var formReady = false;
	var blockCustom;
	var initTest;
	var elemSels = 'input, select, textarea, fieldset[data-dependent-validation]';
	var onEventTest = function(e){
		webshims.refreshCustomValidityRules(e.target);
	};
	var noValidate = function(){
		return !noValidate.types[this.type];
	};
	noValidate.types = {
		hidden: 1,
		image: 1,
		button: 1,
		reset: 1,
		submit: 1
	};
	
	webshims.customErrorMessages = {};
	webshims.addCustomValidityRule = (function(){
		var timer;
		var reTest = function(){
			$(document.querySelectorAll(elemSels))
				.filter(noValidate)
				.each(function(){
					testValidityRules(this);
				})
			;
		};
		return function(name, test, defaultMessage){
			customValidityRules[name] = test;
			if(!webshims.customErrorMessages[name]){
				webshims.customErrorMessages[name] = [];
				webshims.customErrorMessages[name][''] = defaultMessage || name;
			}
			if(formReady){
				clearTimeout(timer);
				timer = setTimeout(reTest);
			}
		};
	})();
	webshims.refreshCustomValidityRules = function(elem){
		if(!initTest){return;}
		var val, setMessage;
		var data = $(elem).data();
		var message = '';
		var customMismatchedRule = data && data.customMismatchedRule;
		var validity = data && $.prop(elem, 'validity') || {valid: 1};

		if(data && (customMismatchedRule || validity.valid)){
			setMessage = function(message, errorType){
				blockCustom = true;

				if(message){
					data.customMismatchedRule = errorType;

					if(typeof message != 'string'){
						message = webshims.getContentValidationMessage(elem, false, errorType);

						if(message && typeof message == 'object'){
							message = message[errorType];
						}

						if(!message || typeof message != 'string'){
							message = webshims.customErrorMessages[errorType][webshims.activeLang()] || webshims.customErrorMessages[errorType]['']  || message.customError || message.defaultMessage || '';
						}
					}
				} else {
					message = '';
					data.customMismatchedRule = '';
				}

				$(elem).setCustomValidity(message);
				blockCustom = false;
			};
			val = $(elem).val();
			$.each(customValidityRules, function(name, test){
				message = test(elem, val, data, setMessage) || '';
				customMismatchedRule = name;
				if(message){
					return false;
				}
			});
			
			if(data && data.dependentValidation && !data.dependentValidation._init && !data.dependentValidation.masterElement){
				customValidityRules.dependent(elem, val, data, $.noop);
			}
			if(message != 'async' && (message || !validity.valid)){
				setMessage(message, customMismatchedRule);
			}
		}
		return message;
	};
	var testValidityRules = webshims.refreshCustomValidityRules;

	if(typeof document.activeElement != 'unknown'){
		$('body').on('click', function(e){
			if(e.target.type == 'submit'){
				var activeElement = document.activeElement;

				if(activeElement != e.target && $.data(activeElement, 'webshimsswitchvalidityclass')){
					$(activeElement).trigger('updatevalidation.webshims');
				}
			}
		});
	}
	
	webshims.ready('forms form-validation', function(){
		
		$.propHooks.setCustomValidity = {
			get: function(elem){
				if(!blockCustom){
					$.data(elem, 'customMismatchedRule', '');
				}
				return null;
			}
		};

		setTimeout(function(){
			webshims.addReady(function(context, selfElement){
				initTest = true;
				$(context.querySelectorAll(elemSels)).add(selfElement.filter(elemSels))
					.filter(noValidate)
					.each(function(){
						testValidityRules(this);
					})
				;
				
				formReady = true;
			});
			$(document).on('refreshCustomValidityRules', onEventTest);
		}, 29);
		
	});
	
})();

/*
 * adds support for HTML5 constraint validation
 * 	- partial pattern: <input data-partial-pattern="RegExp" />
 *  - creditcard-validation: <input data-luhn="" />
 *  - several dependent-validation patterns (examples):
 *  	- <input type="email" id="mail" /> <input data-dependent-validation='mail' />
 *  	- <input type="date" id="start" data-dependent-validation='{"from": "end", "prop": "max"}' /> <input type="date" id="end" data-dependent-validation='{"from": "start", "prop": "min"}' />
 *  	- <input type="checkbox" id="check" /> <input data-dependent-validation='checkbox' />
 */
(function(){
	var formCFG = webshims.cfg.forms;
	var addCustomValidityRule = webshims.addCustomValidityRule;
	var getId = function(name){
		return document.getElementById(name) || document.getElementsByName(name);
	};
	addCustomValidityRule('partialPattern', function(elem, val, pattern){
		pattern = pattern.partialPattern;
		if(!val || !pattern){return;}
		return !(new RegExp('(' + pattern + ')', 'i').test(val));
	}, 'This format is not allowed here.');
	
	
	addCustomValidityRule('tooShort', function(elem, val, data){
		if(!val || !data.minlength){return;}

		if($.nodeName(elem, 'input')){
			webshims.warn('depreacated data-minlength usage: Use pattern=".{'+ data.minlength +',}" instead.');
		}
		return data.minlength > val.length;
	}, 'Entered value is too short.');

	addCustomValidityRule('grouprequired', function(elem, val, data){
		var form;
		var name = elem.name;
		if(!name || elem.type !== 'checkbox' || !('grouprequired' in data)){return;}

		if(!data.grouprequired || !data.grouprequired.checkboxes){
			data.grouprequired.checkboxes = $( ((form = $.prop(elem, 'form')) && form[name]) || document.getElementsByName(name)).filter('[type="checkbox"]');
			data.grouprequired.checkboxes
				.off('click.groupRequired')
				.on('click.groupRequired', function(){
					webshims.refreshCustomValidityRules(elem);
				})
			;
			data.grouprequired.checkboxes.not(elem).removeData('grouprequired');
		}

		
		return !(data.grouprequired.checkboxes.filter(':checked:enabled')[0]);
	}, 'Please check one of these checkboxes.');
	
	// based on https://sites.google.com/site/abapexamples/javascript/luhn-validation
	addCustomValidityRule('luhn', function(elem, value, data){
		if(!value || (!data || (!('creditcard' in data) && !('luhn' in data)))){return;}
		if(('creditcard' in data)){
			webshims.error('data-creditcard was renamed to data-luhn!!!');
		}
		value = value.replace(/\-/g, "");
		//if it's not numeric return true >- for invalid
		if(value != value * 1){return true;}
		var len = value.length;
		var sum = 0;
		var mul = 1;
		var ca;
	
		while (len--) {
			ca = parseInt(value.charAt(len),10) * mul;
			sum += ca - (ca>9)*9;// sum += ca - (-(ca>9))|9
			// 1 <--> 2 toggle.
			mul ^= 3; // (mul = 3 - mul);
		}
		return !((sum%10 === 0) && (sum > 0));
	}, 'Please enter a valid credit card number');
	
	var dependentDefaults = {
		//"from": "IDREF || UniqueNAMEREF", //required property: element 
		"prop": "value", //default: value||disabled	(last if "from-prop" is checked)
		"from-prop": "value", //default: value||checked (last if element checkbox or radio)
		"toggle": false
	};
	
	var getGroupElements = function(elem) {
		return $(elem.form[elem.name]).filter('[type="radio"]');
	};
	webshims.ready('form-validation', function(){
		if(webshims.modules){
			getGroupElements = webshims.modules["form-core"].getGroupElements || getGroupElements;
		}
	});
	
	addCustomValidityRule('dependent', function(elem, val, data){
		data = data.dependentValidation;
		if( !data ){return;}
		var specialVal;
		var depFn = function(e){
			var val = $.prop(data.masterElement, data["from-prop"]);
			if(specialVal){
				val = $.inArray(val, specialVal) !== -1;
			}
			if(data.toggle){
				val = !val;
			}
			$.prop( elem, data.prop, val);
			if(e){
				$(elem).getShadowElement().filter(iValClasses).trigger('updatevalidation.webshims');
			}
		};
		
		if(!data._init || !data.masterElement){
			
			if(typeof data == 'string'){
				data = {"from": data};
			}
			
			
			data.masterElement = document.getElementById(data["from"]) || (document.getElementsByName(data["from"] || [])[0]);
			data._init = true;
			if (!data.masterElement || !data.masterElement.form) {return;}
			
			if(/radio|checkbox/i.test(data.masterElement.type)){
				if(!data["from-prop"]){
					data["from-prop"] = 'checked';
				}
				if(!data.prop && data["from-prop"] == 'checked'){
					data.prop = 'disabled';
				}
			} else if(!data["from-prop"]){
				data["from-prop"] = 'value';
			}
			
			if(data["from-prop"].indexOf('value:') === 0){
				specialVal = data["from-prop"].replace('value:', '').split('||');
				data["from-prop"] = 'value';
				
			}
			
			data = $.data(elem, 'dependentValidation', $.extend({_init: true}, dependentDefaults, data));

			if(data.prop !== "value" || specialVal){
				$(data.masterElement.type === 'radio' && getGroupElements(data.masterElement) || data.masterElement).on('change', depFn);
			} else {
				$(data.masterElement).on('change', function(){
					webshims.refreshCustomValidityRules(elem);
					$(elem)
						.getShadowElement()
						.filter(iValClasses)
						.trigger('updatevalidation.webshims')
					;
				});
			}
		}

		if(data.prop == "value" && !specialVal){
			return ($.prop(data.masterElement, 'value') != val);
		} else {
			depFn();
			return '';
		}
		
	}, 'The value of this field does not repeat the value of the other field');

	addCustomValidityRule('valuevalidation', function(elem, val, data){
		if(val && ('valuevalidation' in data)){
			//Todo allow markup params
			return $(elem).triggerHandler('valuevalidation', [{value: val, valueAsDate: $.prop(elem, 'valueAsDate'), isPartial: false}]) || '';
		}
	}, 'This value is not allowed here');

	if(window.JSON){
		addCustomValidityRule('ajaxvalidate', function(elem, val, data){
			if(!val || !data.ajaxvalidate){return;}
			var opts;
			if(!data.remoteValidate){
				webshims.loader.loadList(['jajax']);
				if(typeof data.ajaxvalidate == 'string'){
					data.ajaxvalidate = {url: data.ajaxvalidate, depends: $([])};
				} else {
					data.ajaxvalidate.depends = data.ajaxvalidate.depends ?
						$(typeof data.ajaxvalidate.depends == 'string' && data.ajaxvalidate.depends.split(' ') || data.ajaxvalidate.depends).map(getId) :
						$([])
					;
				}
				
				data.ajaxvalidate.depends.on('refreshCustomValidityRules', function(){
					webshims.refreshCustomValidityRules(elem);
				});
				
				opts = data.ajaxvalidate;
				
				var remoteValidate = {
					ajaxLoading: false,
					restartAjax: false,
					message: 'async',
					cache: {},
					update: function(remoteData){
						if(this.ajaxLoading){
							this.restartAjax = remoteData;
						} else {
							this.restartAjax = false;
							this.ajaxLoading = true;
							$.ajax(
								$.extend({dataType: 'json'}, opts, {
									url: opts.url,
									depData: remoteData,
									data: formCFG.fullRemoteForm || opts.fullForm ?
										$(elem).jProp('form').serializeArray() :
										remoteData,
									success: this.getResponse,
									complete: this._complete,
									timeout: 3000
								})
							);
						}
					},
					_complete: function(){
						remoteValidate.ajaxLoading = false;
						if(remoteValidate.restartAjax){
							this.update(remoteValidate.restartAjax);
						}
						remoteValidate.restartAjax = false;
					},
					getResponse: function(data){
						if(options.transformAjaxValidate){
							data = options.transformAjaxValidate(data);
						}
						if(!data){
							data = {message: '', valid: true};
						} else if(typeof data == 'string'){
							try {
								data = JSON.parse(data);
							} catch (er){}
						}
						
						remoteValidate.message = ('message' in data) ? data.message : !data.valid;
						remoteValidate.lastMessage = remoteValidate.message;
						remoteValidate.blockUpdate = true;
						$(elem).triggerHandler('updatevalidation.webshims');
						remoteValidate.message = 'async';
						remoteValidate.blockUpdate = false;
					},
					getData: function(){
						var data;
						data = {};
						data[$.prop(elem, 'name') || $.prop(elem, 'id')] = $(elem).val();
						opts.depends.each(function(){
							if($(this).is(':invalid')){
								data = false;
								return false;
							}
							data[$.prop(this, 'name') || $.prop(this, 'id')] = $(this).val();
						});
						return data;
					},
					getTempMessage: function(){
						var message = 'async';
						var remoteData, dataStr;
						if(!data.remoteValidate.blockUpdate){
							remoteData = this.getData();
							if(!remoteData){
								message = '';
							} else {
								try {
									dataStr = JSON.stringify(remoteData);
								} catch(er){}
								
								if(dataStr === this.lastString){
									message = this.ajaxLoading ? 'async' : this.lastMessage;
								} else {
									this.lastString = dataStr;
									this.lastMessage = 'async';
									clearTimeout(data.remoteValidate.timer);
									data.remoteValidate.timer = setTimeout(function(){
										data.remoteValidate.update(remoteData);
									}, 9);
								}
								
							}
						} else {
							message = remoteValidate.message;
						}
						return message;
					}
				};
				data.remoteValidate = remoteValidate;
			}
			
			return data.remoteValidate.getTempMessage();
		}, 'remote error');
	}
})();

});
