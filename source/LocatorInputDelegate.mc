using Toybox.System;
using Toybox.WatchUi as Ui;

class LocatorInputDelegate extends Ui.BehaviorDelegate {
	
	var view;

	function initialize(_view) {
		BehaviorDelegate.initialize();
		view = _view;
	}

    function onKey(keyEvent) {
        System.println(keyEvent.getKey());         // e.g. KEY_MENU = 7
        if (keyEvent.getKey() == 4) {
        	var greylineView = new LocatorGreylineView();
        	var delegate = new LocatorInputDelegate(view);
        	var transition = Ui.SLIDE_RIGHT;
        	Ui.pushView(greylineView, delegate, transition);
        }
        
        return true;
    }
    
    function onBack() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
        return false;
    }
}