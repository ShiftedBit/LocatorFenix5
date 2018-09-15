using Toybox.Application;

class LocatorApp extends Application.AppBase {

	var locatorInputDelegate;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	var view = new LocatorView();
        return [ view, new LocatorInputDelegate(view)];
    }

}