(function () {

	var pageId = 0;

	function $(selector) {
		return document.querySelector(selector);
	}

	function addInnerIU(pageId) {
		var innerIU = document.createElement("div");
		innerIU.setAttribute('class', 'IU1');

		$('#IU' + pageId).appendChild(innerIU);

		if (pageId % 2 == 1) {
			innerIU.style.backgroundImage = 'url(resources/image/jo.jpg)'
		}
	}

	function addOuterIU(pageId) {

		var newIU = document.createElement("div");
		newIU.setAttribute('id', 'IU' + pageId);
		document.querySelector('.wrapper').appendChild(newIU);
	}

	window.onscroll = function () {

		var bodyHeight = document.body.clientHeight;
		if ($('#IU' + pageId).clientHeight <= bodyHeight) {
			addInnerIU(pageId);
		} else if (window.scrollY > wrapper.clientHeight - bodyHeight) {
			pageId++;
			addOuterIU(pageId);
			addInnerIU(pageId);
		}
	}
}())