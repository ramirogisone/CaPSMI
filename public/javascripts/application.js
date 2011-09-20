// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function setFocusDefault() {
	if (document.forms[0] == null) return;
	for (var i = 0; i < document.forms[0].elements.length; i++) {
		e = document.forms[0].elements[i];
		if (((e.type == "text") || (e.type == "textarea")) && (!e.disabled)) {
			e.focus();
			break;
		}
	}
}

function setFocusNewTarja() {
	if (document.forms[0] == null) return;
	for (var i = 0; i < document.forms[0].elements.length; i++) {
		e = document.forms[0].elements[i];
		switch(e.name) {
			case "tarja[entrada]":
				e.focus();
				break;
			case "tarja[tipo_de_tarja_id]":
				e.focus();
				break;
			case "tarja[fecha]":
				if (e.value == '') {
					e.focus();
					return;
				}
			case "tarja[numero_legajo]":
				e.focus();
				break;
		}
	}
}

function setFocusInformarRegularidad() {
	if (document.forms[0] == null) return;
	for (var i = 0; i < document.forms[0].elements.length; i++) {
		e = document.forms[0].elements[i];
		switch(e.name) {
			case "formulario[desde]":
				e.focus();
			case "formulario[numero_legajo]":
				if (e.value != '') {
					e.focus();
				}
		}
	}
}
